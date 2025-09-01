async function loadComponent(id, url) {
  const el = document.getElementById(id);
  if (!el) return;
  try {
    const resp = await fetch(url);
    el.innerHTML = await resp.text();
    if (id === 'navbar') {
      document.dispatchEvent(new Event('navbarLoaded'));
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

loadComponent('navbar', 'navbar/navbar.html');
loadComponent('footer', 'footer/footer.html');
