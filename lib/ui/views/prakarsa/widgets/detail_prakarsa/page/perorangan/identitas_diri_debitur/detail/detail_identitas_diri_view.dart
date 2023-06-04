import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../../shared/loading_indicator.dart';
import '../../../../widgets/base_view.dart';
import '../../../../widgets/header_content.dart';
import '../../../../widgets/warning_alert.dart';
import 'detail_identitas_diri_viewmodel.dart';
import 'widgets/dokumen_debitur.dart';
import 'widgets/identitas_diri_debitur_section.dart';

class DetailIdentitasDiriView
    extends ViewModelBuilderWidget<DetailIdentitasDiriViewModel> {
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  final double width;
  final double height;

  const DetailIdentitasDiriView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.width,
    required this.height,
  });

  @override
  DetailIdentitasDiriViewModel viewModelBuilder(BuildContext context) =>
      DetailIdentitasDiriViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
        width: width,
      );

  @override
  void onViewModelReady(DetailIdentitasDiriViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DetailIdentitasDiriViewModel viewModel,
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
                title: 'Identitas Diri Debitur',
                onTap: viewModel.detailIdentitasPerorangan == null
                    ? null
                    : () => viewModel
                        .navigateTo(ConstantPageRoute.formIdentitasDebiturPage),
              ),
              if (viewModel.isBusy &&
                  viewModel.detailIdentitasPerorangan == null)
                const LoadingIndicator()
              else if (!viewModel.isBusy &&
                  viewModel.detailIdentitasPerorangan == null)
                const CustomEmptyState(
                  height: 200,
                  title: 'Data Tidak Ditemukan',
                  subTitle: 'Coba cek kembali',
                  imageAsset: ImageConstants.emptyList,
                )
              else ...[
                const WarningAlert(
                  title: 'Seluruh data info debitur wajib dilengkapi',
                  subtitle: 'Pastikan data yang diterima dari debitur lengkap',
                ),
                const IdentitasDiriDebiturSection(),
                const DokumenDebitur(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
