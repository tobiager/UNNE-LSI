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
})();
