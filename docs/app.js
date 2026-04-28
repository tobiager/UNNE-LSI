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
  });
})();
