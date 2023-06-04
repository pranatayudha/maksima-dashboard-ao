import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../../shared/loading_indicator.dart';
import '../../../../widgets/base_view.dart';
import '../../../../widgets/header_content.dart';
import '../../../../widgets/warning_alert.dart';
import 'detail_info_usaha_viewmodel.dart';
import 'widgets/Info_usaha_section.dart';

class DetailInfoUsahaView
    extends ViewModelBuilderWidget<DetailInfoUsahaViewModel> {
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  final double width;
  final double height;

  const DetailInfoUsahaView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.width,
    required this.height,
  });

  @override
  DetailInfoUsahaViewModel viewModelBuilder(BuildContext context) =>
      DetailInfoUsahaViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
        width: width,
      );

  @override
  void onViewModelReady(DetailInfoUsahaViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DetailInfoUsahaViewModel viewModel,
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
                title: 'Info Usaha',
                onTap: viewModel.infoUsahaModel == null
                    ? null
                    : () => viewModel
                        .navigateTo(ConstantPageRoute.formInfoUsahaPage),
              ),
              if (viewModel.isBusy && viewModel.infoUsahaModel == null)
                const LoadingIndicator()
              else if (!viewModel.isBusy && viewModel.infoUsahaModel == null)
                const CustomEmptyState(
                  height: 200,
                  title: 'Data Tidak Ditemukan',
                  subTitle: 'Coba cek kembali',
                  imageAsset: ImageConstants.emptyList,
                )
              else ...[
                const WarningAlert(
                  title: 'Lengkapi seluruh info usaha debitur',
                  subtitle: 'Pastikan data yang diterima dari debitur lengkap',
                ),
                const InfoUsahaSection(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
