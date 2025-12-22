# OpenStreetMap Tile Usage Policy

## Issues Fixed

### 1. **OnBackInvokedCallback Warning**
- ✅ Added `android:enableOnBackInvokedCallback="true"` to AndroidManifest.xml
- This enables proper back navigation handling on Android 13+

### 2. **OpenStreetMap Tile Blocking**
Your app was being blocked due to violating OSM's tile usage policy. Fixed by:

- ✅ Added proper attribution display (© OpenStreetMap contributors)
- ✅ Updated user agent from `com.example.app` to `com.eventhub.app`
- ✅ Explicit tile size configuration (256px standard)
- ✅ Proper attribution builder widget

## OpenStreetMap Usage Policy Requirements

**DO:**
- ✅ Display visible attribution (© OpenStreetMap contributors)
- ✅ Use a proper, descriptive User-Agent header
- ✅ Respect HTTP caching headers
- ✅ Implement reasonable request rates
- ✅ Use HTTPS connections

**DON'T:**
- ❌ Hammer the tiles with rapid requests
- ❌ Use default/generic user agents
- ❌ Remove or hide attribution
- ❌ Cache tiles excessively without respecting headers
- ❌ Use OSM tiles for heavy commercial applications

## Recommended Tile Servers (if OSM tiles are blocked)

If you still experience blocking, consider these alternatives:

### 1. **Stamen Toner** (Free, reliable)
```dart
TileLayer(
  urlTemplate: 'https://tile.stamen.com/toner/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.eventhub.app',
)
```

### 2. **CartoDB Positron** (Free, clean style)
```dart
TileLayer(
  urlTemplate: 'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.eventhub.app',
  subdomains: ['a', 'b', 'c', 'd'],
)
```

### 3. **Google Maps** (Requires API key)
- Best performance but requires paid plan
- Need to use `google_maps_flutter` package instead

### 4. **Mapbox** (Requires API key)
- Professional service, excellent for events app
- Free tier available

## Rate Limiting Best Practices

Add to `mapScreen.dart` for production:

```dart
// Implement request throttling
Timer? _tileRequestThrottle;

void _throttledTileRequest() {
  _tileRequestThrottle?.cancel();
  _tileRequestThrottle = Timer(
    const Duration(milliseconds: 300),
    () {
      // Process tile request
    },
  );
}
```

## Testing

1. Rebuild and run the app:
```bash
flutter clean
flutter pub get
flutter run
```

2. Monitor logs for blocking messages
3. Verify attribution appears on map

## References
- OSM Tile Usage Policy: https://operations.osmfoundation.org/policies/tiles/
- Flutter Map Documentation: https://docs.fleaflet.dev/
