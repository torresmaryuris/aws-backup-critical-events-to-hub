# RPO / RTO Matrix

## Español

### Propósito

Este documento entrega una matriz simple de referencia RPO/RTO para monitoreo de backups y validación operativa.

### Definiciones

| Término | Significado |
|---|---|
| RPO | Recovery Point Objective. Máxima pérdida aceptable de datos medida en tiempo. |
| RTO | Recovery Time Objective. Máximo tiempo aceptable para restaurar un servicio. |

### Matriz de ejemplo

| Tipo de workload | Servicio de ejemplo | RPO sugerido | RTO sugerido | Prioridad backup |
|---|---|---:|---:|---|
| Producción crítica | Base de datos, ERP, pagos | 1 hora | 4 horas | Alta |
| Producción importante | APIs, aplicaciones de negocio | 4 horas | 8 horas | Alta |
| Producción estándar | Aplicaciones internas | 24 horas | 24 horas | Media |
| No productivo | Dev, QA, Testing | 24-48 horas | Best effort | Baja |

### Impacto por evento de backup

| Estado | Impacto potencial en RPO | Impacto potencial en RTO | Acción |
|---|---|---|---|
| FAILED | Alto | Medio a alto | Investigar y reejecutar backup. |
| ABORTED | Alto | Medio | Validar causa y reintentar si corresponde. |
| EXPIRED | Medio a alto | Medio | Revisar ventana de backup y planificación. |
| PARTIAL | Medio | Medio | Identificar recursos faltantes. |

### Notas operativas

- Un backup fallido no siempre implica impacto inmediato en servicio.
- Fallas repetidas aumentan la exposición del RPO.
- Workloads críticos requieren monitoreo y escalamiento adicional.
- El éxito del backup debe validarse contra objetivos de recuperación.

---

## Deutsch

### Zweck

Dieses Dokument enthält eine einfache RPO/RTO-Referenzmatrix für Backup-Monitoring und operative Validierung.

### Definitionen

| Begriff | Bedeutung |
|---|---|
| RPO | Maximale akzeptable Datenverlustzeit. |
| RTO | Maximale akzeptable Wiederherstellungszeit eines Services. |

**Traducción al español:**  
Esta sección explica los conceptos RPO/RTO y su relación con eventos críticos de backup.

---

## English

### Purpose

This document provides a simple RPO/RTO reference matrix for backup monitoring and operational validation.

### Definitions

| Term | Meaning |
|---|---|
| RPO | Recovery Point Objective. Maximum acceptable data loss measured in time. |
| RTO | Recovery Time Objective. Maximum acceptable time to restore service. |

### Example Matrix

| Workload Type | Example Service | Suggested RPO | Suggested RTO | Backup Priority |
|---|---|---:|---:|---|
| Critical Production | Database, ERP, payment systems | 1 hour | 4 hours | High |
| Important Production | APIs, business applications | 4 hours | 8 hours | High |
| Standard Production | Internal applications | 24 hours | 24 hours | Medium |
| Non-Production | Dev, QA, Testing | 24-48 hours | Best effort | Low |

### Backup Event Impact

| Event Status | Potential RPO Impact | Potential RTO Impact | Action |
|---|---|---|---|
| FAILED | High | Medium to High | Investigate and re-run backup. |
| ABORTED | High | Medium | Validate reason and retry if needed. |
| EXPIRED | Medium to High | Medium | Review backup window and scheduling. |
| PARTIAL | Medium | Medium | Identify missing resources. |
