import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  /// A generic function that takes in a PermissionGroup to request a permission of what we want.
  Future<bool> _requestPermission(Permission permission) async {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }

    return false;
  }

  /// Requests the users permission to read their contacts.
  Future<bool> requestContactsPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.contacts);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

  /// Requests the users permission to read their location when the app is in use
  Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.locationWhenInUse);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

  /// A generic function to check if the app has a permission already.
  Future<bool> _hasPermission(Permission permission) async {
    var permissionStatus = await permission.status;
    return permissionStatus == PermissionStatus.granted;
  }

  /// Check if the app has (contacts permission) already.
  Future<bool> hasContactsPermission() async {
    return _hasPermission(Permission.contacts);
  }

  /// Check if the app has (location permission) already.
  Future<bool> hasLocationPermission() async {
    return _hasPermission(Permission.locationWhenInUse);
  }
}
