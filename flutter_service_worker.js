'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "android-chrome-192x192.png": "4eca5166b6a10d453b472e9d4306b064",
"android-chrome-512x512.png": "254e5fb5d3f0e77caa6f24fd18037ed2",
"apple-touch-icon.png": "2f53df58f60b9c09fdeaa6f2666e1ba2",
"assets/AssetManifest.json": "747936e8d226489cdea80d1e35703739",
"assets/assets/images/broken_heart.svg": "a906be2bbdb6985b3acd2493d2d40882",
"assets/assets/images/default_profile.png": "fb7c998b3c0f3b92bae0c99b58d65d24",
"assets/assets/images/example.png": "7f66cb0b9bfadea3a7581869df4e6e01",
"assets/assets/images/facebook.png": "6aa4a2e796d696e3449cc21154dfba42",
"assets/assets/images/goal.svg": "93b60e1af3a7f6a8991083ce6b382e36",
"assets/assets/images/google.png": "e777d8b7ec408e3b2efc449f80ff07e4",
"assets/assets/images/icon.png": "192ef205d032f0302ab06013580560e1",
"assets/assets/images/image%252042.jpg": "d9d1c1eb56485c6ad86bbfec7d32ec0a",
"assets/assets/images/kakao.png": "6548ac143a84d93dce2631a9a383ae4f",
"assets/assets/images/left_arrow.svg": "02a97d8fba7fd42ee8ff56cabb72c3d6",
"assets/assets/images/like.svg": "9490b776e3a570c79d694667b3c6716e",
"assets/assets/images/like_true.svg": "17a42eefa7b2689f900db134347283b3",
"assets/assets/images/main.svg": "ad443bd24b5eb9aa16a5ccb6892a776b",
"assets/assets/images/main_color.svg": "f18e09cc832888041e45bdb872ad211c",
"assets/assets/images/message.svg": "c86fb5aee1066ea21d1fdaab88ea0b04",
"assets/assets/images/none.png": "56a4ad05dd7e44892bb5a07c880b87f6",
"assets/assets/images/none.svg": "cb659b912eae097828037cc4631f0167",
"assets/assets/images/post.svg": "9fa76e525e177235ec85829369a5e613",
"assets/assets/images/rabbi.svg": "339f7815b854bf98143dd8e8d8ba8473",
"assets/assets/images/right_arrow.svg": "fc216ee54a9483df33b8c592d452f1e8",
"assets/assets/images/search.svg": "afbbf715e6a450d90376e705d1d9445b",
"assets/assets/images/share.svg": "fe8e25ae2490fd299ad6449eb9062961",
"assets/assets/images/small_message.svg": "6bffe7c90a5527cc9e2ffa203acdba25",
"assets/assets/images/spam.svg": "fc60dbe33363bd369beace928c337d87",
"assets/assets/images/user.svg": "20996060e07305b5f9a615151d0f1ab5",
"assets/assets/images/user_color.svg": "26743ef428c2172ef35bdf13cff0a709",
"assets/assets/lottie/like.json": "c4eff1df62eb3d64c7d0a5dfe6f220af",
"assets/FontManifest.json": "cde881daf36bec0a8fb9c358bd44eca5",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/fonts/Pretendard/Pretendard-Bold.ttf": "0723ee5b938e98ab35833119ed9f973d",
"assets/fonts/Pretendard/Pretendard-Medium.ttf": "57a61eff81918a74f97ba593d08937eb",
"assets/fonts/tenada/Tenada.ttf": "0ba8366fb06b6b4c2fe9d6b83ac85bcf",
"assets/NOTICES": "cd04dbafdc4bed9b7aabd9e0eb59d70b",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/shaders/ink_sparkle.frag": "907f2185702083fb7193562a0dde16be",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"favicon-16x16.png": "a273bda21cfaca969a3e7e048ee7c914",
"favicon-32x32.png": "9b23fd321cf1e32bcf20822410bec7d6",
"favicon.ico": "af95f25f8652cbe511920d32db85e846",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "77871ae556c2520372ed78a32b69803c",
"/": "77871ae556c2520372ed78a32b69803c",
"main.dart.js": "10588f8d81f988ba41e702a78c37e284",
"manifest.json": "3deed96a92ef19d6b9d64aef9a977274",
"splash/img/dark-1x.png": "f88321e35b5e5a83a6513628454e4a79",
"splash/img/dark-2x.png": "30ba021c537703c9233005e372c6f29f",
"splash/img/dark-3x.png": "4b5baa5365b37adb98782bd348936ea0",
"splash/img/dark-4x.png": "67f908c37d525f6f1556d739f6bf1988",
"splash/img/light-1x.png": "f88321e35b5e5a83a6513628454e4a79",
"splash/img/light-2x.png": "30ba021c537703c9233005e372c6f29f",
"splash/img/light-3x.png": "4b5baa5365b37adb98782bd348936ea0",
"splash/img/light-4x.png": "67f908c37d525f6f1556d739f6bf1988",
"splash/splash.js": "f6ee10f0a11f96089a97623ece9a1367",
"splash/style.css": "59d66af6467e267ed2e58873f28cdb24",
"version.json": "2ac9c3ae70b97547b9b398f8bbd72e3f"
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
