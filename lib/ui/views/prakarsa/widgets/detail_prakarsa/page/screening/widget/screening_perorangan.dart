import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../screening_viewmodel.dart';
import 'screening_header.dart';
import 'screening_perorangan_card.dart';

class ScreeningPerorangan extends HookViewModelWidget<ScreeningViewModel> {
  const ScreeningPerorangan({
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
              viewModel.screeningPerorangan!.header!.resultScreening!,
          name: viewModel.summaryDebitur.dukcapil!.reason![1].fieldName!,
          noHp: viewModel.screeningPerorangan!.header!.phoneNum!,
          onTap: () => viewModel.openPrescreeningNote(context: context),
        ),
        ScreeningPeroranganCard(vm: viewModel),
      ],
    );
  }
}
