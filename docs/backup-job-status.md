# AWS Backup Job Status Reference

## Español

### Propósito

Este documento describe los estados relevantes de AWS Backup usados por el artefacto de monitoreo.

### Estados críticos

| Estado | Severidad | Descripción | Acción operativa |
|---|---|---|---|
| FAILED | Crítica | El backup job falló y no se creó un recovery point válido. | Investigar inmediatamente. Validar mensaje de error, recurso afectado y backup plan. |
| ABORTED | Crítica | El backup job fue detenido antes de completarse correctamente. | Confirmar si fue manual, automático o causado por interrupción del servicio. |
| EXPIRED | Crítica | El backup job excedió la ventana permitida de inicio o finalización. | Revisar ventana de backup, disponibilidad del recurso y conflictos de planificación. |
| PARTIAL | Crítica | El backup se completó solo parcialmente. | Validar recursos afectados y confirmar si se requiere un nuevo backup. |

### Estados no críticos

| Estado | Severidad | Descripción |
|---|---|---|
| CREATED | Informativa | El backup job fue creado. |
| PENDING | Informativa | El backup job está esperando iniciar. |
| RUNNING | Informativa | El backup job está en ejecución. |
| COMPLETED | Normal | El backup job finalizó correctamente. |

### Respuesta operativa recomendada

Para cada evento crítico:

1. Identificar el recurso afectado.
2. Revisar el backup vault.
3. Revisar detalles del backup job.
4. Consultar CloudWatch Logs.
5. Validar si existe recovery point.
6. Reejecutar el backup si corresponde.
7. Registrar incidente o evidencia operativa.
8. Evaluar impacto sobre RPO/RTO.

### Preguntas para investigación

- ¿Qué recurso falló?
- ¿Qué backup vault fue usado?
- ¿La falla fue aislada o repetida?
- ¿Afectó producción?
- ¿Se incumplió el RPO?
- ¿Se requiere backup manual?
- ¿Debe generarse un ticket?

---

## Deutsch

### Zweck

Dieses Dokument beschreibt relevante AWS-Backup-Job-Status, die vom Monitoring-Artefakt verwendet werden.

### Kritische Status

| Status | Schweregrad | Beschreibung | Operative Aktion |
|---|---|---|---|
| FAILED | Kritisch | Der Backup-Job ist fehlgeschlagen. | Sofort untersuchen. |
| ABORTED | Kritisch | Der Backup-Job wurde vor Abschluss beendet. | Ursache prüfen. |
| EXPIRED | Kritisch | Der Backup-Job hat das erlaubte Zeitfenster überschritten. | Backup-Fenster prüfen. |
| PARTIAL | Kritisch | Der Backup-Job wurde nur teilweise abgeschlossen. | Betroffene Ressourcen prüfen. |

**Traducción al español:**  
Esta sección alemana resume los estados críticos de AWS Backup y la acción operativa recomendada.

---

## English

### Purpose

This document describes relevant AWS Backup job statuses used by the monitoring artifact.

### Critical Statuses

| Status | Severity | Description | Operational Action |
|---|---|---|---|
| FAILED | Critical | The backup job failed and no valid recovery point was created. | Investigate immediately. Validate error message, affected resource and backup plan. |
| ABORTED | Critical | The backup job was stopped before successful completion. | Confirm whether it was manual, automated or caused by service interruption. |
| EXPIRED | Critical | The backup job exceeded its allowed start or completion window. | Review backup window, resource availability and scheduling conflicts. |
| PARTIAL | Critical | The backup completed only part of the expected scope. | Validate affected resources and confirm whether a new backup is required. |

### Non-Critical Statuses

| Status | Severity | Description |
|---|---|---|
| CREATED | Informational | Backup job was created. |
| PENDING | Informational | Backup job is waiting to start. |
| RUNNING | Informational | Backup job is currently running. |
| COMPLETED | Normal | Backup job completed successfully. |

### Recommended Operational Response

For every critical backup event:

1. Identify the affected resource.
2. Review the backup vault.
3. Review the backup job details.
4. Check CloudWatch Logs.
5. Validate whether a recovery point exists.
6. Re-run the backup if required.
7. Register incident or operational evidence.
8. Validate RPO/RTO impact.
