import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../application/app/constants/custom_color.dart';
import '../../../application/app/constants/icon_constants.dart';
import '../../../application/app/constants/text_style_constants.dart';
import '../custom_button.dart';
import '../custom_textfield.dart';
import '../loading_indicator.dart';
import 'get_location_viewmodel.dart';

class MapsLocation extends ViewModelBuilderWidget<GetLocationViewModel> {
  final Function(Map<String, dynamic>) callBack;
  const MapsLocation({
    Key? key,
    required this.callBack,
  }) : super(key: key);

  @override
  GetLocationViewModel viewModelBuilder(BuildContext context) =>
      GetLocationViewModel();

  @override
  void onViewModelReady(GetLocationViewModel viewModel) =>
      viewModel.initialize();

  @override
  // ignore: long-method
  Widget builder(
    BuildContext context,
    GetLocationViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.initialPositon == null
        ? const LoadingIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Tag Lokasi',
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
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: GoogleMap(
                        zoomControlsEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: viewModel.initialPositon!,
                          zoom: 18,
                        ),
                        onMapCreated: (GoogleMapController ctrl) {
                          viewModel.updateMapController(
                            ctrl,
                            viewModel.initialPositon!,
                          );
                        },
                        onTap: (argument) async => viewModel.data.isEmpty
                            ? viewModel.setMarkPoint('_pin', argument)
                            : null,
                        markers: viewModel.markers.values.toSet(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            textEditingController: viewModel.tagLocController,
                            hintText: 'Cari lokasi / nama jalan / gedung',
                            withPrefixIcon: true,
                            prefixIconImagePath: IconConstants.searchBlack,
                            enabled: true,
                            maxLength: 1,
                            fillColor: Colors.white,
                            onChanged: (val) async {
                              viewModel.searchAddress(val);
                            },
                          ),
                          if (viewModel.data.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  viewModel.data.length,
                                  (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async =>
                                            viewModel.selectedLocation(
                                          viewModel.data[index],
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            viewModel.data[index].reference ??
                                                '',
                                          ),
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (viewModel.searchResult != null)
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
                        viewModel
                                .searchResult?.addressComponents[1].shortName ??
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
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CustomButton(
                  label: 'Pilih',
                  onPressed: () {
                    Navigator.of(context).pop();
                    callBack(
                      viewModel.callBackLoc(),
                    );
                  },
                  isBusy: false,
                  color: CustomColor.primaryBlue,
                ),
              ),
            ],
          );
  }
}
