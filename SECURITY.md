# Security Policy

## Versiones soportadas

Este es un proyecto académico (UNNE - Licenciatura en Sistemas de Información) sin versiones de release formales. Las actualizaciones de seguridad se aplican únicamente sobre la rama `main`, que es la versión activa del proyecto.

| Versión       | Soportada          |
| ------------- | ------------------ |
| main (actual) | :white_check_mark: |
| versiones anteriores / forks | :x: |

## Reportar una vulnerabilidad

Si encontrás una vulnerabilidad de seguridad (por ejemplo, credenciales expuestas, inyección SQL, fallas de autenticación, etc.):

- **No la publiques en un Issue público.**
- Reportala de forma privada vía correo electrónico **tobiasorban00@gmail.com** .
- Incluí una descripción del problema, pasos para reproducirlo y el impacto potencial si es posible.

## Qué esperar

- Vamos a confirmar la recepción del reporte en un plazo razonable.
- Si la vulnerabilidad es válida, se trabajará en un fix y se te avisará cuando esté resuelto.
- Si se determina que no aplica (por ejemplo, no es explotable en este contexto), también se te informará el motivo.

## Buenas prácticas del proyecto

- Las credenciales y variables sensibles (`.env`, claves de base de datos, etc.) **no deben subirse al repositorio**.
- Cualquier dato de prueba/seed debe ser ficticio, sin información real de pacientes ni datos sensibles.
