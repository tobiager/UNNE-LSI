const CACHE_NAME = 'lsi-cache-v1.4.0';

// Core shell: cached at install for offline baseline.
// HTML routes use NetworkFirst so new markup is always fetched when online.
const SHELL = [
  '/UNNE-LSI/',
  '/UNNE-LSI/home.html',
  '/UNNE-LSI/materias/',
  '/UNNE-LSI/simulador/',
  '/UNNE-LSI/calendario/',
  '/UNNE-LSI/navbar/navbar.html',
  '/UNNE-LSI/footer/footer.html',
  '/UNNE-LSI/materias.json',
  '/UNNE-LSI/site.webmanifest',
  '/UNNE-LSI/assets/icons/icon-192.png',
  '/UNNE-LSI/assets/icons/icon-512.png',
  '/UNNE-LSI/assets/lsi.png',
  '/UNNE-LSI/css/index.css',
  '/UNNE-LSI/app.js',
  '/UNNE-LSI/layout/layout.js',
];

// ── Install: skip waiting so new SW activates immediately ────────────────────
self.addEventListener('install', e => {
  self.skipWaiting();
  e.waitUntil(
    caches.open(CACHE_NAME).then(cache =>
      Promise.allSettled(SHELL.map(url => cache.add(url).catch(() => {})))
    )
  );
});

// ── Activate: delete every old cache, then claim all clients ─────────────────
self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys()
      .then(keys => Promise.all(
        keys.filter(k => k !== CACHE_NAME).map(k => caches.delete(k))
      ))
      .then(() => self.clients.claim())
  );
});

// ── Fetch ────────────────────────────────────────────────────────────────────
self.addEventListener('fetch', e => {
  const { request } = e;
  const url = new URL(request.url);

  // Pass through requests to unrecognized origins
  if (url.origin !== self.location.origin &&
      !url.hostname.includes('githubusercontent.com') &&
      !url.hostname.includes('fonts.googleapis.com') &&
      !url.hostname.includes('fonts.gstatic.com')) {
    return;
  }

  // NetworkFirst for HTML and JSON — always serve fresh content when online,
  // fall back to cache only when offline.
  const isHTML = request.mode === 'navigate' ||
                 url.pathname.endsWith('.html') ||
                 /\/UNNE-LSI\/(materias|simulador|calendario|estado)?\/?$/.test(url.pathname);
  const isData = url.pathname.endsWith('.json') || url.pathname.endsWith('.webmanifest');

  if (isHTML || isData) {
    e.respondWith(
      fetch(request)
        .then(res => {
          if (res.ok) {
            const clone = res.clone();
            caches.open(CACHE_NAME).then(c => c.put(request, clone));
          }
          return res;
        })
        .catch(() => caches.match(request))
    );
    return;
  }

  // CacheFirst for everything else: versioned CSS/JS (?v=...), fonts, images.
  // Versioned URLs are naturally cache-busted since they're different keys.
  e.respondWith(
    caches.match(request).then(cached => {
      if (cached) return cached;
      return fetch(request).then(res => {
        if (res.ok) {
          const clone = res.clone();
          caches.open(CACHE_NAME).then(c => c.put(request, clone));
        }
        return res;
      }).catch(() => Response.error());
    })
  );
});
