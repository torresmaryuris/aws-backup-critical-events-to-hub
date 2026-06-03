# Architecture

## Español

### Descripción general

Esta solución monitorea eventos críticos de AWS Backup y los reenvía hacia un hub central.

El objetivo es permitir que fallas de backup, jobs abortados, expirados o parcialmente completados puedan ser tratados como eventos operativos críticos.

### Arquitectura lógica

```text
+-------------+       +-------------------+       +-------------+       +----------------+
| AWS Backup  | ----> | Amazon EventBridge| ----> | AWS Lambda  | ----> | Central Hub    |
+-------------+       +-------------------+       +-------------+       +----------------+
                                                                          |
                                                                          v
                                                        Monitoring / Ticketing / Alerts
```

### Componentes

#### AWS Backup

AWS Backup genera eventos cuando los jobs de backup cambian de estado.

#### Amazon EventBridge

EventBridge captura los eventos con:

```text
source: aws.backup
detail-type: Backup Job State Change
```

La regla filtra estados críticos:

```text
FAILED
ABORTED
EXPIRED
PARTIAL
```

#### AWS Lambda

Lambda recibe el evento, valida el estado, normaliza el payload y lo envía al hub central.

#### Central Hub

El hub central representa una plataforma interna o externa que recibe eventos operativos. Puede integrarse con:

- Sistema de monitoreo.
- Plataforma de alertas.
- Herramienta de ticketing.
- Dashboard operativo.
- Sistema de observabilidad.

### Seguridad

- Los valores sensibles se pasan como parámetros.
- El token del hub se define como `NoEcho` en CloudFormation.
- No se almacenan credenciales reales en GitHub.
- IAM se limita a permisos necesarios para logs.
- EventBridge solo puede invocar la Lambda objetivo.

### Consideraciones operativas

- Validar logs después del despliegue.
- Monitorear códigos de respuesta del hub.
- Ajustar timeout de Lambda según la latencia del hub.
- Considerar DLQ o mecanismo de retry para entornos productivos.
- Validar cumplimiento RPO/RTO después de eventos críticos.

---

## Deutsch

### Übersicht

Diese Lösung überwacht kritische AWS-Backup-Ereignisse und leitet sie an einen zentralen Hub weiter.

Ziel ist es, fehlgeschlagene, abgebrochene, abgelaufene oder teilweise abgeschlossene Backup-Jobs als kritische operative Ereignisse zu behandeln.

### Logische Architektur

```text
+-------------+       +-------------------+       +-------------+       +----------------+
| AWS Backup  | ----> | Amazon EventBridge| ----> | AWS Lambda  | ----> | Zentraler Hub  |
+-------------+       +-------------------+       +-------------+       +----------------+
                                                                          |
                                                                          v
                                                        Monitoring / Ticketing / Alerts
```

### Komponenten

- AWS Backup.
- Amazon EventBridge.
- AWS Lambda.
- Zentraler Event-Hub.
- CloudWatch Logs.
- IAM Role.

**Traducción al español:**  
Esta sección describe la arquitectura lógica del artefacto: AWS Backup emite eventos, EventBridge los filtra, Lambda los procesa y el hub central los distribuye hacia monitoreo, alertas o ticketing.

---

## English

### Overview

This solution monitors critical AWS Backup events and forwards them to a central hub.

The objective is to treat failed, aborted, expired or partially completed backup jobs as critical operational events.

### Logical Architecture

```text
+-------------+       +-------------------+       +-------------+       +----------------+
| AWS Backup  | ----> | Amazon EventBridge| ----> | AWS Lambda  | ----> | Central Hub    |
+-------------+       +-------------------+       +-------------+       +----------------+
                                                                          |
                                                                          v
                                                        Monitoring / Ticketing / Alerts
```

### Components

- AWS Backup.
- Amazon EventBridge.
- AWS Lambda.
- Central Event Hub.
- CloudWatch Logs.
- IAM Role.

### Operational Considerations

- Review CloudWatch Logs after deployment.
- Monitor hub response codes.
- Validate failed backup events.
- Review RPO/RTO impact.
- Add retry or DLQ strategy for production workloads.
