#!/usr/bin/env python3
"""
build_data.py — Motor de automatización LSI Tools
Recorre /Materias, genera docs/materias.json y docs/sitemap.xml
"""

import os
import json
import re
import html
from datetime import datetime, timezone
from pathlib import Path

# ── Configuración ──────────────────────────────────────────────────────────────
REPO_ROOT   = Path(__file__).resolve().parent.parent
MATERIAS_DIR = REPO_ROOT / "Materias"
DOCS_DIR    = REPO_ROOT / "docs"
OUTPUT_JSON      = DOCS_DIR / "materias.json"
SITEMAP_OUT      = DOCS_DIR / "sitemap.xml"
PDF_SITEMAP_OUT  = DOCS_DIR / "sitemap_pdfs.xml"
ROBOTS_OUT       = DOCS_DIR / "robots.txt"

BASE_URL     = "https://tobiager.github.io/UNNE-LSI"
GITHUB_RAW   = "https://raw.githubusercontent.com/tobiager/UNNE-LSI/main"
GITHUB_BLOB  = "https://github.com/tobiager/UNNE-LSI/blob/main"
GITHUB_TREE  = "https://github.com/tobiager/UNNE-LSI/tree/main"

STATIC_PAGES = [
    {"url": f"{BASE_URL}/",           "priority": "1.0", "changefreq": "weekly"},
    {"url": f"{BASE_URL}/buscador/",  "priority": "0.9", "changefreq": "weekly"},
    {"url": f"{BASE_URL}/simulador/", "priority": "0.7", "changefreq": "monthly"},
    {"url": f"{BASE_URL}/calendario/","priority": "0.7", "changefreq": "weekly"},
    {"url": f"{BASE_URL}/estado/",    "priority": "0.7", "changefreq": "monthly"},
]

SEO_KEYWORDS = ["final", "parcial", "resumen", "guia", "tp", "examen"]

# Orden de prioridad para destacar contenido (UI + sitemap)
CATEGORY_PRIORITY = ["Final", "Parcial", "Examen", "TP", "Guía", "Resumen"]

CATEGORY_BY_KEYWORD = {
    "final": "Final",
    "parcial": "Parcial",
    "resumen": "Resumen",
    "guia": "Guía",
    "tp": "TP",
    "examen": "Examen",
}

# ── Helpers ────────────────────────────────────────────────────────────────────

def slugify(name: str) -> str:
    """Convierte 'Bases de Datos 1' → 'bases-de-datos-1'"""
    s = name.lower()
    s = re.sub(r'[áà]', 'a', s)
    s = re.sub(r'[éè]', 'e', s)
    s = re.sub(r'[íì]', 'i', s)
    s = re.sub(r'[óò]', 'o', s)
    s = re.sub(r'[úù]', 'u', s)
    s = re.sub(r'[ñ]', 'n', s)
    s = re.sub(r'[^a-z0-9]+', '-', s)
    return s.strip('-')


def normalize_text(s: str) -> str:
    """Normaliza para matching de keywords (lower + sin tildes/ñ)."""
    s = s.lower()
    s = re.sub(r'[áà]', 'a', s)
    s = re.sub(r'[éè]', 'e', s)
    s = re.sub(r'[íì]', 'i', s)
    s = re.sub(r'[óò]', 'o', s)
    s = re.sub(r'[úù]', 'u', s)
    s = re.sub(r'[ñ]', 'n', s)
    return s


def detect_keywords(text: str) -> set:
    """Detecta keywords en texto normalizado. Devuelve IDs en minúsculas."""
    t = normalize_text(text)
    found = set()

    if re.search(r'\bfinal(es)?\b', t):
        found.add("final")
    if re.search(r'\bparcial(es)?\b', t):
        found.add("parcial")
    if re.search(r'\bresumen(es)?\b', t):
        found.add("resumen")
    if re.search(r'\bguia(s)?\b', t):
        found.add("guia")
    if re.search(r'\bexamen(es)?\b', t):
        found.add("examen")
    # TP: tp, tp1, tp-2, tps, trabajo practico
    if re.search(r'\btp\b|\btp\d+\b|\btps\b', t) or re.search(r'\btrabajo\s*practico\b', t):
        found.add("tp")

    return found


def keywords_to_categories(keywords: set) -> list:
    cats = {CATEGORY_BY_KEYWORD[k] for k in keywords if k in CATEGORY_BY_KEYWORD}
    return sorted(cats, key=lambda c: CATEGORY_PRIORITY.index(c) if c in CATEGORY_PRIORITY else 999)


def pick_primary_category(categories: list) -> str | None:
    return categories[0] if categories else None


def merge_seo(a: dict, b: dict) -> dict:
    """Fusiona dos estructuras SEO (keywords:set, categories:dict)."""
    out = {
        "keywords": set(a.get("keywords", set())),
        "categories": dict(a.get("categories", {})),
    }
    out["keywords"].update(b.get("keywords", set()))
    for k, v in b.get("categories", {}).items():
        out["categories"][k] = out["categories"].get(k, 0) + int(v)
    return out


def seo_from_item(item: dict) -> dict:
    kws = set(item.get("keywords", []))

    # Para métricas de categorías, solo contamos archivos (las carpetas ya agregan sus hijos)
    if item.get("tipo") != "archivo":
        return {"keywords": kws, "categories": {}}

    cats = item.get("categorias", [])
    cat_counts: dict[str, int] = {}
    for c in cats:
        cat_counts[c] = cat_counts.get(c, 0) + 1
    return {"keywords": kws, "categories": cat_counts}


def compute_seo(items: list) -> dict:
    acc = {"keywords": set(), "categories": {}}
    for it in items or []:
        acc = merge_seo(acc, seo_from_item(it))
        if it.get("tipo") == "carpeta":
            acc = merge_seo(acc, compute_seo(it.get("hijos") or []))
    return acc


def seo_to_public(seo: dict) -> dict:
    categories = seo.get("categories", {})
    keywords = sorted(seo.get("keywords", set()))
    top_categories = [c for c in CATEGORY_PRIORITY if categories.get(c)]
    return {
        "keywords": keywords,
        "categorias": categories,
        "top_categorias": top_categories,
    }


def url_encode_path(path: str) -> str:
    """Reemplaza espacios por %20 en paths de URL (sin romper slashes)."""
    return '/'.join(part.replace(' ', '%20') for part in path.split('/'))


def xml_escape_loc(url: str) -> str:
    """Escapa URLs para <loc> (especialmente & -> &amp;)."""
    return html.escape(url, quote=True)


def sort_entries_for_seo(entries: list[Path]) -> list[Path]:
    def entry_rank(p: Path) -> tuple:
        # Directorios primero, y dentro de cada grupo priorizar por keyword
        kws = detect_keywords(p.name)
        cats = keywords_to_categories(kws)
        primary = pick_primary_category(cats)
        cat_rank = CATEGORY_PRIORITY.index(primary) if primary in CATEGORY_PRIORITY else 999
        return (p.is_file(), cat_rank, p.name.lower())

    return sorted(entries, key=entry_rank)


def scan_directory(base_path: Path, rel_prefix: str) -> list:
    """Recorre un directorio y devuelve lista de {tipo, nombre, url_raw, url_blob}."""
    items = []
    try:
        entries = sort_entries_for_seo(list(base_path.iterdir()))
    except PermissionError:
        return items

    for entry in entries:
        rel = f"{rel_prefix}/{entry.name}"
        encoded = url_encode_path(rel)

        # Keywords/categorías por nombre (y por ruta como fallback)
        name_kws = detect_keywords(entry.name)
        path_kws = detect_keywords(rel_prefix)
        kws = set(name_kws) | set(path_kws)
        categorias = keywords_to_categories(kws)
        categoria = pick_primary_category(categorias)

        if entry.is_dir():
            children = scan_directory(entry, rel)

            # Agregación liviana: usamos keywords/categorías de hijos ya calculadas
            folder_keyword_set = set(kws)
            folder_category_set = set(categorias)
            for ch in children:
                folder_keyword_set.update(ch.get("keywords", []) or [])
                folder_category_set.update(ch.get("categorias", []) or [])

            folder_keywords = sorted(folder_keyword_set)
            folder_categories = sorted(
                folder_category_set,
                key=lambda c: CATEGORY_PRIORITY.index(c) if c in CATEGORY_PRIORITY else 999,
            )
            items.append({
                "tipo": "carpeta",
                "nombre": entry.name,
                "url_tree": f"{GITHUB_TREE}/{encoded}",
                "url_downgit": f"https://downgit.github.io/#/home?url={GITHUB_TREE}/{encoded}",
                "keywords": folder_keywords,
                "categorias": folder_categories,
                "categoria": categoria,
                "hijos": children,
            })
        elif entry.is_file():
            ext = entry.suffix.lower()
            items.append({
                "tipo": "archivo",
                "nombre": entry.name,
                "extension": ext.lstrip('.'),
                "url_raw":  f"{GITHUB_RAW}/{encoded}",
                "url_blob": f"{GITHUB_BLOB}/{encoded}",
                "keywords": sorted(kws),
                "categorias": categorias,
                "categoria": categoria,
            })
    return items


def build_materia(folder: Path) -> dict:
    rel      = f"Materias/{folder.name}"
    encoded  = url_encode_path(rel)
    slug     = slugify(folder.name)
    has_readme = (folder / "README.md").exists()

    contenido = scan_directory(folder, rel)
    seo = compute_seo(contenido)
    seo_public = seo_to_public(seo)

    return {
        "nombre":       folder.name,
        "slug":         slug,
        "url_buscador": f"{BASE_URL}/buscador/?materia={slug}",
        "url_github":   f"{GITHUB_TREE}/{encoded}",
        "url_downgit":  f"https://downgit.github.io/#/home?url={GITHUB_TREE}/{encoded}",
        "readme_raw":   f"{GITHUB_RAW}/{encoded}/README.md" if has_readme else None,
        "readme_blob":  f"{GITHUB_BLOB}/{encoded}/README.md" if has_readme else None,
        "seo":          seo_public,
        "contenido":    contenido,
    }


# ── Generación ────────────────────────────────────────────────────────────────

def generate_json():
    materias = []
    if not MATERIAS_DIR.exists():
        print(f"[WARN] No existe {MATERIAS_DIR}")
        return materias

    for folder in sorted(MATERIAS_DIR.iterdir()):
        if folder.is_dir():
            materias.append(build_materia(folder))
            print(f"  ✓ {folder.name}")

    OUTPUT_JSON.write_text(json.dumps(materias, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"\n[OK] JSON generado → {OUTPUT_JSON}  ({len(materias)} materias)")
    return materias


def generate_sitemap(materias: list):
    today = datetime.now(timezone.utc).strftime("%Y-%m-%d")

    lines = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"',
        '        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"',
        '        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9',
        '          http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">',
        '',
        '  <!-- Páginas estáticas -->',
    ]

    for page in STATIC_PAGES:
        lines += [
            '  <url>',
            f'    <loc>{xml_escape_loc(page["url"])}</loc>',
            f'    <lastmod>{today}</lastmod>',
            f'    <changefreq>{page["changefreq"]}</changefreq>',
            f'    <priority>{page["priority"]}</priority>',
            '  </url>',
        ]

    lines += ['', '  <!-- Páginas de materias (deep-link SEO) -->']

    for m in materias:
        seo_keywords = set((m.get("seo") or {}).get("keywords") or [])

        # Boost si hay material "final" (o categorías clave)
        base_priority = "0.8"
        if "final" in seo_keywords:
            base_priority = "0.95"
        elif seo_keywords:
            base_priority = "0.9"

        lines += [
            '  <url>',
            f'    <loc>{xml_escape_loc(m["url_buscador"])}</loc>',
            f'    <lastmod>{today}</lastmod>',
            '    <changefreq>weekly</changefreq>',
            f'    <priority>{base_priority}</priority>',
            '  </url>',
        ]

        # Deep-links SEO por keyword: /buscador/?materia=...&kw=final
        # (no cambia la UX: solo habilita indexación por términos)
        for kw in sorted(seo_keywords):
            if kw not in SEO_KEYWORDS:
                continue
            url = f"{BASE_URL}/buscador/?materia={m['slug']}&kw={kw}"
            pr = "0.9" if kw == "final" else "0.85"
            lines += [
                '  <url>',
                f'    <loc>{xml_escape_loc(url)}</loc>',
                f'    <lastmod>{today}</lastmod>',
                '    <changefreq>weekly</changefreq>',
                f'    <priority>{pr}</priority>',
                '  </url>',
            ]

    lines.append('</urlset>')
    SITEMAP_OUT.write_text('\n'.join(lines) + '\n', encoding="utf-8")
    print(f"[OK] Sitemap generado → {SITEMAP_OUT}  ({len(materias)} materias + {len(STATIC_PAGES)} páginas estáticas)")


def collect_pdfs(contenido: list) -> list:
    """Recorre recursivamente el árbol de contenido y devuelve todos los archivos PDF."""
    pdfs = []
    for item in contenido or []:
        if item.get("tipo") == "archivo" and item.get("extension", "").lower() == "pdf":
            pdfs.append(item)
        elif item.get("tipo") == "carpeta":
            pdfs.extend(collect_pdfs(item.get("hijos") or []))
    return pdfs


def generate_pdf_sitemap(materias: list):
    """
    Genera sitemap_pdfs.xml con las URLs raw de cada PDF del repositorio.

    Nota: estos archivos residen en raw.githubusercontent.com (no en GitHub Pages)
    porque el deploy solo sirve el directorio /docs.  Google indexa contenido de
    raw.githubusercontent.com para repos públicos, así que incluirlos aquí ayuda
    a que Googlebot los descubra y los indexe directamente.
    Podés someter este sitemap por separado en Google Search Console.
    """
    today = datetime.now(timezone.utc).strftime("%Y-%m-%d")

    lines = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"',
        '        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"',
        '        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9',
        '          http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">',
        '',
        '  <!-- PDFs del repositorio UNNE-LSI (raw.githubusercontent.com) -->',
        '  <!-- Submití este sitemap en Google Search Console para indexar el contenido de cada PDF -->',
    ]

    total_pdfs = 0
    for m in materias:
        pdfs = collect_pdfs(m.get("contenido") or [])
        if not pdfs:
            continue

        lines.append(f'\n  <!-- {m["nombre"]} -->')
        for pdf in pdfs:
            url = pdf.get("url_raw")
            if not url:
                continue
            # Prioridad según categoría del archivo
            categoria = pdf.get("categoria") or ""
            if categoria == "Final":
                priority = "0.8"
            elif categoria in ("Parcial", "Examen"):
                priority = "0.7"
            else:
                priority = "0.6"

            lines += [
                '  <url>',
                f'    <loc>{xml_escape_loc(url)}</loc>',
                f'    <lastmod>{today}</lastmod>',
                '    <changefreq>monthly</changefreq>',
                f'    <priority>{priority}</priority>',
                '  </url>',
            ]
            total_pdfs += 1

    lines.append('</urlset>')
    PDF_SITEMAP_OUT.write_text('\n'.join(lines) + '\n', encoding="utf-8")
    print(f"[OK] PDF Sitemap generado → {PDF_SITEMAP_OUT}  ({total_pdfs} PDFs)")


def generate_robots():
    """Genera robots.txt asegurando que /buscador/ no esté bloqueado y que el sitemap sea visible."""
    lines = [
        "User-agent: Googlebot",
        "Allow: /",
        "",
        "User-agent: Bingbot",
        "Allow: /",
        "",
        "User-agent: *",
        "Allow: /",
        "",
        f"Sitemap: {BASE_URL}/sitemap.xml",
        f"Sitemap: {BASE_URL}/sitemap_pdfs.xml",
        "",
    ]
    ROBOTS_OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"[OK] Robots generado → {ROBOTS_OUT}")


# ── Entry point ───────────────────────────────────────────────────────────────

if __name__ == "__main__":
    print("=" * 60)
    print("  LSI Tools — build_data.py")
    print("=" * 60)
    print(f"\n📁 Escaneando {MATERIAS_DIR} …\n")
    materias = generate_json()
    print(f"\n🗺️  Generando sitemap …")
    generate_sitemap(materias)
    print(f"\n📄 Generando sitemap de PDFs …")
    generate_pdf_sitemap(materias)
    print(f"\n🤖 Generando robots.txt …")
    generate_robots()
    print("\n✅ Build completo.\n")
