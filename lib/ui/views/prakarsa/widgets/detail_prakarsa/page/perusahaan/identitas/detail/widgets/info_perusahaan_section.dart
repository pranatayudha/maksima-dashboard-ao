import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../detail_identitas_perusahaan_viewmodel.dart';

class InfoPerusahaanSection
    extends HookViewModelWidget<DetailIdentitasPerusahaanViewModel> {
  const InfoPerusahaanSection({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: long-method
  Widget buildViewModelWidget(
    BuildContext context,
    DetailIdentitasPerusahaanViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Info Perusahaan',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              const DetailPrakarsaItem(
                title: 'Jenis Usaha',
                value: 'Pinang Maksima - PTR',
              ),
              DetailPrakarsaItem(
                title: 'Bentuk Usaha',
                value: viewModel.codeTable == 3
                    ? 'Badan Usaha Berbadan Hukum'
                    : viewModel.codeTable == 2
                        ? 'Badan Usaha Tidak Berbadan Hukum'
                        : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: viewModel.codeTable == 3
                    ? 'Badan Usaha Berbadan Hukum'
                    : viewModel.codeTable == 2
                        ? 'Badan Usaha Tidak Berbadan Hukum'
                        : '-',
                value: viewModel.codeTable == 3
                    ? 'PT'
                    : viewModel.codeTable == 2
                        ? 'CV'
                        : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Nama Perusahaan',
                value: viewModel.identitasPerusahaan!.companyName != null
                    ? viewModel.identitasPerusahaan!.companyName!
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'NPWP Perusahaan',
                value: viewModel.identitasPerusahaan!.companyNpwpNum != null
                    ? viewModel.identitasPerusahaan!.companyNpwpNum!
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Sektor Ekonomi',
                value: viewModel.identitasPerusahaan!.economySectorName != null
                    ? viewModel.identitasPerusahaan!.economySectorName!
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Sub Sektor Ekonomi',
                value:
                    viewModel.identitasPerusahaan!.economySubSectorName != null
                        ? viewModel.identitasPerusahaan!.economySubSectorName!
                        : '-',
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
                  'Tag Location Alamat Perusahaan',
                  style: titleValue,
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap:
                      (viewModel.identitasPerusahaan?.tagLocation?.latLng ?? '')
                              .isNotEmpty
                          ? () => viewModel.previewLocation(
                                context,
                                'Tag Location Alamat Perusahaan',
                              )
                          : null,
                  child: Text(
                    'Lihat Lokasi',
                    style: valueStyle.copyWith(
                      decoration: TextDecoration.underline,
                      color:
                          (viewModel.identitasPerusahaan?.tagLocation?.latLng ??
                                      '')
                                  .isNotEmpty
                              ? CustomColor.lightBlue
                              : CustomColor.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Alamat Usaha',
                value: viewModel.identitasPerusahaan!.detail != null
                    ? viewModel.identitasPerusahaan!.detail!
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Kode Pos',
                value: viewModel.identitasPerusahaan!.postalCode != null
                    ? viewModel.identitasPerusahaan!.postalCode!
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Provinsi',
                value: viewModel.identitasPerusahaan!.province != null
                    ? viewModel.identitasPerusahaan!.province!
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Kota',
                value: viewModel.identitasPerusahaan!.city != null
                    ? viewModel.identitasPerusahaan!.city!
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Kecamatan',
                value: viewModel.identitasPerusahaan!.district != null
                    ? viewModel.identitasPerusahaan!.district!
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Kelurahan',
                value: viewModel.identitasPerusahaan!.village != null
                    ? viewModel.identitasPerusahaan!.village!
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'RT',
                value: viewModel.identitasPerusahaan!.rt != null
                    ? viewModel.identitasPerusahaan!.rt != ''
                        ? viewModel.identitasPerusahaan!.rt!
                        : '-'
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'RW',
                value: viewModel.identitasPerusahaan!.rw != null
                    ? viewModel.identitasPerusahaan!.rw != ''
                        ? viewModel.identitasPerusahaan!.rw!
                        : '-'
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Total Nominal Saham Perusahaan',
                value: viewModel.identitasPerusahaan!.totalnominalValueShares !=
                        null
                    ? RupiahFormatter.format(
                        double.parse(
                          viewModel
                              .identitasPerusahaan!.totalnominalValueShares!,
                        ),
                      )
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Total Lembar Saham Perusahaan',
                value: viewModel.identitasPerusahaan!.totalCompanyShares != null
                    ? viewModel.identitasPerusahaan!.totalCompanyShares!
                    : '-',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
