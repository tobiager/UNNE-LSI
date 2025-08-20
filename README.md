<p align="center">
  <img src="./assets/facena.png" alt="Logo de FaCENA" width="96"/>
</p>

<p align="center">
  <a href="https://github.com/tobiager">
    <img src="https://img.shields.io/github/followers/tobiager?label=Follow%20@tobiager&style=social" alt="Follow @tobiager" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/LSI-UNNE-blue?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Organizaci%C3%B3n-Por%20Materia-8A2BE2?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Planes-2009%20%7C%202023-4caf50?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Estado-En%20construcci%C3%B3n-orange?style=for-the-badge"/>
</p>

# 🎓 LSI UNNE — Apuntes, prácticos y guías por materia

Repositorio **no oficial** con material **propio** (resúmenes, prácticos resueltos, guías y plantillas) de la **Licenciatura en Sistemas de Información (FaCENA–UNNE)**.

Lo hice para:
- **Estudiar mejor** y dejar el recorrido documentado.
- **Ayudar** a quienes cursan con **planes distintos** (2009 y 2023).
- Tener un **portafolio académico** ordenado y público.

> Comparto contenido realizado por mí y enlaces públicos. Evito subir archivos con copyright de terceros o exámenes vigentes.

---

## 🗂️ Estructura

```
materias/
  (una carpeta por materia)
planes/
  2009.md
  2023.md
meta/
  mapping-planes.yaml   # mapea materia → {año, cuatri} por plan
assets/
  facena.png            # logo (placeholder)
```

- Todo el contenido vive en `materias/`.
- Los archivos de `planes/` solo **ordenan** y **enlazan** a las materias (sin duplicar).
- `meta/mapping-planes.yaml` mantiene el mapeo para **2009** y **2023**.

---

## 🚀 Cómo navegar
- **Por materia:** entra a [`/materias`](./Materias) y elegí la carpeta correspondiente.
- **Por plan:** abrí [`/planes/2023.md`](./planes/2023.md) o [`/planes/2009.md`](./planes/2009.md) para ver el orden sugerido y links directos.

---

## 🧰 Buenas prácticas del repo
- **Commits** con prefijo de materia (`bdd-i: agrega normalización v2`).
- **Releases** por cuatrimestre (ej: `2025-Q2`).
- **Archivos grandes:** subir como **Assets de Releases** o enlazar (Drive).
- `.gitignore` para evitar binarios innecesarios (`*.zip`, `build/`, etc.).

---

## 🔒 Uso responsable
- No se publican **exámenes vigentes** ni **material cerrado** de cátedra.
- Si sos docente y querés ajustar/quitar algo, abrí un **Issue**.

---

## 🤝 Contribuir
1. Abrí un **Issue** con el detalle del cambio.
2. (Opcional) PR desde una rama `materia/<slug>-<cambio>`.

Convenciones de commit:
```
poo: añade guía de polimorfismo
ing-soft-i: corrige ERS y añade casos de uso
```

---

## 📄 Licencia
- **Apuntes/guías/soluciones propias:** CC BY-NC-SA 4.0  
- **Código/plantillas reutilizables:** MIT

---

<p align="center"><b>❤️🐔 Hecho por Tobias (@tobiager). Que le sirva a alguien más.</b></p>
