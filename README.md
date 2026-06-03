# AWS Backup Critical Events to Hub

---

## Español

### Descripción

Este artefacto implementa una solución serverless para monitorear eventos críticos de AWS Backup, procesarlos y reenviarlos hacia un hub central de eventos, monitoreo o notificaciones.

La solución captura eventos generados por AWS Backup mediante Amazon EventBridge, filtra estados críticos como `FAILED`, `ABORTED`, `EXPIRED` y `PARTIAL`, procesa el contenido con una función AWS Lambda y envía un mensaje normalizado hacia un hub externo mediante HTTP.

### Objetivo

El objetivo principal es mejorar la visibilidad operativa sobre fallas de backup, permitiendo que los eventos críticos sean centralizados en una plataforma de monitoreo, alertamiento, ticketing o dashboard corporativo.

### Flujo de arquitectura

```text
AWS Backup
   ↓
Amazon EventBridge
   ↓
AWS Lambda
   ↓
Hub central de eventos
   ↓
Monitoreo / Alertas / Ticketing / Dashboard
```

### Componentes principales

- Amazon EventBridge Rule
- AWS Lambda
- IAM Role para Lambda
- CloudWatch Logs
- Variables de entorno seguras
- Parámetros CloudFormation
- Ejemplos de eventos críticos

### Estados críticos monitoreados

- `FAILED`
- `ABORTED`
- `EXPIRED`
- `PARTIAL`

### Casos de uso

- Monitoreo de jobs fallidos de AWS Backup.
- Centralización de alertas operativas.
- Integración con un hub de eventos corporativo.
- Evidencia para continuidad operativa.
- Validación de cumplimiento RPO/RTO.
- Mejora de observabilidad en plataformas cloud.

### Seguridad

Este repositorio no debe contener datos sensibles como credenciales, tokens reales, URLs productivas internas, ARNs reales, logs reales, correos internos o información de clientes.

Usar siempre valores de ejemplo como:

```text
https://example-hub.company.com/events
arn:aws:backup:eu-central-1:123456789012:backup-vault:example-vault
123456789012
example-token
```

---

## Deutsch

### Beschreibung

Dieses Artefakt implementiert eine serverlose Lösung zur Überwachung kritischer AWS-Backup-Ereignisse, deren Verarbeitung und Weiterleitung an einen zentralen Event-, Monitoring- oder Benachrichtigungs-Hub.

Die Lösung erfasst von AWS Backup erzeugte Ereignisse über Amazon EventBridge, filtert kritische Status wie `FAILED`, `ABORTED`, `EXPIRED` und `PARTIAL`, verarbeitet die Daten mit einer AWS-Lambda-Funktion und sendet eine normalisierte Nachricht an einen externen Hub über HTTP.

### Ziel

Das Hauptziel ist die Verbesserung der operativen Transparenz bei Backup-Fehlern, damit kritische Ereignisse zentral in einer Monitoring-, Alerting-, Ticketing- oder Dashboard-Plattform verarbeitet werden können.

### Architekturfluss

```text
AWS Backup
   ↓
Amazon EventBridge
   ↓
AWS Lambda
   ↓
Zentraler Event-Hub
   ↓
Monitoring / Alerts / Ticketing / Dashboard
```

### Hauptkomponenten

- Amazon EventBridge Rule
- AWS Lambda
- IAM Role für Lambda
- CloudWatch Logs
- Sichere Umgebungsvariablen
- CloudFormation-Parameter
- Beispiele für kritische Ereignisse

### Überwachte kritische Status

- `FAILED`
- `ABORTED`
- `EXPIRED`
- `PARTIAL`

### Anwendungsfälle

- Überwachung fehlgeschlagener AWS-Backup-Jobs.
- Zentralisierung operativer Alarme.
- Integration mit einem zentralen Event-Hub.
- Nachweis für operative Kontinuität.
- Validierung von RPO/RTO-Anforderungen.
- Verbesserung der Observability in Cloud-Plattformen.

### Sicherheit

Dieses Repository darf keine sensiblen Daten enthalten, wie echte Zugangsdaten, Tokens, interne produktive URLs, reale ARNs, echte Logs, interne E-Mail-Adressen oder Kundendaten.

Immer Beispielwerte verwenden, zum Beispiel:

```text
https://example-hub.company.com/events
arn:aws:backup:eu-central-1:123456789012:backup-vault:example-vault
123456789012
example-token
```

**Traducción al español:**  
Este bloque dice lo mismo que la sección en español. Explica que el artefacto monitorea eventos críticos de AWS Backup, los procesa con Lambda y los reenvía a un hub central.

---

## English

### Description

This artifact implements a serverless solution to monitor critical AWS Backup events, process them, and forward them to a centralized event, monitoring, or notification hub.

The solution captures AWS Backup events through Amazon EventBridge, filters critical statuses such as `FAILED`, `ABORTED`, `EXPIRED`, and `PARTIAL`, processes the payload with an AWS Lambda function, and sends a normalized message to an external hub over HTTP.

### Objective

The main objective is to improve operational visibility over backup failures, allowing critical events to be centralized into a corporate monitoring, alerting, ticketing, or dashboard platform.

### Architecture Flow

```text
AWS Backup
   ↓
Amazon EventBridge
   ↓
AWS Lambda
   ↓
Central Event Hub
   ↓
Monitoring / Alerts / Ticketing / Dashboard
```

### Main Components

- Amazon EventBridge Rule
- AWS Lambda
- IAM Role for Lambda
- CloudWatch Logs
- Secure environment variables
- CloudFormation parameters
- Critical event examples

### Critical Statuses Monitored

- `FAILED`
- `ABORTED`
- `EXPIRED`
- `PARTIAL`

### Use Cases

- Monitoring failed AWS Backup jobs.
- Centralizing operational alerts.
- Integrating with a corporate event hub.
- Providing evidence for operational continuity.
- Validating RPO/RTO requirements.
- Improving observability in cloud platforms.

### Security

This repository must not contain sensitive data such as real credentials, real tokens, internal production URLs, real ARNs, real logs, internal email addresses or customer information.

Always use example values such as:

```text
https://example-hub.company.com/events
arn:aws:backup:eu-central-1:123456789012:backup-vault:example-vault
123456789012
example-token
```

---

## Repository Structure

```text
aws-backup-critical-events-to-hub/
│
├── README.md
├── .gitignore
│
├── cloudformation/
│   └── aws-backup-critical-events-to-hub.yaml
│
├── lambda/
│   ├── src/
│   │   └── app.py
│   └── requirements.txt
│
├── parameters/
│   ├── parameters-demo.json
│   └── parameters-prod.example.json
│
├── docs/
│   ├── deployment-guide.md
│   ├── architecture.md
│   ├── event-flow.md
│   ├── backup-job-status.md
│   └── rpo-rto-matrix.md
│
├── examples/
│   ├── eventbridge-backup-failed-event.json
│   ├── eventbridge-backup-aborted-event.json
│   └── hub-message-example.json
│
└── checklists/
    └── backup-validation-checklist.md
```

## Final Notes

This repository is designed as a safe reference artifact for cloud operations, backup monitoring and operational observability.

Before using it in a real environment, replace all example values with approved secure configuration values and follow the organization’s deployment, security and change management processes.
