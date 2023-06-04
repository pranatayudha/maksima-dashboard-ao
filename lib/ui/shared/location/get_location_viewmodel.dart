import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:stacked/stacked.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/services/location_service.dart';

class GetLocationViewModel extends BaseViewModel {
  final _locationService = locator<MaksimaLocationService>();

  GoogleMapController? mapController;
  Set<Polyline> polylines = const <Polyline>{};
  Map<String, Marker> markers = {};
  Marker? markPoint;

  TextEditingController tagLocController = TextEditingController();

  List<Address> data = [];
  LatLng? initialPositon;
  LatLng? selectedLatlng;
  GeocodingResult? searchResult;

  int markCount = 0;

  Future initialize() async {
    initialPositon = await getPosition();
    selectedLatlng = initialPositon;
    notifyListeners();
  }

  void searchAddress(String keyword) async {
    data = await _locationService.autocompletePlace(query: keyword);
    notifyListeners();
  }

  void updateMapController(GoogleMapController ctrl, LatLng? latLng) {
    mapController = ctrl;
    setMarkPoint('_pin', latLng);
    notifyListeners();
  }

  void selectedLocation(Address location) async {
    tagLocController.text = location.reference ?? '-';
    initialPositon =
        await _locationService.getAddressFromPlaceId(location.placeId ?? '');
    data.clear();
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 18,
          target: LatLng(
            initialPositon?.latitude ?? 0,
            initialPositon?.longitude ?? 0,
          ),
        ),
      ),
    );
    notifyListeners();
  }

  void setMarkPoint(String id, LatLng? latLng) async {
    selectedLatlng = latLng;
    tagLocController.text = await _locationService.getAddressFromLatLng(
      latLng?.latitude ?? 0,
      latLng?.longitude ?? 0,
    );
    searchResult = await _locationService.getAddressLatLng(
      latLng?.latitude ?? 0,
      latLng?.longitude ?? 0,
    );
    markers.clear();
    markCount++;
    notifyListeners();
    markPoint = Marker(
      markerId: MarkerId('${id}_$markCount'),
      position: latLng!,
    );
    markers[id] = markPoint!;
    notifyListeners();
  }

  Map<String, dynamic> callBackLoc() {
    return {
      'address': tagLocController.text,
      'latLng': selectedLatlng,
    };
  }

  Future<LatLng> getPosition() async {
    final loc.Location location = loc.Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) throw 'GPS service is disabled';
    }
    if (await location.hasPermission() == loc.PermissionStatus.denied) {
      if (await location.requestPermission() != loc.PermissionStatus.granted) {
        throw 'No GPS permissions';
      }
    }
    final loc.LocationData data = await location.getLocation();

    return LatLng(data.latitude!, data.longitude!);
  }
}
