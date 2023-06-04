import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../application/helpers/initial_code_table_formatter.dart';
import '../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../application/models/foto_kunjungan_model.dart';
import '../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../shared/foto_kunjungan_item.dart';
import '../../../../../../../shared/loading_indicator.dart';
import '../../../../../../../shared/not_exist_photo.dart';
import '../../../../../../../shared/row_item_detail.dart';
import '../../../widgets/base_view.dart';
import '../../../widgets/header_content.dart';
import '../../../widgets/warning_alert.dart';
import '../widgets/open_preview_lkn.dart';
import 'detail_lkn_viewmodel.dart';

class DetailLKNView extends ViewModelBuilderWidget<DetailLKNViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double width;
  final double height;
  const DetailLKNView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.width,
    required this.height,
  });

  @override
  DetailLKNViewModel viewModelBuilder(BuildContext context) =>
      DetailLKNViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      );

  @override
  void onViewModelReady(DetailLKNViewModel viewModel) => viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  // ignore: long-method
  Widget builder(
    BuildContext context,
    DetailLKNViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      height: height,
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderContent(
                title: 'Laporan Kunjungan Nasabah',
                onTap: () =>
                    viewModel.navigateTo(ConstantPageRoute.formLKNPage),
              ),
              if (viewModel.isBusy && viewModel.detailLKN == null)
                const LoadingIndicator()
              else if (!viewModel.isBusy && viewModel.detailLKN == null)
                const CustomEmptyState(
                  height: 200,
                  title: 'Data Tidak Ditemukan',
                  subTitle: 'Coba cek kembali',
                  imageAsset: ImageConstants.emptyList,
                )
              else ...[
                const WarningAlert(
                  title: 'Seluruh data LKN wajib dilengkapi',
                  subtitle:
                      'Pastikan data sesuai dengan hasil kunjungan kelokasi debitur',
                ),
                RowItemDetail(
                  listWidget: [
                    DetailPrakarsaItem(
                      title: 'CB Terdekat',
                      value: viewModel.detailLKN!.dataLkn!.cbName != null
                          ? viewModel.detailLKN!.dataLkn!.cbName! != ''
                              ? viewModel.detailLKN!.dataLkn!.cbName!
                              : '-'
                          : '-',
                    ),
                    DetailPrakarsaItem(
                      title: 'Waktu tempuh lokasi',
                      value: viewModel.detailLKN!.dataLkn!.etaToCB != null
                          ? viewModel.detailLKN!.dataLkn!.etaToCB! != ''
                              ? '${viewModel.detailLKN!.dataLkn!.etaToCB!} Menit'
                              : '-'
                          : '-',
                    ),
                  ],
                ),
                RowItemDetail(
                  listWidget: [
                    DetailPrakarsaItem(
                      title: 'Jenis Produk Pinjaman',
                      value: InitialCodeTableFormatter.getJenisKredit(
                        int.parse(viewModel.detailLKN!.dataLkn!.loanTypeId!),
                      ),
                    ),
                    DetailPrakarsaItem(
                      title: 'Pengajuan Plafond Pinjaman',
                      value: viewModel.detailLKN!.dataLkn!.loanAmount != null
                          ? viewModel.detailLKN!.dataLkn!.loanAmount! != ''
                              ? RupiahFormatter.format(
                                  double.parse(
                                    viewModel.detailLKN!.dataLkn!.loanAmount!,
                                  ),
                                )
                              : '-'
                          : '-',
                    ),
                  ],
                ),
                RowItemDetail(
                  listWidget: [
                    DetailPrakarsaItem(
                      title: 'Tujuan Kunjungan Nasabah',
                      value: viewModel.detailLKN!.dataLkn!.purposeVisit != null
                          ? viewModel.detailLKN!.dataLkn!.purposeVisit! != ''
                              ? viewModel.detailLKN!.dataLkn!.purposeVisit!
                              : '-'
                          : '-',
                    ),
                    DetailPrakarsaItem(
                      title: 'Tanggal Kunjungan Nasabah',
                      value: viewModel.detailLKN!.dataLkn!.dateOfVisit != null
                          ? viewModel.detailLKN!.dataLkn!.dateOfVisit! != ''
                              ? DateStringFormatter.forOutputRitel(
                                  viewModel.detailLKN!.dataLkn!.dateOfVisit!,
                                )
                              : '-'
                          : '-',
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Pejabat Yang Mendampingi',
                  style: titleStyle16,
                ),
                const SizedBox(
                  height: 12,
                ),
                RowItemDetail(
                  listWidget: [
                    DetailPrakarsaItem(
                      title: 'Nama Pejabat',
                      value: viewModel.detailLKN!.dataLkn!.nameOfficer != null
                          ? viewModel.detailLKN!.dataLkn!.nameOfficer! != ''
                              ? viewModel.detailLKN!.dataLkn!.nameOfficer!
                              : '-'
                          : '-',
                    ),
                    DetailPrakarsaItem(
                      title: 'Jabatan',
                      value: viewModel.detailLKN!.dataLkn!.position != null
                          ? viewModel.detailLKN!.dataLkn!.position! != ''
                              ? viewModel.detailLKN!.dataLkn!.position!
                              : '-'
                          : '-',
                    ),
                  ],
                ),
                if (viewModel.detailLKN!.dataLkn!.position == 'Kadiv Bisnis' ||
                    viewModel.detailLKN!.dataLkn!.position ==
                        'Wakadiv Bisnis' ||
                    viewModel.detailLKN!.dataLkn!.position == 'Kabag Bisnis' ||
                    viewModel.detailLKN!.dataLkn!.position == 'RM Pusat')
                  DetailPrakarsaItem(
                    title: 'Nama Divisi',
                    value: viewModel.detailLKN!.dataLkn!.divisionOfficer != null
                        ? viewModel.detailLKN!.dataLkn!.divisionOfficer! != ''
                            ? viewModel.detailLKN!.dataLkn!.divisionOfficer!
                            : '-'
                        : '-',
                  ),
                RowItemDetail(
                  listWidget: [
                    DetailPrakarsaItem(
                      title: 'Nama Pejabat Lainnya',
                      value: viewModel.detailLKN!.dataLkn!.nameOfficerOther !=
                              null
                          ? viewModel.detailLKN!.dataLkn!.nameOfficerOther! !=
                                  ''
                              ? viewModel.detailLKN!.dataLkn!.nameOfficerOther!
                              : '-'
                          : '-',
                    ),
                    DetailPrakarsaItem(
                      title: 'Jabatan',
                      value: viewModel.detailLKN!.dataLkn!.positionOther != null
                          ? viewModel.detailLKN!.dataLkn!.positionOther! != ''
                              ? viewModel.detailLKN!.dataLkn!.positionOther!
                              : '-'
                          : '-',
                    ),
                  ],
                ),
                if (viewModel.detailLKN!.dataLkn!.positionOther == 'Kadiv Bisnis' ||
                    viewModel.detailLKN!.dataLkn!.positionOther ==
                        'Wakadiv Bisnis' ||
                    viewModel.detailLKN!.dataLkn!.positionOther ==
                        'Kabag Bisnis' ||
                    viewModel.detailLKN!.dataLkn!.positionOther == 'RM Pusat')
                  DetailPrakarsaItem(
                    title: 'Nama Divisi',
                    value: viewModel.detailLKN!.dataLkn!.divisionOfficerOther !=
                            null
                        ? viewModel.detailLKN!.dataLkn!.divisionOfficerOther! !=
                                ''
                            ? viewModel
                                .detailLKN!.dataLkn!.divisionOfficerOther!
                            : '-'
                        : '-',
                  ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Foto Kunjungan',
                  style: titleStyle16,
                ),
                const SizedBox(
                  height: 16,
                ),
                viewModel.detailLKN?.dataLkn?.visitPath?.isEmpty ?? true
                    ? const NotExistPhoto(desc: 'Belum ada foto kunjungan')
                    : Column(
                        children: List.generate(
                          viewModel.fotoKunjunganPublicURL.length,
                          (i) => FotoKunjunganItem(
                            onTap: (data) => OpenPreviewLKN().openPreviewLKN(
                              context: context,
                              width: width,
                              data: data,
                            ),
                            data: FotoKunjunganModel(
                              imageUrl: viewModel.fotoKunjunganPublicURL[i],
                              width: width,
                              title: 'Lokasi Foto Kunjungan',
                              tagLocation: {
                                'name': viewModel.detailLKN?.dataLkn
                                    ?.visitPath![i].meta?.locationDetail?.name,
                                'latLng': viewModel
                                    .detailLKN
                                    ?.dataLkn
                                    ?.visitPath?[i]
                                    .meta
                                    ?.locationDetail
                                    ?.latLng,
                              },
                              date: viewModel.detailLKN?.dataLkn?.visitPath?[i]
                                  .meta?.photoName,
                              address: viewModel.detailLKN?.dataLkn
                                  ?.visitPath?[i].meta?.locationDetail?.name,
                              time: viewModel.detailLKN?.dataLkn?.visitPath?[i]
                                  .meta?.timeName,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                DetailPrakarsaItem(
                  title: 'Hasil Kunjungan Nasabah',
                  value: viewModel.detailLKN?.dataLkn!.visitResult != null
                      ? viewModel.detailLKN!.dataLkn!.visitResult != ''
                          ? viewModel.detailLKN!.dataLkn!.visitResult!
                          : '-'
                      : '-',
                ),
                const SizedBox(
                  height: 24,
                ),
                DetailPrakarsaItem(
                  title: 'Rencana Tindak Lanjut',
                  value: viewModel.detailLKN!.dataLkn!.followUpPlan != null
                      ? viewModel.detailLKN!.dataLkn!.followUpPlan != ''
                          ? viewModel.detailLKN!.dataLkn!.followUpPlan!
                          : '-'
                      : '-',
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
