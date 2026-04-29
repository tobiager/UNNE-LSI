// Detecta si estamos en GitHub Pages (/UNNE-LSI/...) o en servidor local
const SITE_BASE = location.pathname.startsWith('/UNNE-LSI') ? '/UNNE-LSI' : '';
window.SITE_BASE = SITE_BASE;

async function loadComponent(id, url) {
  const el = document.getElementById(id);
  if (!el) return;
  try {
    const resp = await fetch(url);
    el.innerHTML = await resp.text();
    if (id === 'navbar') {
      // Parchea los hrefs del navbar para usar el base correcto
      el.querySelectorAll('a[href^="/UNNE-LSI"]').forEach(a => {
        a.setAttribute('href', SITE_BASE + a.getAttribute('href').slice('/UNNE-LSI'.length));
      });
      document.dispatchEvent(new Event('navbarLoaded'));
      // Fuerza al iframe a recalcular su viewport para que unidades como
      // svh/dvh reflejen el alto correcto (sin el navbar vacío inicial).
      const iframe = document.getElementById('content');
      if (iframe && iframe.contentWindow) {
        try { iframe.contentWindow.dispatchEvent(new Event('resize')); } catch (_) {}
      }
    }
    if (id === 'footer') {
      const updateFooterHeight = () => {
        const footer = document.querySelector('footer');
        if (footer) {
          document.documentElement.style.setProperty('--footer-h', footer.offsetHeight + 'px');
        }
      };
      updateFooterHeight();
      window.addEventListener('resize', updateFooterHeight);
    }
  } catch (e) {
    console.error('Error loading', url, e);
  }
}

loadComponent('navbar', `${SITE_BASE}/navbar/navbar.html`);
loadComponent('footer', `${SITE_BASE}/footer/footer.html`);
