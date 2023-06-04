import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';

import 'google_maps_view.dart';
import 'maps_location_view.dart';

class OpenMaps {
  // ignore: long-parameter-list
  void openPreview({
    required BuildContext context,
    required double width,
    required String title,
    required String nameTag,
    required LatLng location,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            content: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: GoogleMapsView(
                title: title,
                nameTag: nameTag,
                location: location,
              ),
            ),
          ),
        );
      },
    );
  }

  void openGetTagLoc({
    required BuildContext context,
    required double width,
    required Function(dynamic)? addressInfo,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            content: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: MapsLocation(
                callBack: (data) {
                  addressInfo!(data);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
