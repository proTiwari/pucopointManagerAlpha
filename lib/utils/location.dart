import 'dart:async';
import 'package:location/location.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';

class MyLocation {
  late Map<String, dynamic> map = {};
  late LocationData? currentPosition = LocationData.fromMap(map);

  Location location = Location();

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentPosition = await location.getLocation();
    var currentLatPos = currentPosition?.latitude!.toDouble();
    var currentLongPos = currentPosition?.longitude!.toDouble();

    return await _getAddress(currentLatPos!, currentLongPos!);
  }

  Future _getAddress(double lat, double lang) async {
    var coordinates = Coordinates(lat, lang);
    List add = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    List loc = [];

    var first = add.first;
    loc.add(lat);
    loc.add(lang);
    loc.add(first);
   
    // print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return loc;
  }
}
