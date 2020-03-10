import 'package:location/location.dart';
import 'package:momentoo/shared/domain/user_location.dart';
import 'package:rxdart/rxdart.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();
  factory LocationService() {
    return _singleton;
  }
  UserLocation _currentLocation;

  Location location = Location();

  // bool _serviceEnabled;
  PermissionStatus _permissionStatus;

  BehaviorSubject<UserLocation> _locationSubject =
      BehaviorSubject<UserLocation>();

  Stream<UserLocation> get location$ => _locationSubject.stream;
  Sink<UserLocation> get inFilter => _locationSubject.sink;

  LocationService._internal() {
    // Request permission to use location
    location.requestPermission().then(
      (status) {
        if (status == PermissionStatus.GRANTED) {
          location.getLocation().asStream().listen(
            (locationData) {
              if (locationData != null) {
                _locationSubject.add(
                  UserLocation(
                    latitude: locationData.latitude,
                    longitude: locationData.longitude,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Future<UserLocation> getLocation() async {
    try {
//      _serviceEnabled = await location.serviceEnabled();
//      if (!_serviceEnabled) {
//        _serviceEnabled = await location.requestService();
//        if (!_serviceEnabled) {
////          return;
//        }
//      }
//
//      _permissionGranted = await location.hasPermission();
//      if (_permissionGranted == PermissionStatus.DENIED) {
//        _permissionGranted = await location.requestPermission();
//        if (_permissionGranted != PermissionStatus.GRANTED) {
////          return;
//        }
//      }

      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}
