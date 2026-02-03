<p align="center">
  <img src="https://raw.githubusercontent.com/tobiager/UNNE-LSI/main/assets/facena.png" alt="Logo de FaCENA" width="100">
</p>

<p align="center">
  <a href="https://github.com/tobiager">
    <img src="https://img.shields.io/github/followers/tobiager?label=Follow%20@tobiager&style=social" alt="Follow @tobiager" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL%20Server-0078D7?style=for-the-badge&logo=microsoft-sql-server&logoColor=white"/>
  <img src="https://img.shields.io/badge/Modelado-ERDPlus-6A5ACD?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/UNNE-Inform%C3%A1tica-blue?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Estado-%20completado-greenlight?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Cursada-2025-blue?style=for-the-badge"/>
</p>

# Bases de Datos - UNNE 2025

<img src="https://raw.githubusercontent.com/tobiager/UNNE-LSI/main/assets/database1.png" alt="Sticker database" width="300" align="right" style="margin-left:20px;"/>

Este repositorio reúne material de la materia **Bases de Datos (BD1)** de la **UNNE – FaCENA** (cursada 2025): modelos ER, scripts SQL, prácticos, parciales y material de estudio. En esta cursada trabajamos con **Microsoft SQL Server (T‑SQL)** y **ERDPlus** para modelado.

---

## Estructura del Repositorio

| Carpeta/Archivo | Contenido |
|-----------------|-----------|
| `practicos/`    | Enunciados y resoluciones de trabajos prácticos |
| `parciales/`    | Guías de repaso, simulacros y soluciones |
| `teoria/`      | Material teorico de la materia |

---

## ¿Qué se espera en los entregables principales?

- Primer parcial (entrega individual):
  - DER (archivo de ERDPlus + imagen PNG/PDF) con el modelo conceptual completo.
  - Script SQL de creación (DDL) con las tablas mapeadas y restricciones básicas: 
    - NOT NULL / NULL (atributos obligatorios y opcionales).
    - UNIQUE.
    - CHECK (validaciones de dominio).
    - DEFAULT.
    - PRIMARY KEY (con nombre de constraint).
    - FOREIGN KEY (con nombre de constraint y ON DELETE / ON UPDATE definidos).
  - Se evaluará que los constraints estén nombrados (ej.: CONSTRAINT pk_alumno PRIMARY KEY (...)) y que las restricciones implementen reglas reales del dominio.
  - Formato de entrega: carpeta con DER (PNG + archivo ERDPlus), y archivo `01_creacion.sql`. Opcional: `README_parcial1.md` explicando decisiones de modelado.

- Segundo parcial (consultas - T‑SQL, individual):
  - Archivo `02_consultas.sql` con todas las consultas pedidas en el enunciado, escritas en T‑SQL (compatibles con SQL Server).
  - Se pide uso correcto de JOINs, GROUP BY/HAVING, subconsultas, funciones escalares/ agregadas y manejo de NULLs.
  - Incluir comentarios en el .sql con explicación de cada consulta y un ejemplo de salida cuando corresponda.

- Integrador (trabajo en grupo):
  - Crear un repositorio de grupo siguiendo la organización propuesta o similar.
  - En el repo grupal presentar: DER final, scripts (creación, poblado y consultas), informe y una carpeta `investigacion/` con 4 temas investigados (ver sugerencias abajo).
  - Cada grupo debe entregar el enlace al repo, y en el README del repo grupal indicar integrantes y roles.

<a href="https://github.com/tobiager/BD1-proyecto">
  <img width="400" src="https://github-readme-stats.vercel.app/api/pin/?username=tobiager&repo=bd1-proyecto&theme=transparent&hide_border=true" alt="BD1-proyecto repo card"/>
</a>

---

## Convenciones y buenas prácticas (obligatorias)

- Archivos SQL numerados para ejecución secuencial:
  - `01_creacion.sql` → tablas + constraints.
  - `02_poblado.sql` → inserts base (datos mínimos para probar consultas).
  - `03_consultas.sql` → queries solicitadas.
- Nombre de constraints legible: usar el prefijo (pk_, fk_, uq_, ck_).
- Evitar tipos genéricos: elegir tipos SQL Server adecuados (INT, BIGINT, NVARCHAR(n), DATETIME2, DECIMAL(p,s), BIT).
- Comentarios en SQL con `--` para explicar decisiones.
- Incluir transacciones cuando una secuencia de inserts/deletes deba ser atómica en `02_poblado.sql`.

---

## Herramientas recomendadas

- Microsoft SQL Server (Express o Developer) — servidor local.
- SQL Server Management Studio (SSMS) y/o Azure Data Studio — clientes para ejecutar scripts.
- ERDPlus para modelado ER (archivo del editor + export PNG/PDF).
- DBeaver (opcional) o cualquier cliente que soporte SQL Server.
- Git + GitHub para control de versiones y entrega de integrador.

---

## Cómo entrego / subo los archivos

- Entregas parciales individuales: subir a tu repositorio personal en la carpeta `Materias/Bases de Datos 1/parciales/<parcialX>/apellidos_nombre/`.
- Entregas integrador: crear repo grupal público o privado según indicaciones del cátedra y compartir el link.
- Incluir en cada entrega un `README.md` corto con lo esencial: cómo ejecutar los scripts (versión de SQL Server), orden de ejecución y errores conocidos.

---

## Recursos y bibliografía rápida

- Documentación oficial SQL Server (T‑SQL) — Microsoft Docs.
- Materiales de clase y apuntes de FaCENA.
- ERDPlus (https://erdplus.com).
- StackOverflow / SQLServerCentral para dudas puntuales.

---

<p align="center"><b>❤️🐔 Hecho con dedicación y pasión por Tobias </b></p>
