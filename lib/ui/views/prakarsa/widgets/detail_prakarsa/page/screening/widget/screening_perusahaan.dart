import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../screening_viewmodel.dart';
import 'screening_header.dart';
import 'screening_pengurus_card.dart';
import 'screening_perusahaan_card.dart';

class ScreeningPerusahaan extends HookViewModelWidget<ScreeningViewModel> {
  const ScreeningPerusahaan({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    ScreeningViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScreeningHeader(
          codeTable: viewModel.codeTable,
          preScreeningResult:
              viewModel.screeningPerusahaan!.header!.resultScreening!,
          name: viewModel.screeningPerusahaan!.header!.titlePipeline!,
          npwp: viewModel.screeningPerusahaan!.header!.npwpNumb!,
          onTap: () => viewModel.openPrescreeningNote(context: context),
        ),
        ScreeningPerusahaanCard(vm: viewModel),
        for (var i = 1;
            i < viewModel.screeningPerusahaan!.summaryScreening.length;
            i++)
          Column(
            children: [
              ScreeningPengurusCard(
                vm: viewModel,
                index: i,
              ),
            ],
          ),
      ],
    );
  }
}
