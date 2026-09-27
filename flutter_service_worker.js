'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "8898e69518895c3ce1882caaafca3ef6",
"assets/AssetManifest.bin.json": "8d90aa205422a80aff32ef0584a41479",
"assets/AssetManifest.json": "1fa23144dd3354ce9787dc41363058e5",
"assets/assets/images/anime/ascendance_of_a_bookworm.webp": "e7b8b48815976dc5be1290afda4e43f1",
"assets/assets/images/anime/attack_on_titan.webp": "04d871f8135bf3cff3f6a2391460b004",
"assets/assets/images/anime/battle_through_the_heavens.webp": "73181ead2185f0d4ca72a1d9d3b85fbb",
"assets/assets/images/anime/case_closed.webp": "0559705abada01869dcc24d94de0fc07",
"assets/assets/images/anime/death_note.webp": "9ef686246b694054cf580a6d8e37da25",
"assets/assets/images/anime/demon_slayer.webp": "4355e88c04d5f23365a0edebdcf78cae",
"assets/assets/images/anime/dorohedoro_s2.webp": "a145949bb384a9c1680dfd9d13395519",
"assets/assets/images/anime/end_this_love_game.webp": "084522eeafcb75bffc4f3c467c07e008",
"assets/assets/images/anime/initial_d_legend_3.webp": "49dbd4195d597b3a8f0ebfe6ae5583ee",
"assets/assets/images/anime/jujutsu_kaisen.webp": "060872475e15d2f8043e6cee62ae9e9b",
"assets/assets/images/anime/kaiju_no_8.webp": "3accc66223b854246dde17e8dac3d151",
"assets/assets/images/anime/kill_blue.webp": "0e93826ade4a02b56f1b998158d1640b",
"assets/assets/images/anime/medalist.webp": "5c2a24ecf453f387f38f0d08144f9cb4",
"assets/assets/images/anime/my_hero_academia.webp": "a4fb59b869f08e67599f07da85c673f9",
"assets/assets/images/anime/noble_on_the_brink_of_ruin.webp": "9fd5c42e9781f8b5a244add4b1ac94ed",
"assets/assets/images/anime/one_piece.webp": "13eae6d55518e2969615c22062404752",
"assets/assets/images/anime/pokemon_horizons.webp": "e8cbbc7f3b0188b22a435b1cc0e13ce4",
"assets/assets/images/anime/second_prettiest_girl.webp": "a7edd98c6cdaedabb3575ac74138e3dc",
"assets/assets/images/anime/shin_chan.webp": "324cc36efc10ca2b703b1de222ee6e62",
"assets/assets/images/anime/steel_ball_run_jojo.webp": "7ef5870b3b97c79de04e3d6475a46f7b",
"assets/assets/images/anime/steinsgate_0.webp": "2fc16e030f0c5921c6d3415b21b1f19b",
"assets/assets/images/anime/super_dragon_ball_heroes.webp": "967775a1e7b4886a1a30d2f65361a613",
"assets/assets/images/streamflix_bg.jpg": "41ad6dddac2303ac1d6cc52601215182",
"assets/assets/images/streamflix_intro.gif": "72e213f1b522bccf23e5408f02057e02",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "42c0cd7c916f96a2c5f0d7832901c8a9",
"assets/NOTICES": "011bd106a1cf8607cd026f160bb0fe36",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "866b1f01445aaa2389177703f36ddb22",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "e881a46bb56c2d977a73d752983c8e35",
"icons/Icon-192.png": "aad01e763c37e86da4a3c03f3a323f3f",
"icons/Icon-512.png": "226615dd09eeec6019a1860c7debfda9",
"index.html": "45c6a32a3e4c4fa3fc97025066061dac",
"/": "45c6a32a3e4c4fa3fc97025066061dac",
"main.dart.js": "73e1430beb306fef971347c7851b1bb4",
"manifest.json": "0e512a0304ab27d3c6da6612eded56f3",
"version.json": "ed4d148d6ecf77ea3535f8129147a9f3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
