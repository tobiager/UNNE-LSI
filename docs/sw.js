const CACHE = 'lsi-tools-v1';
const PRECACHE = [
  '/UNNE-LSI/',
  '/UNNE-LSI/buscador/',
  '/UNNE-LSI/simulador/',
  '/UNNE-LSI/calendario/',
  '/UNNE-LSI/materias.json',
  '/UNNE-LSI/css/index.css',
  '/UNNE-LSI/css/buscador.css',
  '/UNNE-LSI/layout/layout.js',
  '/UNNE-LSI/app.js',
  '/UNNE-LSI/navbar/navbar.html',
  '/UNNE-LSI/footer/footer.html',
  '/UNNE-LSI/home.html',
];

self.addEventListener('install', e => {
  self.skipWaiting();
  // Cachear individualmente: un fallo no cancela el resto
  e.waitUntil(
    caches.open(CACHE).then(cache =>
      Promise.allSettled(PRECACHE.map(url => cache.add(url).catch(() => {})))
    )
  );
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    ).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const url = new URL(e.request.url);

  // Solo cachear requests del mismo origen o assets de GitHub
  if (url.origin !== self.location.origin &&
      !url.hostname.includes('githubusercontent.com') &&
      !url.hostname.includes('fonts.googleapis.com') &&
      !url.hostname.includes('fonts.gstatic.com')) {
    return;
  }

  // Network-first para materias.json (datos frescos cuando hay red)
  if (url.pathname.includes('materias.json')) {
    e.respondWith(
      fetch(e.request)
        .then(res => {
          const clone = res.clone();
          caches.open(CACHE).then(cache => cache.put(e.request, clone));
          return res;
        })
        .catch(() => caches.match(e.request))
    );
    return;
  }

  // Cache-first para el resto (fuentes, CSS, JS, HTML de páginas)
  e.respondWith(
    caches.match(e.request).then(cached => {
      if (cached) return cached;
      return fetch(e.request).then(res => {
        if (res.ok) {
          const clone = res.clone();
          caches.open(CACHE).then(cache => cache.put(e.request, clone));
        }
        return res;
      });
    })
  );
});
