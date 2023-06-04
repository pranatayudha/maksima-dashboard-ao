import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../shared/custom_button.dart';
import '../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../shared/loading_indicator.dart';
import '../../../widgets/base_view.dart';
import '../../../widgets/header_content.dart';
import '../../../widgets/warning_alert.dart';
import 'detail_dokumen_lainnya_viewmodel.dart';
import 'widget/dokumen_lainnya_card.dart';

class DetailDokumenLainnyaView
    extends ViewModelBuilderWidget<DetailDokumenLainnyaViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double height;
  final bool stepperStatus;
  final Function(bool) refreshStepper;
  const DetailDokumenLainnyaView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.height,
    required this.stepperStatus,
    required this.refreshStepper,
  });

  @override
  DetailDokumenLainnyaViewModel viewModelBuilder(BuildContext context) =>
      DetailDokumenLainnyaViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        stepperStatus: stepperStatus,
      );

  @override
  void onViewModelReady(DetailDokumenLainnyaViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DetailDokumenLainnyaViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      height: height,
      child: viewModel.dokumenLainnya == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderContent(
                  title: 'Dokumen Usaha Lainnya',
                  onTap: (viewModel.dokumenLainnya == null)
                      ? null
                      : () => viewModel.navigateTo(
                            ConstantPageRoute.formDokumenUsahaLainnyaPage,
                          ),
                ),
                if (viewModel.isBusy && viewModel.dokumenLainnya == null)
                  LoadingIndicator(
                    height: height / 2,
                  )
                else if (!viewModel.isBusy &&
                    viewModel.dokumenLainnya == null) ...[
                  CustomEmptyState(
                    height: height / 3,
                    title: 'Belum Ada Dokumen',
                    subTitle:
                        'Tambah dokumen usaha lainnya dari debitur seperti SKDP, AMDAL, HO, SIUJK',
                    imageAsset: ImageConstants.emptyList,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        label: 'Tambah Dokumen',
                        onPressed: () => viewModel.navigateTo(
                          ConstantPageRoute.formDokumenUsahaLainnyaPage,
                        ),
                        isBusy: false,
                      ),
                      const SizedBox(height: 10.0),
                      if (!viewModel.stepStatus)
                        CustomButton(
                          label: 'Simpan',
                          onPressed: () => viewModel
                              .validateInputs()
                              .then((value) => refreshStepper(true)),
                          isBusy: false,
                          isOutlineButton: true,
                        ),
                    ],
                  ),
                ],
              ],
            )
          : ListView(
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderContent(
                      title: 'Dokumen Usaha Lainnya',
                      onTap: (viewModel.dokumenLainnya == null)
                          ? null
                          : () => viewModel.navigateTo(
                                ConstantPageRoute.formDokumenUsahaLainnyaPage,
                              ),
                    ),
                    const WarningAlert(
                      title: 'Lengkapi Dokumen Pendukung Kredit Lainnya',
                      subtitle:
                          'Lengkapi dokumen usaha lainnya seperti SKDP, AMDAL, HO, SIUJK dan sebagainya',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        viewModel.dokumenLainnyaMap.length,
                        (i) => DokumenLainnyaCard(index: i),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
