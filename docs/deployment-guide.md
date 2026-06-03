# Deployment Guide

## Español

### Objetivo

Este documento describe cómo desplegar el artefacto `aws-backup-critical-events-to-hub` usando AWS CloudFormation.

La solución permite capturar eventos críticos de AWS Backup, procesarlos con AWS Lambda y reenviarlos hacia un hub central de eventos, monitoreo o notificaciones.

### Prerrequisitos

Antes de desplegar, validar que existan:

- Cuenta AWS activa.
- Permisos para crear recursos IAM.
- Permisos para crear AWS Lambda.
- Permisos para crear EventBridge Rules.
- Permisos para crear CloudWatch Log Groups.
- AWS CLI configurado.
- Endpoint del hub disponible.
- Token o mecanismo de autenticación para el hub.

### Validar identidad AWS

```bash
aws sts get-caller-identity
```

### Validar template CloudFormation

```bash
aws cloudformation validate-template \
  --template-body file://cloudformation/aws-backup-critical-events-to-hub.yaml
```

### Despliegue demo

```bash
aws cloudformation deploy \
  --template-file cloudformation/aws-backup-critical-events-to-hub.yaml \
  --stack-name aws-backup-critical-events-to-hub-demo \
  --parameter-overrides file://parameters/parameters-demo.json \
  --capabilities CAPABILITY_NAMED_IAM
```

### Despliegue productivo

Para producción, no usar directamente `parameters-prod.example.json`.

Crear un archivo local no versionado:

```text
parameters/parameters-prod.json
```

Ese archivo debe contener los valores reales aprobados por la organización, pero no debe subirse al repositorio.

Ejemplo de despliegue productivo:

```bash
aws cloudformation deploy \
  --template-file cloudformation/aws-backup-critical-events-to-hub.yaml \
  --stack-name aws-backup-critical-events-to-hub-prod \
  --parameter-overrides file://parameters/parameters-prod.json \
  --capabilities CAPABILITY_NAMED_IAM
```

### Validaciones posteriores

Validar que se hayan creado los siguientes recursos:

- AWS Lambda Function.
- Amazon EventBridge Rule.
- IAM Role para Lambda.
- CloudWatch Log Group.
- Permiso para que EventBridge invoque Lambda.

Comando sugerido:

```bash
aws events list-rules \
  --name-prefix aws-backup-critical-events-to-hub
```

Validar función Lambda:

```bash
aws lambda list-functions \
  --query "Functions[?contains(FunctionName, 'aws-backup-critical-events-to-hub')]"
```

### Prueba funcional

Usar un evento de ejemplo:

```bash
aws lambda invoke \
  --function-name aws-backup-critical-events-to-hub-demo \
  --payload file://examples/eventbridge-backup-failed-event.json \
  response.json
```

Luego validar:

```bash
cat response.json
```

### Revisión de logs

Consultar logs en CloudWatch:

```bash
aws logs describe-log-groups \
  --log-group-name-prefix /aws/lambda/aws-backup-critical-events-to-hub
```

### Rollback

Para eliminar el stack demo:

```bash
aws cloudformation delete-stack \
  --stack-name aws-backup-critical-events-to-hub-demo
```

### Consideraciones de seguridad

No subir al repositorio:

- Tokens reales.
- URLs internas productivas.
- Credenciales AWS.
- ARNs reales productivos.
- Logs reales.
- Información de clientes.
- Correos internos.

---

## Deutsch

### Ziel

Dieses Dokument beschreibt die Bereitstellung des Artefakts `aws-backup-critical-events-to-hub` mit AWS CloudFormation.

Die Lösung erfasst kritische AWS-Backup-Ereignisse, verarbeitet sie mit AWS Lambda und leitet sie an einen zentralen Event-, Monitoring- oder Benachrichtigungs-Hub weiter.

### Voraussetzungen

Vor der Bereitstellung prüfen:

- Aktives AWS-Konto.
- Berechtigungen zum Erstellen von IAM-Ressourcen.
- Berechtigungen zum Erstellen von AWS Lambda.
- Berechtigungen zum Erstellen von EventBridge Rules.
- Berechtigungen zum Erstellen von CloudWatch Log Groups.
- Konfigurierte AWS CLI.
- Verfügbarer Hub-Endpunkt.
- Token oder Authentifizierungsmechanismus für den Hub.

### Sicherheitshinweis

Keine sensiblen Daten in das Repository hochladen:

- Echte Tokens.
- Interne produktive URLs.
- AWS-Zugangsdaten.
- Reale produktive ARNs.
- Echte Logs.
- Kundendaten.
- Interne E-Mail-Adressen.

**Traducción al español:**  
Esta sección alemana explica los objetivos, requisitos y controles de seguridad para desplegar el artefacto con CloudFormation.

---

## English

### Objective

This document describes how to deploy the `aws-backup-critical-events-to-hub` artifact using AWS CloudFormation.

The solution captures critical AWS Backup events, processes them with AWS Lambda and forwards them to a central event, monitoring or notification hub.

### Prerequisites

Before deployment, validate:

- Active AWS account.
- Permissions to create IAM resources.
- Permissions to create AWS Lambda.
- Permissions to create EventBridge Rules.
- Permissions to create CloudWatch Log Groups.
- AWS CLI configured.
- Available hub endpoint.
- Token or authentication mechanism for the hub.

### Security Considerations

Do not upload sensitive data to the repository:

- Real tokens.
- Internal production URLs.
- AWS credentials.
- Real production ARNs.
- Real logs.
- Customer information.
- Internal email addresses.
