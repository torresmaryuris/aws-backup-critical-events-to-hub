import json
import os
import urllib.error
import urllib.request
from datetime import datetime, timezone


CRITICAL_STATES = {"FAILED", "ABORTED", "EXPIRED", "PARTIAL"}


def lambda_handler(event, context):
    """
    Process critical AWS Backup events and forward them to a central hub.
    """

    print("Received event:")
    print(json.dumps(event))

    detail = event.get("detail", {})
    state = detail.get("state", "UNKNOWN")

    if state not in CRITICAL_STATES:
        print(f"Ignored non-critical state: {state}")
        return {
            "statusCode": 200,
            "body": json.dumps(
                {
                    "message": "Event ignored because state is not critical",
                    "state": state,
                }
            ),
        }

    hub_message = build_hub_message(event, detail, state)
    send_to_hub(hub_message)

    return {
        "statusCode": 200,
        "body": json.dumps(
            {
                "message": "Critical backup event forwarded to hub",
                "state": state,
                "backup_job_id": detail.get("backupJobId"),
            }
        ),
    }


def build_hub_message(event, detail, state):
    """
    Build a normalized message for the central hub.
    """

    return {
        "source": "aws.backup",
        "event_type": "backup_job_critical_status",
        "severity": "critical",
        "environment": os.environ.get("ENVIRONMENT", "unknown"),
        "project": os.environ.get("PROJECT_NAME", "unknown"),
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "aws_region": event.get("region"),
        "aws_account": event.get("account"),
        "raw_event_id": event.get("id"),
        "backup": {
            "backup_job_id": detail.get("backupJobId"),
            "backup_vault_name": detail.get("backupVaultName"),
            "resource_arn": detail.get("resourceArn"),
            "resource_type": detail.get("resourceType"),
            "state": state,
            "status_message": detail.get("statusMessage"),
            "creation_date": detail.get("creationDate"),
            "completion_date": detail.get("completionDate"),
        },
    }


def send_to_hub(message):
    """
    Send the normalized message to the configured hub endpoint.
    """

    hub_url = os.environ["HUB_ENDPOINT_URL"]
    token = os.environ["HUB_AUTH_TOKEN"]

    data = json.dumps(message).encode("utf-8")

    request = urllib.request.Request(
        hub_url,
        data=data,
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {token}",
        },
        method="POST",
    )

    try:
        with urllib.request.urlopen(request, timeout=10) as response:
            response_body = response.read().decode("utf-8")
            print(f"Hub response status: {response.status}")
            print(f"Hub response body: {response_body}")

    except urllib.error.HTTPError as error:
        print(f"HTTP error sending event to hub: {error.code}")
        print(error.read().decode("utf-8"))
        raise

    except urllib.error.URLError as error:
        print(f"URL error sending event to hub: {error.reason}")
        raise
