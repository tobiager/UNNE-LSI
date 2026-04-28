(function(){
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

  // ── GitHub Stars: fetch once, update everywhere ──────────────
  (() => {
    try {
      const fetchStars = async () => {
        const cached = sessionStorage.getItem('gh-stars');
        if (cached) {
          console.log('[Stars] Valor en caché:', cached);
          return cached;
        }
        const res = await fetch('https://api.github.com/repos/tobiager/UNNE-LSI');
        if (!res.ok) throw new Error(`API ${res.status}`);
        const data = await res.json();
        const count = String(data.stargazers_count);
        console.log('[Stars] API devolvió:', count);
        return count;
      };

      const starsPromise = fetchStars().catch(e => {
        console.warn('[Stars] Fetch falló:', e.message);
        return null;
      });

      const applyStars = (doc, label) => {
        if (!doc) return;
        starsPromise.then(count => {
          if (!count) return;
          sessionStorage.setItem('gh-stars', count);
          try {
            const els = doc.querySelectorAll('.gh-stars-dynamic');
            console.log(`[Stars] ${label}: encontró ${els.length} elemento(s), aplicando ${count}`);
            els.forEach(el => { el.textContent = count; });
          } catch (e) {}
        });
      };

      // Apply to main document
      applyStars(document, 'document');

      // Apply when navbar loads (since navbar has a star count)
      document.addEventListener('navbarLoaded', () => applyStars(document, 'document@navbarLoaded'));

      // Apply to iframe — check readyState to handle already-loaded (cached) iframes
      const iframe = document.getElementById('content');
      if (iframe) {
        const tryIframe = () => {
          const doc = iframe.contentDocument;
          if (doc && doc.readyState !== 'loading') {
            applyStars(doc, 'iframe@ready');
          }
        };
        tryIframe();
        iframe.addEventListener('load', () => applyStars(iframe.contentDocument, 'iframe@load'));
      }
    } catch (e) {
      console.error('[Stars] Error inesperado:', e);
    }
  })();
})();
