# Backup Validation Checklist

## Español

### Validación de despliegue

- [ ] CloudFormation stack desplegado correctamente.
- [ ] Lambda function creada.
- [ ] EventBridge rule creada.
- [ ] IAM role creada.
- [ ] CloudWatch Log Group creado.
- [ ] Variables de entorno de Lambda configuradas.
- [ ] Hub endpoint configurado.
- [ ] Hub token configurado de forma segura.

### Validación de EventBridge

- [ ] Event pattern filtra `aws.backup`.
- [ ] Event pattern filtra `Backup Job State Change`.
- [ ] Event pattern incluye `FAILED`.
- [ ] Event pattern incluye `ABORTED`.
- [ ] Event pattern incluye `EXPIRED`.
- [ ] Event pattern incluye `PARTIAL`.
- [ ] Lambda target está configurado.
- [ ] EventBridge tiene permiso para invocar Lambda.

### Validación de Lambda

- [ ] Lambda recibe evento de prueba.
- [ ] Lambda identifica estado crítico.
- [ ] Lambda ignora estado no crítico.
- [ ] Lambda normaliza payload correctamente.
- [ ] Lambda envía mensaje al hub.
- [ ] Lambda registra respuesta del hub.
- [ ] Lambda registra errores si falla el envío al hub.

### Validación del hub

- [ ] Hub recibe mensaje de prueba.
- [ ] Hub identifica source como `aws.backup`.
- [ ] Hub identifica severity como `critical`.
- [ ] Hub recibe backup job ID.
- [ ] Hub recibe ARN del recurso afectado.
- [ ] Hub enruta evento hacia monitoreo, alertas o ticketing.

### Validación operativa

- [ ] Evento de backup fallido genera visibilidad operativa.
- [ ] Ruta de alertamiento validada.
- [ ] Ruta de ticketing validada si aplica.
- [ ] Impacto RPO/RTO puede ser evaluado.
- [ ] Runbook o ruta de escalamiento documentada.
- [ ] Evidencia puede recolectarse desde logs.

### Validación de seguridad

- [ ] No hay credenciales reales en GitHub.
- [ ] No hay token real del hub en GitHub.
- [ ] No hay account IDs productivos reales.
- [ ] No hay nombres de clientes.
- [ ] No hay correos internos.
- [ ] `.gitignore` bloquea archivos locales sensibles.

---

## Deutsch

### Validierung

- [ ] CloudFormation Stack erfolgreich bereitgestellt.
- [ ] Lambda Function erstellt.
- [ ] EventBridge Rule erstellt.
- [ ] IAM Role erstellt.
- [ ] CloudWatch Log Group erstellt.
- [ ] Hub-Endpunkt konfiguriert.
- [ ] Hub-Token sicher konfiguriert.
- [ ] Keine sensiblen Daten im Repository.

**Traducción al español:**  
Esta sección alemana resume las validaciones principales de despliegue, EventBridge, Lambda, hub y seguridad.

---

## English

### Deployment Validation

- [ ] CloudFormation stack deployed successfully.
- [ ] Lambda function created.
- [ ] EventBridge rule created.
- [ ] IAM role created.
- [ ] CloudWatch Log Group created.
- [ ] Lambda environment variables configured.
- [ ] Hub endpoint configured.
- [ ] Hub token configured securely.

### EventBridge Validation

- [ ] Event pattern filters `aws.backup`.
- [ ] Event pattern filters `Backup Job State Change`.
- [ ] Event pattern includes `FAILED`.
- [ ] Event pattern includes `ABORTED`.
- [ ] Event pattern includes `EXPIRED`.
- [ ] Event pattern includes `PARTIAL`.
- [ ] Lambda target is configured.
- [ ] EventBridge has permission to invoke Lambda.

### Lambda Validation

- [ ] Lambda receives test event.
- [ ] Lambda identifies critical state.
- [ ] Lambda ignores non-critical state.
- [ ] Lambda normalizes payload correctly.
- [ ] Lambda sends message to hub.
- [ ] Lambda logs response from hub.
- [ ] Lambda logs errors when hub delivery fails.

### Security Validation

- [ ] No real credentials committed to GitHub.
- [ ] No real hub token committed to GitHub.
- [ ] No production account IDs committed to GitHub.
- [ ] No customer names committed to GitHub.
- [ ] No internal emails committed to GitHub.
- [ ] `.gitignore` blocks sensitive local files.
