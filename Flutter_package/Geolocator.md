```dart
import 'package:geolocator/geolocator.dart';

void getLocation() async {
    bool serviceEnabled; //위도 경도
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;

    print('Latitude: $latitude, Longitude: $longitude');
  }

  _loadId() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      address = (_prefs!.getString('realhome') ?? address);
    });
  }
```