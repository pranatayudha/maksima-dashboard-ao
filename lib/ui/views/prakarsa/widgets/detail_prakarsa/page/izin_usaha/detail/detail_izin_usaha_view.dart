import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../shared/custom_button.dart';
import '../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../shared/loading_indicator.dart';
import '../../../widgets/base_view.dart';
import '../../../widgets/header_content.dart';
import '../../../widgets/warning_alert.dart';
import 'detail_izin_usaha_viewmodel.dart';
import 'widget/izin_usaha_card.dart';

class DetailIzinUsahaView
    extends ViewModelBuilderWidget<DetailIzinUsahaViewModel> {
  final String prakarsaId;
  final int codeTable;
  final double height;
  const DetailIzinUsahaView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.height,
  });

  @override
  DetailIzinUsahaViewModel viewModelBuilder(BuildContext context) =>
      DetailIzinUsahaViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
      );

  @override
  void onViewModelReady(DetailIzinUsahaViewModel viewModel) =>
      viewModel.initialize();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DetailIzinUsahaViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      height: height,
      child: viewModel.izinUsaha == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderContent(
                  title: 'Izin Usaha',
                  onTap: (viewModel.izinUsaha == null)
                      ? null
                      : () => viewModel
                          .navigateTo(ConstantPageRoute.formIzinUsahaPage),
                ),
                if (viewModel.isBusy && viewModel.izinUsaha == null)
                  LoadingIndicator(
                    height: height / 2,
                  )
                else if (!viewModel.isBusy && viewModel.izinUsaha == null) ...[
                  CustomEmptyState(
                    height: height / 4,
                    title: 'Belum Ada Dokumen Izin Usaha',
                    subTitle:
                        'Tambah dokumen izin usaha debitur seperti NIB / TDP / SIUP',
                    imageAsset: ImageConstants.emptyList,
                  ),
                  CustomButton(
                    label: 'Tambah Dokumen Izin Usaha',
                    onPressed: () => viewModel
                        .navigateTo(ConstantPageRoute.formIzinUsahaPage),
                    isBusy: false,
                  ),
                ],
              ],
            )
          : ListView(
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderContent(
                      title: 'Izin Usaha',
                      onTap: (viewModel.izinUsaha == null)
                          ? null
                          : () => viewModel
                              .navigateTo(ConstantPageRoute.formIzinUsahaPage),
                    ),
                    const WarningAlert(
                      title: 'Lengkapi Dokumen Izin Usaha Debitur',
                      subtitle:
                          'Lengkapi dokumen perizinan dari debitur seperti NIB / TDP / SIUP',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        viewModel.izinUsaha!.length,
                        (i) => IzinUsahaCard(index: i),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
