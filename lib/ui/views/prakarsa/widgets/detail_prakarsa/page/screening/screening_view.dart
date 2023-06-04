import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../shared/custom_empty_state.dart';
import '../../../../../../shared/loading_indicator.dart';
import '../../widgets/base_view.dart';
import '../../widgets/header_content.dart';
import 'screening_viewmodel.dart';
import 'widget/screening_perorangan.dart';
import 'widget/screening_perusahaan.dart';

class ScreeningView extends ViewModelBuilderWidget<ScreeningViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double height;
  const ScreeningView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.height,
  });

  @override
  ScreeningViewModel viewModelBuilder(BuildContext context) =>
      ScreeningViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      );

  @override
  void onViewModelReady(ScreeningViewModel viewModel) => viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    ScreeningViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      height: height,
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HeaderContent(
                title: 'Hasil Screening Awal',
                onTap: null,
              ),
              if (codeTable == 1 || codeTable == 4) ...[
                if (viewModel.isBusy && viewModel.screeningPerorangan == null)
                  const LoadingIndicator()
                else if (!viewModel.isBusy &&
                    viewModel.screeningPerorangan == null)
                  const CustomEmptyState(
                    height: 200,
                    title: 'Data Tidak Ditemukan',
                    subTitle: 'Coba cek kembali',
                    imageAsset: ImageConstants.emptyList,
                  )
                else
                  const ScreeningPerorangan(),
              ] else ...[
                if (viewModel.isBusy && viewModel.screeningPerusahaan == null)
                  const LoadingIndicator()
                else if (!viewModel.isBusy &&
                    viewModel.screeningPerusahaan == null)
                  const CustomEmptyState(
                    height: 200,
                    title: 'Data Tidak Ditemukan',
                    subTitle: 'Coba cek kembali',
                    imageAsset: ImageConstants.emptyList,
                  )
                else
                  const ScreeningPerusahaan(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
