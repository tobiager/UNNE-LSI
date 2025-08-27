async function loadComponent(id, url) {
  const el = document.getElementById(id);
  if (!el) return;
  try {
    const resp = await fetch(url);
    el.innerHTML = await resp.text();
  } catch (e) {
    console.error('Error loading', url, e);
  }
}

loadComponent('navbar', 'navbar/navbar.html');
loadComponent('footer', 'footer/footer.html');
