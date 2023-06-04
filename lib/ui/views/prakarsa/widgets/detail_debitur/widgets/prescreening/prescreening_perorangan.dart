import 'package:flutter/material.dart';

import '../../../../../../shared/thick_light_grey_divider.dart';
import '../../detail_debitur_viewmodel.dart';
import 'debitur_card.dart';
import 'header_prescreening.dart';

class PrescreeningPerorangan extends StatelessWidget {
  final DetailDebiturViewModel viewModel;
  const PrescreeningPerorangan({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        HeaderPrescreening(
          preScreeningResult:
              viewModel.debiturPerorangan!.preScreening!.result!,
          onTap: () => viewModel.openPrescreeningNote(context: context),
        ),
        const ThickLightGreyDivider(),
        DebiturCard(vm: viewModel),
      ],
    );
  }
}
