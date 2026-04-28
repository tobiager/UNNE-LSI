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
      const cached = sessionStorage.getItem('gh-stars');
      const fetchStars = async () => {
        if (cached) return cached;
        const res = await fetch('https://api.github.com/repos/tobiager/UNNE-LSI');
        if (!res.ok) throw new Error('API Error');
        const data = await res.json();
        return String(data.stargazers_count);
      };
      
      const starsPromise = fetchStars().catch(() => null);

      const applyStars = (doc) => {
        if (!doc) return;
        starsPromise.then(count => {
          if (!count) return; // Mantener valor por defecto si falla
          sessionStorage.setItem('gh-stars', count);
          try {
            doc.querySelectorAll('.gh-stars-dynamic').forEach(el => {
              el.textContent = count;
            });
          } catch (e) {}
        });
      };

      // Apply to main document
      applyStars(document);

      // Apply when navbar loads (since navbar has a star count)
      document.addEventListener('navbarLoaded', () => applyStars(document));

      // Apply to iframe if it exists (for index.html wrapping home.html)
      const iframe = document.getElementById('content');
      if (iframe) {
        applyStars(iframe.contentDocument);
        iframe.addEventListener('load', () => applyStars(iframe.contentDocument));
      }
    } catch (e) {}
  })();
})();
