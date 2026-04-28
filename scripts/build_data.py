#!/usr/bin/env python3
"""
build_data.py — Motor de automatización LSI Tools
Recorre /Materias, genera docs/materias.json y docs/sitemap.xml
"""

import os
import json
import re
from datetime import datetime, timezone
from pathlib import Path

# ── Configuración ──────────────────────────────────────────────────────────────
REPO_ROOT   = Path(__file__).resolve().parent.parent
MATERIAS_DIR = REPO_ROOT / "Materias"
DOCS_DIR    = REPO_ROOT / "docs"
OUTPUT_JSON  = DOCS_DIR / "materias.json"
SITEMAP_OUT  = DOCS_DIR / "sitemap.xml"

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


def url_encode_path(path: str) -> str:
    """Reemplaza espacios por %20 en paths de URL (sin romper slashes)."""
    return '/'.join(part.replace(' ', '%20') for part in path.split('/'))


def scan_directory(base_path: Path, rel_prefix: str) -> list:
    """Recorre un directorio y devuelve lista de {tipo, nombre, url_raw, url_blob}."""
    items = []
    try:
        entries = sorted(base_path.iterdir(), key=lambda p: (p.is_file(), p.name.lower()))
    except PermissionError:
        return items

    for entry in entries:
        rel = f"{rel_prefix}/{entry.name}"
        encoded = url_encode_path(rel)
        if entry.is_dir():
            items.append({
                "tipo": "carpeta",
                "nombre": entry.name,
                "url_tree": f"{GITHUB_TREE}/{encoded}",
                "url_downgit": f"https://downgit.github.io/#/home?url={GITHUB_TREE}/{encoded}",
                "hijos": scan_directory(entry, rel)
            })
        elif entry.is_file():
            ext = entry.suffix.lower()
            items.append({
                "tipo": "archivo",
                "nombre": entry.name,
                "extension": ext.lstrip('.'),
                "url_raw":  f"{GITHUB_RAW}/{encoded}",
                "url_blob": f"{GITHUB_BLOB}/{encoded}",
            })
    return items


def build_materia(folder: Path) -> dict:
    rel      = f"Materias/{folder.name}"
    encoded  = url_encode_path(rel)
    slug     = slugify(folder.name)
    has_readme = (folder / "README.md").exists()

    return {
        "nombre":       folder.name,
        "slug":         slug,
        "url_buscador": f"{BASE_URL}/buscador/?materia={slug}",
        "url_github":   f"{GITHUB_TREE}/{encoded}",
        "url_downgit":  f"https://downgit.github.io/#/home?url={GITHUB_TREE}/{encoded}",
        "readme_raw":   f"{GITHUB_RAW}/{encoded}/README.md" if has_readme else None,
        "readme_blob":  f"{GITHUB_BLOB}/{encoded}/README.md" if has_readme else None,
        "contenido":    scan_directory(folder, rel),
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
            f'    <loc>{page["url"]}</loc>',
            f'    <lastmod>{today}</lastmod>',
            f'    <changefreq>{page["changefreq"]}</changefreq>',
            f'    <priority>{page["priority"]}</priority>',
            '  </url>',
        ]

    lines += ['', '  <!-- Páginas de materias (deep-link SEO) -->']

    for m in materias:
        lines += [
            '  <url>',
            f'    <loc>{m["url_buscador"]}</loc>',
            f'    <lastmod>{today}</lastmod>',
            '    <changefreq>weekly</changefreq>',
            '    <priority>0.8</priority>',
            '  </url>',
        ]

    lines.append('</urlset>')
    SITEMAP_OUT.write_text('\n'.join(lines), encoding="utf-8")
    print(f"[OK] Sitemap generado → {SITEMAP_OUT}  ({len(materias)} materias + {len(STATIC_PAGES)} páginas estáticas)")


# ── Entry point ───────────────────────────────────────────────────────────────

if __name__ == "__main__":
    print("=" * 60)
    print("  LSI Tools — build_data.py")
    print("=" * 60)
    print(f"\n📁 Escaneando {MATERIAS_DIR} …\n")
    materias = generate_json()
    print(f"\n🗺️  Generando sitemap …")
    generate_sitemap(materias)
    print("\n✅ Build completo.\n")
