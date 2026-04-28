(function(){
  window.showAlert = function(msg){
    const wrap = document.getElementById('alerts');
    if(!wrap) return;
    const el = document.createElement('div');
    el.className = 'alert';
    el.textContent = msg;
    wrap.appendChild(el);
    setTimeout(()=>el.remove(),4000);
  };

  document.addEventListener('navbarLoaded', () => {
    const frame = document.getElementById('content');
    const links = document.querySelectorAll('header nav a, header a.brand');
    const mobileBtn = document.getElementById('mobile-menu-btn');
    const navLinksContainer = document.getElementById('nav-links');

    if (mobileBtn && navLinksContainer) {
      mobileBtn.addEventListener('click', () => {
        navLinksContainer.classList.toggle('active');
      });
    }

    const routes = {
      '#home': 'home.html',
      '#simulador': 'simulador.html',
      '#buscador': 'buscador.html',
      '#calendario': 'calendario.html',
      '#estado': 'estado.html'
    };

    function loadFromHash(){
      const full = location.hash || '#home';
      const [hash,param] = full.split(':');
      const route = routes[hash] || 'home.html';
      frame.src = param ? `${route}#${param}` : route;
    }

    links.forEach(link => {
      link.addEventListener('click', (e) => {
        e.preventDefault();
        if (navLinksContainer && navLinksContainer.classList.contains('active')) {
          navLinksContainer.classList.remove('active');
        }
        history.pushState(null, '', link.getAttribute('href'));
        loadFromHash();
      });
    });

    window.addEventListener('popstate', loadFromHash);
    window.addEventListener('hashchange', loadFromHash);
    loadFromHash();
  });
})();
