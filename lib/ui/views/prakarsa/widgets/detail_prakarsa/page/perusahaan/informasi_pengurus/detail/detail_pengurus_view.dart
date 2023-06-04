import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../application/models/informasi_pengurus_model.dart';
import '../../../../../../../../shared/loading_indicator.dart';
import '../../../../widgets/warning_alert.dart';
import 'detail_pengurus_viewmodel.dart';
import 'widgets/dokumen_pengurus.dart';
import 'widgets/pengurus_cv_body.dart';
import 'widgets/pengurus_pt_body.dart';

class DetailInformasiPengurusView
    extends ViewModelBuilderWidget<DetailInformasiPengurusViewModel> {
  final InformasiPengurusModel informasiPengurus;
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  const DetailInformasiPengurusView({
    super.key,
    required this.informasiPengurus,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
  });

  @override
  void onViewModelReady(DetailInformasiPengurusViewModel viewModel) =>
      viewModel.initialize();

  @override
  DetailInformasiPengurusViewModel viewModelBuilder(BuildContext context) =>
      DetailInformasiPengurusViewModel(
        dataPengurus: informasiPengurus,
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        pipelineId: pipelineId,
      );

  @override
  Widget builder(
    BuildContext context,
    DetailInformasiPengurusViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(32.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: viewModel.isBusy
          ? const LoadingIndicator()
          : Responsive(
              children: [
                Div(
                  divison: const Division(
                    colS: 12,
                    colM: 12,
                    colL: 12,
                    colXL: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Pengurus ${informasiPengurus.index}',
                                style: titleStyle20,
                              ),
                              if ((informasiPengurus.index ?? '') == '1')
                                Text(
                                  ' (Key Person)',
                                  style: titleStyle16.copyWith(
                                    color: CustomColor.lightBlue,
                                  ),
                                ),
                            ],
                          ),
                          InkWell(
                            mouseCursor: MaterialStateMouseCursor.clickable,
                            onTap: () => viewModel.navigateTo(
                              ConstantPageRoute.formInformasiPengurusPage,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                border:
                                    Border.all(color: CustomColor.primaryBlue),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    IconConstants.iconEditBlue,
                                    height: 20,
                                  ),
                                  Text(
                                    'Ubah Data',
                                    style: titleStyle16.copyWith(
                                      color: CustomColor.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const WarningAlert(
                        title: 'Seluruh data info pengurus wajib dilengkapi',
                        subtitle:
                            'Pastikan data yang diterima dari debitur lengkap',
                      ),
                      if (codeTable == 2)
                        PengurusCVBody(data: viewModel.infoPengurus!)
                      else
                        PengurusPTBody(
                          data: viewModel.infoPengurus!,
                        ),
                      const DokumenPengurus(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
