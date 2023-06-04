import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../detail_info_usaha_viewmodel.dart';

class InfoUsahaSection extends HookViewModelWidget<DetailInfoUsahaViewModel> {
  const InfoUsahaSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailInfoUsahaViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Info Usaha',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DetailPrakarsaItem(
              title: 'Nama Usaha',
              value: viewModel.infoUsahaModel?.businessName ?? '-',
            ),
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Sektor Ekonomi',
                value: viewModel.infoUsahaModel?.economySectorsName ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Sub Sektor Ekonomi',
                value: viewModel.infoUsahaModel?.economySubSectorsName ?? '-',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tag Location Alamat Debitur',
                  style: titleValue,
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: (viewModel.infoUsahaModel?.tagLocation?.latLng ?? '')
                          .isNotEmpty
                      ? () => viewModel.previewLocation(
                            context,
                            'Tag Location Alamat Debitur',
                          )
                      : null,
                  child: Text(
                    'Lihat Lokasi',
                    style: valueStyle.copyWith(
                      decoration: TextDecoration.underline,
                      color:
                          (viewModel.infoUsahaModel?.tagLocation?.latLng ?? '')
                                  .isNotEmpty
                              ? CustomColor.lightBlue
                              : CustomColor.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DetailPrakarsaItem(
              title: 'Detail Alamat Tempat Tinggal',
              value: viewModel.infoUsahaModel?.detail ?? '-',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DetailPrakarsaItem(
              title: 'Kode Pos',
              value: viewModel.infoUsahaModel?.postalCode ?? '-',
            ),
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Provinsi',
                value: viewModel.infoUsahaModel?.province ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Kota',
                value: viewModel.infoUsahaModel?.city ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Kecamatan',
                value: viewModel.infoUsahaModel?.district ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Kelurahan',
                value: viewModel.infoUsahaModel?.village ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'RT',
                value: viewModel.infoUsahaModel?.rt ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'RW',
                value: viewModel.infoUsahaModel?.rw ?? '-',
              ),
            ],
          ),
        ],
      ),
      isLast: true,
    );
  }
}
