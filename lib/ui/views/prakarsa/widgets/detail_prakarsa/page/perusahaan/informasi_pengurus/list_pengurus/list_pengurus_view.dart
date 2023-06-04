import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../../application/models/informasi_pengurus_model.dart';
import '../../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../../shared/loading_indicator.dart';
import '../../../../widgets/base_view.dart';
import '../../../../widgets/header_content.dart';
import '../../../../widgets/warning_alert.dart';
import 'list_pengurus_viewmodel.dart';
import 'widgets/card_pengurus.dart';

class ListPengurusView extends ViewModelBuilderWidget<ListPengurusViewModel> {
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  final double height;
  final Function(InformasiPengurusModel) selectedPengurus;
  const ListPengurusView({
    super.key,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.height,
    required this.selectedPengurus,
  });

  @override
  void onViewModelReady(ListPengurusViewModel viewModel) =>
      viewModel.initialize();

  @override
  ListPengurusViewModel viewModelBuilder(BuildContext context) =>
      ListPengurusViewModel(
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      );

  @override
  Widget builder(
    BuildContext context,
    ListPengurusViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      height: height,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderContent(title: 'Informasi Pengurus / Pemilik'),
              if (viewModel.isBusy && viewModel.ritelInformasiPengurus == null)
                const LoadingIndicator()
              else if (!viewModel.isBusy &&
                  viewModel.ritelInformasiPengurus == null)
                CustomEmptyState(
                  height: height / 4,
                  title: 'Data Tidak Ditemukan',
                  subTitle: 'Coba cek kembali',
                  imageAsset: ImageConstants.emptyList,
                )
              else ...[
                const WarningAlert(
                  title:
                      'Seluruh data pengurus perlu dilengkapi sesuai Dokumen Legalitas',
                  subtitle:
                      'Lengkapi informasi pengurus sesuai Dokumen Legalitas untuk melanjutkan proses prakarsa',
                ),
                ...List.generate(
                  viewModel.ritelInformasiPengurus?.length ?? 0,
                  (index) => CardPengurus(
                    isKeyPerson: index == 0,
                    name:
                        viewModel.ritelInformasiPengurus?[index].fullName ?? '',
                    position: viewModel
                            .ritelInformasiPengurus?[index].jobDescription ??
                        '',
                    status: viewModel.getStatus(
                      viewModel.ritelInformasiPengurus?[index]
                              .stepInformasiPengurus ??
                          0,
                    ),
                    onTap: () {
                      viewModel.ritelInformasiPengurus![index].index =
                          '${index + 1}';
                      selectedPengurus(
                        viewModel.ritelInformasiPengurus![index],
                      );
                      viewModel
                          .navigateTo(ConstantPageRoute.detailPengurusPage);
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
