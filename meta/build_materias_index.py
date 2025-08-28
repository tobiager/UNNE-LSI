#!/usr/bin/env python3
import json
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
MATERIAS_DIR = REPO_ROOT / 'Materias'
OUTPUT = REPO_ROOT / 'docs' / 'materias.json'

index = []
for readme in sorted(MATERIAS_DIR.rglob('README.md'), key=lambda p: str(p).lower()):
    rel_repo = readme.relative_to(REPO_ROOT)
    rel_materias = readme.relative_to(MATERIAS_DIR)
    name = ' / '.join(rel_materias.parts[:-1])
    index.append({'nombre': name, 'ruta': str(rel_repo).replace('\\', '/')})

OUTPUT.parent.mkdir(parents=True, exist_ok=True)
with OUTPUT.open('w', encoding='utf-8') as f:
    json.dump(index, f, ensure_ascii=False, indent=2)

print(f'Escrito {OUTPUT} con {len(index)} entradas')
