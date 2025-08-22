<p align="center">
  <img src="https://raw.githubusercontent.com/tobiager/UNNE-LSI/main/assets/facena.png" alt="Logo de FaCENA" width="100">
</p>

<p align="center">
  <a href="https://github.com/tobiager">
    <img src="https://img.shields.io/github/followers/tobiager?label=Follow%20@tobiager&style=social" alt="Follow @tobiager" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white"/>
  <img src="https://img.shields.io/badge/Modelado-ERDPlus-6A5ACD?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/UNNE-Informática-blue?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Estado-En%20curso-orange?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Cursada-2025-blue?style=for-the-badge"/>
</p>

# Bases de Datos - UNNE 2025

<img src="https://raw.githubusercontent.com/tobiager/UNNE-LSI/main/assets/database1.png" alt="Sticker database" width="300" align="right" style="margin-left:20px;"/>

Esta carpeta reúne **modelos ER**, **scripts SQL**, **prácticos**, **material de estudio** y **mini-proyectos** desarrollados en la materia **Bases de Datos** de la **UNNE – FaCENA** (cursada 2025), trabajando principalmente con **MySQL** y **ERDPlus**.


<br><br> <!-- 👈 Espaciado extra antes de la siguiente sección -->



<br><br> <!-- 👈 Espaciado extra antes de la siguiente sección -->

## 📦 Estructura del Repositorio

| Carpeta/Archivo | Contenido |
|-----------------|-----------|
| `practicos/`    | Enunciados y resoluciones de trabajos prácticos |
| `parciales/`    | Guías de repaso, simulacros y soluciones |
| `apuntes/`      | Resúmenes: normalización, claves, restricciones, transacciones |

---

## 🚀 Temario (enfoque práctico)

- **Modelado conceptual (ER)**: entidades, atributos, **claves**, **cardinalidades**, **identificadores débiles**.
- **Paso ER → Relacional**: mapeo de relaciones 1:1, 1:N, N:M (tablas intermedias).
- **Normalización**: 1FN, 2FN, 3FN, BCNF + detección de dependencias funcionales.
- **SQL (MySQL)**:
  - DDL: `CREATE/ALTER/DROP`, restricciones (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`).
  - DML: `INSERT/UPDATE/DELETE`, `SELECT`, **JOIN** (INNER/LEFT/RIGHT), **GROUP BY/HAVING**.
  - **Vistas**, **Índices**, **Funciones de agregación**.
  - **Stored Procedures**, **Triggers**, **Funciones definidas por el usuario**.
- **Transacciones & ACID**: `START TRANSACTION`, `COMMIT`, `ROLLBACK`, niveles de aislamiento.
- **Performance básico**: índices, `EXPLAIN`, tipos de datos adecuados.

---

## 🧪 Cómo levantar el entorno (opcional con Docker)

`docker/docker-compose.yml`:

```yaml
services:
  mysql:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: universidad
      MYSQL_ALLOW_EMPTY_PASSWORD: "no"
    ports:
      - "3306:3306"
    volumes:
      - ./data/mysql:/var/lib/mysql
      - ../scripts-sql:/docker-entrypoint-initdb.d
  adminer:
    image: adminer
    ports:
      - "8080:8080"
```

- Levantar: `docker compose up -d`
- Adminer: http://localhost:8080 (Server: `mysql`, User: `root`, Pass: `root`)
- Al iniciar, MySQL ejecuta automáticamente los `.sql` de `scripts-sql/` en orden alfabético.

---

## 🧰 Herramientas que uso

- **ERDPlus** para modelado ER (exporto PNG/PDF y el archivo del editor).
- **MySQL** 8.x (local con Docker o nativo).
- **Clientes SQL**: MySQL Workbench / **DBeaver** / Adminer (simple y liviano).

---

## 🧩 Convenciones del repo

- Archivos SQL numerados para ejecución secuencial:
  - `01_creacion.sql` → tablas + constraints.
  - `02_poblado.sql` → datos base.
  - `03_consultas.sql` → consultas pedidas en los prácticos.
- Cada TP tiene su **DER** en `modelos-er/` y su **mapeo** a tablas documentado al inicio del SQL.
- Comentarios en SQL con `--` explicando decisiones de diseño.

---

## 🧱 Mini ejemplo (DER → Relacional → SQL)

**Relación N:M** `Alumno` — `Materia` con atributo `nota`:

- Tablas: `alumno(id_alumno PK, ...)`, `materia(id_materia PK, ...)`
- Intermedia: `alumno_materia(id_alumno FK, id_materia FK, nota, PRIMARY KEY(id_alumno,id_materia))`

```sql
CREATE TABLE alumno (
  id_alumno INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(80) NOT NULL
);

CREATE TABLE materia (
  id_materia INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE alumno_materia (
  id_alumno INT NOT NULL,
  id_materia INT NOT NULL,
  nota DECIMAL(4,2),
  PRIMARY KEY (id_alumno, id_materia),
  CONSTRAINT fk_am_alumno  FOREIGN KEY (id_alumno)  REFERENCES alumno(id_alumno),
  CONSTRAINT fk_am_materia FOREIGN KEY (id_materia) REFERENCES materia(id_materia)
);
```

**Consulta típica**: promedio por materia (solo aprobados ≥ 6)

```sql
SELECT m.nombre AS materia, ROUND(AVG(am.nota),2) AS promedio_aprobados
FROM alumno_materia am
JOIN materia m ON m.id_materia = am.id_materia
WHERE am.nota >= 6
GROUP BY m.id_materia, m.nombre
ORDER BY promedio_aprobados DESC;
```

---

## ✅ Checklist rápido de normalización

- [ ] ¿Cada columna es **atómica**? (1FN)
- [ ] ¿Atributos no clave dependen **toda** la clave? (2FN en claves compuestas)
- [ ] ¿No hay dependencias transitivas atributo-no-clave → atributo-no-clave? (3FN)
- [ ] ¿Claves candidatas identificadas? ¿Elegiste una **PK** adecuada?
- [ ] ¿N:M mapeadas con tablas intermedias? ¿FK con ON DELETE/UPDATE pensados?

---

## 📚 Practicidad para la cursada

- **ERDPlus**: guardo el archivo del editor y exporto imagen para el informe.
- Entrego **DER + mapeo + SQL** y, si piden, un **PDF** con capturas de `EXPLAIN`.
- Para cada práctico, incluyo `README.md` corto con:
  - DER final, decisiones (opcional: alternativas descartadas).
  - Cómo correr el SQL (`docker`/Workbench).
  - Consultas pedidas y resultado esperado (captura o ejemplo).


---

<p align="center"><b>❤️🐔 Hecho con dedicacion y pasion por Tobias</b></p>

