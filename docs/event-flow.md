# Event Flow

## Español

### Propósito

Este documento explica cómo los eventos críticos de AWS Backup son capturados, procesados y reenviados hacia un hub central.

### Flujo

```text
1. AWS Backup job cambia de estado.
2. AWS Backup emite un evento.
3. Amazon EventBridge evalúa el patrón del evento.
4. Si el estado es crítico, EventBridge invoca Lambda.
5. Lambda normaliza el evento.
6. Lambda envía el mensaje al hub.
7. El hub enruta el evento hacia monitoreo, alertas, ticketing o dashboards.
```

### Estados críticos

| Estado | Significado |
|---|---|
| FAILED | El backup job falló. |
| ABORTED | El backup job fue interrumpido o cancelado. |
| EXPIRED | El backup job no completó dentro de la ventana esperada. |
| PARTIAL | El backup job se completó solo parcialmente. |

### Mensaje normalizado hacia el hub

```json
{
  "source": "aws.backup",
  "event_type": "backup_job_critical_status",
  "severity": "critical",
  "environment": "demo",
  "project": "aws-backup-critical-events-to-hub",
  "timestamp": "2026-01-01T12:00:00Z",
  "aws_region": "eu-central-1",
  "aws_account": "123456789012",
  "raw_event_id": "example-event-id",
  "backup": {
    "backup_job_id": "example-backup-job-id",
    "backup_vault_name": "example-backup-vault",
    "resource_arn": "arn:aws:ec2:eu-central-1:123456789012:volume/vol-example",
    "resource_type": "EBS",
    "state": "FAILED",
    "status_message": "Backup job failed due to example reason.",
    "creation_date": "2026-01-01T11:00:00Z",
    "completion_date": "2026-01-01T12:00:00Z"
  }
}
```

### Manejo de errores

Si Lambda no puede enviar el evento al hub:

- El error queda registrado en CloudWatch Logs.
- Lambda levanta una excepción.
- El equipo operativo debe revisar la invocación fallida.
- En producción se recomienda agregar DLQ o mecanismo de retry.

---

## Deutsch

### Zweck

Dieses Dokument erklärt, wie kritische AWS-Backup-Ereignisse erfasst, verarbeitet und an einen zentralen Hub weitergeleitet werden.

### Ablauf

```text
1. Ein AWS-Backup-Job ändert seinen Status.
2. AWS Backup erzeugt ein Ereignis.
3. Amazon EventBridge prüft das Ereignismuster.
4. Bei kritischem Status ruft EventBridge Lambda auf.
5. Lambda normalisiert das Ereignis.
6. Lambda sendet die Nachricht an den Hub.
7. Der Hub leitet das Ereignis an Monitoring, Alerts, Ticketing oder Dashboards weiter.
```

**Traducción al español:**  
Esta sección explica el flujo del evento desde AWS Backup hasta el hub central, pasando por EventBridge y Lambda.

---

## English

### Purpose

This document explains how critical AWS Backup events are captured, processed and forwarded to a central hub.

### Flow

```text
1. AWS Backup job changes state.
2. AWS Backup emits an event.
3. Amazon EventBridge evaluates the event pattern.
4. If the state is critical, EventBridge invokes Lambda.
5. Lambda normalizes the event.
6. Lambda sends the message to the hub.
7. The hub routes the event to monitoring, alerting, ticketing or dashboards.
```

### Critical States

| State | Meaning |
|---|---|
| FAILED | Backup job failed. |
| ABORTED | Backup job was interrupted or cancelled. |
| EXPIRED | Backup job did not complete within the expected window. |
| PARTIAL | Backup job completed only partially. |

### Error Handling

If Lambda cannot send the message to the hub:

- The error is logged in CloudWatch Logs.
- Lambda raises an exception.
- Operations teams should review failed invocations.
- For production, DLQ or retry mechanisms are recommended.
