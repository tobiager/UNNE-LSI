(function(){
  // ── Service Worker (offline / PWA) ───────────────────────────
  if ('serviceWorker' in navigator) {
    const base = location.pathname.startsWith('/UNNE-LSI') ? '/UNNE-LSI' : '';
    navigator.serviceWorker.register(base + '/sw.js', { scope: base + '/' })
      .catch(() => {});
  }

  function ensureLinkButtonLabels(root){
    try {
      const scope = root || document;
      scope.querySelectorAll('a, button').forEach(el => {
        if (el.hasAttribute('aria-label') || el.hasAttribute('title')) return;
        const txt = (el.textContent || '').replace(/\s+/g, ' ').trim();
        if (!txt) return;
        el.setAttribute('title', txt);
      });
    } catch (e) {}
  }

  window.showAlert = function(msg){
    const wrap = document.getElementById('alerts');
    if(!wrap) return;
    const el = document.createElement('div');
    el.className = 'alert';
    el.textContent = msg;
    wrap.appendChild(el);
    setTimeout(()=>el.remove(),4000);
  };

  // Base pass (covers static DOM)
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => ensureLinkButtonLabels(document));
  } else {
    ensureLinkButtonLabels(document);
  }

  document.addEventListener('navbarLoaded', () => {
    const mobileBtn = document.getElementById('mobile-menu-btn');
    const navLinksContainer = document.getElementById('nav-links');

    if (mobileBtn && navLinksContainer) {
      mobileBtn.addEventListener('click', () => {
        navLinksContainer.classList.toggle('active');
      });

      navLinksContainer.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', () => {
          navLinksContainer.classList.remove('active');
        });
      });
    }

    // Navbar/footer are injected dynamically; label them too.
    ensureLinkButtonLabels(document);
  });

  // ── GitHub Stars: fetch once per day, cache in localStorage ─
  (() => {
    try {
      const STARS_KEY = 'gh-stars';
      const STARS_TS_KEY = 'gh-stars-ts';
      const CACHE_TTL = 24 * 60 * 60 * 1000; // 24 horas

      const fetchStars = async () => {
        const cached = localStorage.getItem(STARS_KEY);
        const ts = parseInt(localStorage.getItem(STARS_TS_KEY) || '0', 10);
        if (cached && Date.now() - ts < CACHE_TTL) return cached;

        const res = await fetch('https://api.github.com/repos/tobiager/UNNE-LSI', {
          headers: { 'Accept': 'application/vnd.github.v3+json' }
        });
        // Si hay rate-limit, devolvemos el valor cacheado aunque sea viejo
        if (res.status === 403 || res.status === 429) return cached || null;
        if (!res.ok) throw new Error(`API ${res.status}`);
        const data = await res.json();
        const count = String(data.stargazers_count);
        localStorage.setItem(STARS_KEY, count);
        localStorage.setItem(STARS_TS_KEY, String(Date.now()));
        return count;
      };

      const starsPromise = fetchStars().catch(() => localStorage.getItem(STARS_KEY));

      const applyStars = (doc) => {
        if (!doc) return;
        starsPromise.then(count => {
          if (!count) return;
          try {
            doc.querySelectorAll('.gh-stars-dynamic').forEach(el => { el.textContent = count; });
          } catch (e) {}
        });
      };

      applyStars(document);
      document.addEventListener('navbarLoaded', () => applyStars(document));

      const iframe = document.getElementById('content');
      if (iframe) {
        const tryIframe = () => {
          const doc = iframe.contentDocument;
          if (doc && doc.readyState !== 'loading') applyStars(doc);
        };
        tryIframe();
        iframe.addEventListener('load', () => applyStars(iframe.contentDocument));
      }
    } catch (e) {}
  })();
})();
