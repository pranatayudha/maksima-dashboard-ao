// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:developer' as developer;

import 'package:address_search_field/address_search_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:location/location.dart' as loc;

import '../../flavors.dart';
import '../app/app.locator.dart';
import '../enums/dialog_type.dart';
import '../models/user_location.dart';

class MaksimaLocationService {
  loc.Location location = loc.Location();

  final StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  final geoMethods = GeoMethods(
    googleApiKey: Flavor == Flavor.LOCAL
        ? F.sharedMap['googleAPIKeyLocal']!
        : F.sharedMap['googleAPIKey']!,
    language: 'ID',
    countryCode: 'id',
  );

  MaksimaLocationService() {
    GoogleMapsPlaces(
      apiKey: Flavor == Flavor.LOCAL
          ? F.sharedMap['googleAPIKeyLocal'] as String
          : F.sharedMap['googleAPIKey'] as String,
    );

    requestLocPermission();
  }

  Future<loc.PermissionStatus> requestLocPermission() async {
    final permission = await location.requestPermission();

    if (permission == loc.PermissionStatus.granted) {
      Geolocator.getPositionStream().listen((position) async {
        if (!_locationStreamController.isClosed) {
          try {
            _locationStreamController.add(
              UserLocation(
                latitude: position.latitude,
                longitude: position.longitude,
                isMocked: position.isMocked,
              ),
            );
          } catch (e) {
            developer.log(e.toString());
          }
        }
      });
    } else if (permission == loc.PermissionStatus.denied ||
        permission == loc.PermissionStatus.deniedForever) {
      _showErrorDialog('Akses tidak diizinkan untuk mendapatkan lokasi');
    }

    return permission;
  }

  Future<UserLocation?> getLocation() async {
    UserLocation? currentLocation;
    loc.PermissionStatus? permission;
    final hasPermission = await location.hasPermission();

    if (hasPermission == loc.PermissionStatus.denied ||
        hasPermission == loc.PermissionStatus.deniedForever) {
      permission = await requestLocPermission();
    }

    if (permission == loc.PermissionStatus.granted ||
        hasPermission == loc.PermissionStatus.granted) {
      try {
        final userLocation = await Geolocator.getCurrentPosition();
        currentLocation = UserLocation(
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
          isMocked: userLocation.isMocked,
        );
      } on Exception catch (e) {
        developer.log('Could not get location: ${e.toString()}');
      }
    }

    return currentLocation;
  }

  final _dialogService = locator<DialogService>();
  Future _showErrorDialog(String desc) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.error,
      title: 'Error',
      description: desc,
      mainButtonTitle: 'COBA LAGI',
    );
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    GeocodingResponse place = await GoogleMapsGeocoding(
      apiKey: Flavor == Flavor.LOCAL
          ? F.sharedMap['googleAPIKeyLocal'] as String
          : F.sharedMap['googleAPIKey'] as String,
    ).searchByLocation(Location(lat: latitude, lng: longitude));

    return place.results.first.formattedAddress.toString();
  }

  Future<LatLng> getAddressFromPlaceId(String placeId) async {
    GeocodingResponse place = await GoogleMapsGeocoding(
      apiKey: Flavor == Flavor.LOCAL
          ? F.sharedMap['googleAPIKeyLocal'] as String
          : F.sharedMap['googleAPIKey'] as String,
    ).searchByPlaceId(placeId);

    return LatLng(
      place.results.first.geometry.location.lat,
      place.results.first.geometry.location.lng,
    );
  }

  Future<List<Address>> autocompletePlace({required String query}) async {
    final List<Address> data = await geoMethods.autocompletePlace(query: query);

    return data;
  }

  Future<GeocodingResult> getAddressLatLng(
    double latitude,
    double longitude,
  ) async {
    GeocodingResponse place = await GoogleMapsGeocoding(
      apiKey: Flavor == Flavor.LOCAL
          ? F.sharedMap['googleAPIKeyLocal'] as String
          : F.sharedMap['googleAPIKey'] as String,
    ).searchByLocation(Location(lat: latitude, lng: longitude));

    return place.results.first;
  }

  void dispose() => _locationStreamController.close();
}
