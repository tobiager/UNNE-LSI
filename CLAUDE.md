# CLAUDE.md

This file guides AI assistants (Claude Code) working in this repository.

## What this repo is

A personal, non-official knowledge base for the **Licenciatura en Sistemas de
Información (LSI)** at FaCENA–UNNE (Corrientes, Argentina). It holds course
notes, practicals, old exams, and study tips organized by subject (`Materias/`),
plus a small static website (GitHub Pages) with a course-progress tracker
(simulador), a search tool (buscador), and a calendar.

There is no application backend and no test suite. The "code" is: content
(Markdown/PDF/images per subject), a couple of Python build scripts that
regenerate JSON/sitemap data from the content tree, and a static HTML/CSS/JS
site in `docs/`.

## Repository structure

```
.
├── Materias/        # One folder per subject: README.md + practicos/parciales/teoria/etc.
├── planes/          # Study plan details (2009.md, 2023.md) + official plan PDFs
├── meta/            # mapping-planes.yaml (subject↔plan correlatives) + build_materias_index.py
├── scripts/         # build_data.py — generates docs/materias.json, sitemaps, robots.txt
├── docs/            # GitHub Pages site (served as-is, no bundler): home, buscador, simulador, calendario, estado
├── assets/          # Images/banners used in README and the site
├── .github/         # Issue/PR templates + deploy.yml workflow
├── mkdocs.yml        # Optional MkDocs config (Materias nav, planes, calendario, simulador)
├── CONTRIBUTING.md
└── README.md
```

### `Materias/<Subject Name>/`
Each subject folder is independent and conventionally contains:
- `README.md` — required; describes what's inside the subject folder.
- Subfolders like `Teoria/`, `Practica/` (with `TP1`, `TP2`, ... `SQL`), `Parciales/` (e.g. `1er parcial`, `2do parcial`), `Ejemplos/`, `Proyecto/`.
- Folder/subject names use spaces and mixed case (e.g. `Bases de Datos 1`, `Algoritmo y Estructura de datos 1`) — match the existing naming exactly when adding files, don't introduce new spelling/number conventions for the same subject.

### `docs/` (the static site, deployed via GitHub Pages)
- Plain HTML/CSS/JS — no framework, no build step, no `package.json`.
- `home.html` / `index.html` — landing page.
- `buscador/` — search across `materias.json`.
- `simulador/` — course-progress simulator (plan selection, subject status, notes; persisted in the browser's LocalStorage, exportable/importable as JSON).
- `calendario/`, `estado/` — calendar and status pages.
- `navbar/navbar.html`, `footer/footer.html`, `layout/layout.js` — shared chrome injected at runtime into pages.
- `app.js` — shared client JS (service worker registration, navbar/footer wiring, GitHub stars badge with 24h LocalStorage cache).
- `materias.json`, `sitemap.xml`, `sitemap_pdfs.xml`, `robots.txt` — **generated files**; do not hand-edit (see Build below).
- `sw.js` — service worker for offline/PWA support.

### `meta/`
- `mapping-planes.yaml` — maps each subject (`slug`, `nombre`) to its year/quarter/workload under both study plans (2009 and 2023). Update this when a subject's plan placement changes.
- `build_materias_index.py` — scans `Materias/**/README.md` and writes a simple `{nombre, ruta}` index to `docs/materias.json`. Note this is a *different, simpler* generator than `scripts/build_data.py` (see below) — don't run both expecting the same output.

### `planes/`
- `2009.md`, `2023.md` — human-readable plan breakdowns by year.
- The two plan PDFs are the official source documents.

## Build / regeneration workflow

`scripts/build_data.py` is the canonical generator. It walks `Materias/`, detects
keywords in file/folder names (`final`, `parcial`, `resumen`, `guia`, `examen`,
`tp`) for categorization, and writes:
- `docs/materias.json` — full content tree per subject, with SEO metadata.
- `docs/sitemap.xml` — site + per-subject + per-keyword deep-link URLs.
- `docs/sitemap_pdfs.xml` — sitemap of raw PDF URLs (for Google indexing).
- `docs/robots.txt`.

Run it locally with:
```bash
python scripts/build_data.py
```

This runs automatically in CI (`.github/workflows/deploy.yml`) on every push to
`main`: a `build` job regenerates these files and commits them back to `main`
with `[skip ci]` (as `github-actions[bot]`), then a `deploy` job publishes
`docs/` to GitHub Pages.

**Implication for assistants:** if you add/rename/remove files under
`Materias/`, the generated JSON/sitemap files will be out of date until the
workflow runs (or you run `scripts/build_data.py` yourself). Don't hand-edit
`docs/materias.json`, `docs/sitemap.xml`, `docs/sitemap_pdfs.xml`, or
`docs/robots.txt` — edits will be overwritten by the next CI run.

## Local preview

There's no app server; for the MkDocs-based doc view:
```bash
pip install mkdocs mkdocs-material
mkdocs serve
```
For the actual GitHub Pages site in `docs/`, just open the HTML files or serve
the folder with any static file server (e.g. `python -m http.server` from
`docs/`).

## Conventions

- **Language:** all content (README, comments, commit messages in history,
  issue/PR templates) is in **Spanish (Argentina)**. Keep new content in
  Spanish unless the user asks otherwise.
- **Licensing:** notes/guides/summaries are CC BY-NC-SA 4.0; code/templates are
  MIT (`LICENSE`). Don't add copyrighted material (scanned books, full papers).
- **File types:** prefer `.md` for notes; for code use clear extensions
  (`.java`, `.cpp`, `.sql`). Avoid uploading heavy PDFs when a `.md`/`.tex` +
  link to the original would do.
- **Branch naming for contributions:** `materia/<materia>-<cambio>` (e.g.
  `materia/bd1-resumen-parcial`), PRs target `main`.
- **`.gitattributes`** marks office/doc/image formats as
  `linguist-detectable=false` so GitHub's language stats reflect the actual
  code (JS/Python/HTML), not the bulk of notes/PDFs.
- **`.gitignore`** excludes OS cruft, `build/`, `dist/`, `node_modules/`,
  archives (`.zip/.rar/.7z`), and a local-only `no-subir/` folder (content
  intentionally never pushed).
- When adding a new subject folder, also consider whether it needs an entry in
  `meta/mapping-planes.yaml` (plan/year/quarter) and a link in the main
  `README.md` subject list and `mkdocs.yml` nav.

## What NOT to do

- Don't hand-edit generated files (`docs/materias.json`, `docs/sitemap*.xml`,
  `docs/robots.txt`) — change `scripts/build_data.py` or the source content
  under `Materias/` instead, and let CI (or a manual run) regenerate them.
- Don't restructure `Materias/<Subject>/` subfolder conventions wholesale; this
  is a long-lived, multi-contributor archive — prefer additive, low-risk
  changes that match each subject's existing layout.
- Don't introduce a JS framework/bundler into `docs/` — it's intentionally a
  plain static site with no build step.
