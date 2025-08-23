<!-- Banner -->
<p align="center">
  <a href="https://github.com/tobiager/UNNE-LSI">
    <img src="./assets/banner2.jpeg" alt="Guía de Contribución" width="1000">
  </a>
</p>

<h1 align="center"> Guía de Contribución</h1>

¡Gracias por tu interés en colaborar con este repositorio de **LSI UNNE**! 🎓  
Este espacio busca ser una **fuente abierta** de apuntes, prácticos y guías de cursada para estudiantes de la **Licenciatura en Sistemas de Información (FaCENA – UNNE)**.  


---

##  Cómo contribuir

1. **Abrí un Issue**
   - Antes de subir algo nuevo, creá un [Issue](../../issues) usando la plantilla correspondiente ("Nueva materia/aporte" o "Corrección de contenido existente") para contar qué querés aportar o mejorar.
   - Ejemplos: *“Subo resumen de BD1”*, *“Agrego parciales de Paradigmas”*, *“Corregí un error en el TP de AED2”*.

2. **Creá una Rama (branch)**
   - Usá este formato:
     ```
     materia/<materia>-<cambio>
     ```
   - Ejemplo: `materia/bd1-resumen-parcial`.

3. **Pull Request**
   - Hacé tu PR hacia la rama `main`.
   - Incluí una breve descripción del aporte.
   - Completá el template del Pull Request, enlazando el Issue y agregando capturas si corresponde.

---
##  Organización del contenido

El repositorio está organizado así:

```
Materias/
  ├── AED1/
  │   ├── README.md
  │   └── practicos/
  ├── POO/
  └── ...
planes/
  ├── 2009.md
  └── 2023.md
meta/
assets/
```

 Reglas básicas:
- Cada materia debe tener su propio `README.md` explicando qué hay adentro.  
- Usá subcarpetas (`practicos`, `parciales`, `resumenes`) cuando haga falta.  
- Los archivos deben tener nombres descriptivos y sin espacios.  

---

##  Estilo y consistencia

- Usá **Markdown** (`.md`) para apuntes, guías y explicaciones.  
- Si subís **código**, nombrá los archivos con extensión clara (`.java`, `.cpp`, `.sql`).  
- Evitá subir PDFs pesados → mejor subir `.md` o `.tex` + link al original.  
- Screenshots: guardalos en `assets/` o dentro de la carpeta de la materia.  

---

##  Licencia

- Todo el contenido textual está bajo [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).  
- Código y plantillas: licencia [MIT](./LICENSE).  
- Asegurate de **no subir material con copyright** (libros escaneados, papers completos, etc.).  

---

##  Tips para aportar mejor

- Usá lenguaje claro y simple, pensando en estudiantes que recién arrancan.  
- No subas cosas personales (fotos, chats, mails).  
- Si tenés dudas, abrí un Issue antes de mandar el PR.  

---

<p align="center"><b>❤️🐔 Todo aporte suma — que este repo le sirva a la próxima generación de estudiantes LSI.</b></p>
