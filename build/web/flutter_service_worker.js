'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "5e1b7762ef27222986d3e85fe1ed17c0",
"splash/img/light-2x.png": "394e36450121e40ce079e0df06970e55",
"splash/img/dark-4x.png": "607a57f4ce5c3813a9273295840af16f",
"splash/img/light-3x.png": "892d7c6568626f08a7757fd8b3cb522b",
"splash/img/dark-3x.png": "892d7c6568626f08a7757fd8b3cb522b",
"splash/img/light-4x.png": "607a57f4ce5c3813a9273295840af16f",
"splash/img/dark-2x.png": "394e36450121e40ce079e0df06970e55",
"splash/img/dark-1x.png": "13a99f0d1b74d97d418597b22e5e045c",
"splash/img/light-1x.png": "13a99f0d1b74d97d418597b22e5e045c",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/style.css": "f72e3fd5e384d4a9e3b6aac1a628a3c9",
"index.html": "93c408b5f8182e7aa650be7c63b67941",
"/": "93c408b5f8182e7aa650be7c63b67941",
"main.dart.js": "615902fcb4024b57415aa0afc07ca36d",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"favicon.png": "e480b27a1df848707f83a40aa75ac246",
"icons/Icon-192.png": "03c2addb851b5342ae7b246ab4289b30",
"icons/Icon-maskable-192.png": "03c2addb851b5342ae7b246ab4289b30",
"icons/Icon-maskable-512.png": "735f59eba9a4900652d5dae066de464d",
"icons/Icon-512.png": "735f59eba9a4900652d5dae066de464d",
"manifest.json": "2f2601663932150f90644985ca721c9b",
"assets/AssetManifest.json": "2ce8c0622e6dacca551fe4d40b93dcb2",
"assets/NOTICES": "cbd58cc50a81913fc6f353bc9462d9c1",
"assets/FontManifest.json": "f6431feec6764b099549569fbea11006",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "cff3a75d0c2f92467c2098e9993e297e",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/example/8.png": "2002e7a9f280376dfb45522b6b55d163",
"assets/assets/example/9.png": "27bdf709605d8ad3eb9c05eabaf86413",
"assets/assets/example/14.png": "dd23d0b435c27e870135f9fa99677228",
"assets/assets/example/15.png": "41450e300a290cc595cf8be3aadb01f4",
"assets/assets/example/12.png": "174450a0d347a09cc6a25f8edfd94a14",
"assets/assets/example/13.png": "79ba43fcf3617bfaf15b4c446681f2b8",
"assets/assets/example/11.png": "b89c62b6bae73b76ff0767814fc6cc73",
"assets/assets/example/10.png": "0ea3c02c185a5d1e04169a411150b245",
"assets/assets/example/4.png": "c158037f58928e1bd8e9a4391b23c783",
"assets/assets/example/5.png": "4651d0daf771820481e473b78d43aa32",
"assets/assets/example/7.png": "8df02e8d62abb2ddfadaf3393525e34c",
"assets/assets/example/6.png": "10095cef02f1efe433d53f11f49c3c1d",
"assets/assets/example/2.png": "e98b18387a7c80c770c6f8ae1fd6bf85",
"assets/assets/example/3.png": "142a5a8388e8a616b9c59a9105d7ea82",
"assets/assets/example/1.png": "b00cd84a5e47873b622af4620fe13236",
"assets/assets/easy_daily_splash.png": "df58629804acbf28a8ec20df4ce87b65",
"assets/assets/fonts/Nanum_Myeongjo/NanumMyeongjo-Bold.ttf": "5ea37dfbbfbd9fb13421ffc6032f150a",
"assets/assets/fonts/Nanum_Myeongjo/NanumMyeongjo-Regular.ttf": "efdc1f63c31b3c0acc07777c2c2d8b38",
"assets/assets/fonts/Nanum_Myeongjo/NanumMyeongjo-ExtraBold.ttf": "bf37d995db642e86d6d45f2388e00a9b",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
