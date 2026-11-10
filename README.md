# Versionado de Infraestructura con Terraform para el Servicio de Ordenes

El equipo de desarrollo necesita aprovisionar y versionar la infraestructura AWS para el servicio de ordenes utilizando Terraform. El objetivo es asegurar que la infraestructura sea consistente, reproducible y gestionable a través del código.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el servicio de ordenes |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: JDK 17+, Maven 3.9+, IDE con soporte Java.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `mvn compile` en la raíz. Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Exploración y Configuración Inicial

**Objetivo:** Configurar el entorno de Terraform y comprender las necesidades del servicio de ordenes.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar los componentes y servicios de AWS necesarios para el servicio de ordenes.
- Configurar el entorno de Terraform para interactuar con la cuenta de AWS.
- Documentar las decisiones iniciales y las restricciones identificadas.

**Entregable:** Documento de configuración inicial que detalla los componentes de AWS y las decisiones tomadas.

<details>
<summary>Pistas de conocimiento</summary>

- Importancia de la modularidad en Terraform.
- Uso de variables y outputs en Terraform.

</details>

### Fase 2: Aprovisionamiento de Infraestructura

**Objetivo:** Crear los scripts de Terraform para aprovisionar la infraestructura necesaria.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Desarrollar los scripts de Terraform para crear los recursos de AWS requeridos por el servicio de ordenes.
- Validar que los recursos creados cumplen con las especificaciones del servicio.
- Documentar los scripts y las validaciones realizadas.

**Entregable:** Scripts de Terraform que aprovisionan la infraestructura de AWS para el servicio de ordenes.

<details>
<summary>Pistas de conocimiento</summary>

- Prácticas de buenas en la escritura de scripts de Terraform.
- Uso de módulos de Terraform para reutilización de código.

</details>

### Fase 3: Versionado y Gestión de Cambios

**Objetivo:** Implementar un sistema de versionado para la infraestructura y gestionar cambios.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Configurar un repositorio de versionado para los scripts de Terraform.
- Implementar un proceso para gestionar cambios en la infraestructura.
- Documentar el proceso de versionado y gestión de cambios.

**Entregable:** Repositorio de versionado con los scripts de Terraform y documentación del proceso de gestión de cambios.

<details>
<summary>Pistas de conocimiento</summary>

- Prácticas de versionado y gestión de cambios en infraestructura como código.
- Uso de herramientas de CI/CD para automatizar el despliegue de infraestructura.
- Java: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para aprovisionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve versionar la infraestructura con Terraform?
- **comoSeUsa**: ¿Cómo se escriben y gestionan los scripts de Terraform?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar infraestructura con Terraform?
- **queDecisionesImplica**: ¿Qué decisiones implica el versionado y la gestión de cambios en infraestructura como código?

## Criterios de Evaluacion

- Configuración inicial de Terraform documentada.
- Scripts de Terraform para aprovisionar infraestructura creados y validados.
- Repositorio de versionado configurado y proceso de gestión de cambios documentado.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd api && mvn clean compile` — componente `api` (chapter, support).

### Contratos entre componentes

- `api` expone http (api: http://localhost:8080):
  - `POST /api/orders`
  - `GET /api/orders/{id}`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).
- **Java**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
