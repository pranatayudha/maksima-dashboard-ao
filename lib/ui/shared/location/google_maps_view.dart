import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../application/app/constants/custom_color.dart';
import '../../../application/app/constants/icon_constants.dart';
import '../../../application/app/constants/text_style_constants.dart';
import 'get_location_viewmodel.dart';

class GoogleMapsView extends StatefulWidget {
  final String title;
  final String nameTag;
  final LatLng location;
  const GoogleMapsView({
    Key? key,
    required this.title,
    required this.nameTag,
    required this.location,
  }) : super(key: key);

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late GoogleMapController mapController;
  Map<String, Marker> markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GetLocationViewModel>.reactive(
      viewModelBuilder: () => GetLocationViewModel(),
      onModelReady: (model) => model.setMarkPoint('id', widget.location),
      builder: (context, viewModel, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.title,
                        style: titleStyle20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(IconConstants.x, height: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: widget.location,
                  zoom: 18,
                ),
                onMapCreated: (controller) {
                  mapController = controller;
                  addMarker(widget.nameTag, widget.location);
                },
                markers: markers.values.toSet(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColor.lightGrey,
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.searchResult?.addressComponents[1].shortName ??
                        '',
                    style: titleStyle16,
                  ),
                  Text(
                    viewModel.searchResult?.formattedAddress ?? '',
                    style: titleValue.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: widget.nameTag,
      ),
    );

    setState(() => markers[id] = marker);
  }
}
