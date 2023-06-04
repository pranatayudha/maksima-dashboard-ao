import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../application/models/foto_kunjungan_model.dart';
import '../../../../../../../shared/custom_button.dart';
import '../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../shared/location/open_maps.dart';
import '../../../../../../../shared/row_item_detail.dart';

class PreviewFotoLKN extends StatelessWidget {
  final FotoKunjunganModel data;
  final double width;
  final String titleMain;
  final String titleSecondary;
  const PreviewFotoLKN({
    Key? key,
    required this.data,
    this.width = 200,
    required this.titleMain,
    required this.titleSecondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> latLng = {};

    latLng['lat'] = double.parse(
      data.tagLocation?['latLng'].split(',')[0] ?? '0',
    );

    latLng['lng'] = double.parse(
      data.tagLocation?['latLng'].split(',')[1] ?? '0',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    titleMain,
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
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Image.network(data.imageUrl ?? ''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Tanggal',
                value: data.date ?? '',
              ),
              if (data.time != null)
                DetailPrakarsaItem(
                  title: 'Waktu',
                  value: data.time ?? '',
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 12.0, 0.0, 12.0),
          child: DetailPrakarsaItem(
            title: 'Lokasi',
            value: data.tagLocation?['name'],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: CustomButton(
            label: 'Lihat Lokasi',
            onPressed: () {
              OpenMaps().openPreview(
                context: context,
                width: data.width ?? width,
                title: titleSecondary,
                nameTag: data.tagLocation?['name'],
                location: LatLng(
                  latLng['lat'],
                  latLng['lng'],
                ),
              );
            },
            isBusy: false,
            color: CustomColor.lightBlue,
          ),
        ),
      ],
    );
  }
}
