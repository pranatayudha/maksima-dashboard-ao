import 'package:flutter/material.dart';

import '../../../../../../shared/thick_light_grey_divider.dart';
import '../../detail_debitur_viewmodel.dart';
import 'header_prescreening.dart';
import 'pengurus_card.dart';
import 'perusahaan_card.dart';

class PrescreeningPerusahaan extends StatelessWidget {
  final DetailDebiturViewModel viewModel;
  const PrescreeningPerusahaan({
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
              viewModel.debiturPerusahaan!.preScreening!.result!,
          onTap: () => viewModel.openPrescreeningNote(context: context),
        ),
        const ThickLightGreyDivider(),
        PerusahaanCard(vm: viewModel),
        for (var i = 1;
            i < viewModel.debiturPerusahaan!.preScreening!.summary.length;
            i++)
          Column(
            children: [
              PengurusCard(
                vm: viewModel,
                index: i,
              ),
            ],
          ),
      ],
    );
  }
}
