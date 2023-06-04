import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../../shared/loading_indicator.dart';
import '../../../../widgets/base_view.dart';
import '../../../../widgets/header_content.dart';
import '../../../../widgets/warning_alert.dart';
import 'detail_legalitas_viewmodel.dart';
import 'widget/akta_pendirian_section.dart';
import 'widget/akta_perubahan_terakhir_section.dart';

class DetailLegalitasView
    extends ViewModelBuilderWidget<DetailLegalitasViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double height;
  const DetailLegalitasView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.height,
  });

  @override
  DetailLegalitasViewModel viewModelBuilder(BuildContext context) =>
      DetailLegalitasViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      );

  @override
  void onViewModelReady(DetailLegalitasViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DetailLegalitasViewModel viewModel,
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
                title: 'Legalitas Usaha',
                onTap: () => viewModel
                    .navigateTo(ConstantPageRoute.formLegalitasUsahaPage),
              ),
              if (viewModel.isBusy && viewModel.legalitas == null)
                const LoadingIndicator()
              else if (!viewModel.isBusy && viewModel.legalitas == null)
                const CustomEmptyState(
                  height: 200,
                  title: 'Data Tidak Ditemukan',
                  subTitle: 'Coba cek kembali',
                  imageAsset: ImageConstants.emptyList,
                )
              else ...[
                const WarningAlert(
                  title: 'Lengkapi Seluruh Informasi Akta Debitur',
                  subtitle: 'Tambahkan seluruh akta yang dimiliki debitur',
                ),
                const AktaPendirianSection(),
                const AktaPerubahanSection(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
