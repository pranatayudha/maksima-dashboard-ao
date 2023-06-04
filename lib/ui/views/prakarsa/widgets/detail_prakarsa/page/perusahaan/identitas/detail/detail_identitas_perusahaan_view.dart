import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../../shared/loading_indicator.dart';
import '../../../../widgets/base_view.dart';
import '../../../../widgets/header_content.dart';
import '../../../../widgets/warning_alert.dart';
import 'detail_identitas_perusahaan_viewmodel.dart';
import 'widgets/dokumen_perusahaan_section.dart';
import 'widgets/info_perusahaan_section.dart';
import 'widgets/info_pic_section.dart';

class DetailIdentitasPerusahaanView
    extends ViewModelBuilderWidget<DetailIdentitasPerusahaanViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double width;
  final double height;
  const DetailIdentitasPerusahaanView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.width,
    required this.height,
  });

  @override
  DetailIdentitasPerusahaanViewModel viewModelBuilder(BuildContext context) =>
      DetailIdentitasPerusahaanViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        width: width,
      );

  @override
  void onViewModelReady(DetailIdentitasPerusahaanViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DetailIdentitasPerusahaanViewModel viewModel,
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
                title: 'Identitas Perusahaan',
                onTap: () => viewModel
                    .navigateTo(ConstantPageRoute.formIdentitasPerusahaanPage),
              ),
              if (viewModel.isBusy && viewModel.identitasPerusahaan == null)
                const LoadingIndicator()
              else if (!viewModel.isBusy &&
                  viewModel.identitasPerusahaan == null)
                const CustomEmptyState(
                  height: 200,
                  title: 'Data Tidak Ditemukan',
                  subTitle: 'Coba cek kembali',
                  imageAsset: ImageConstants.emptyList,
                )
              else ...[
                const WarningAlert(
                  title: 'Seluruh data info perusahaan wajib dilengkapi',
                  subtitle:
                      'Pastikan seluruh informasi perusahaan sesuai dengan akta perusahaan',
                ),
                const InfoPerusahaanSection(),
                const InfoPICSection(),
                const DokumenPerusahaanSection(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
