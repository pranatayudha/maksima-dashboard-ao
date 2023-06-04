import 'package:flutter/material.dart';

import '../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../shared/detail_prescreening_button.dart';
import '../screening_viewmodel.dart';
import 'prescreening_dialog.dart';

class ScreeningPerusahaanCard extends StatelessWidget {
  final ScreeningViewModel vm;
  const ScreeningPerusahaanCard({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        Text(
          vm.summaryPerusahaan!.name!,
          style: titleStyle16,
        ),
        const SizedBox(height: 8.0),
        DetailPrescreeningButton(
          label: 'LPG',
          description: vm.summaryPerusahaan!.lpg!.status!,
          onPressed: () => PreScreeningDialog().showDialogLpg(
            context,
            title: vm.summaryPerusahaan?.name ?? '',
          ),
          isScreeningAwal: true,
        ),
        DetailPrescreeningButton(
          label: 'SLIK',
          description: vm.summaryPerusahaan!.slik!.status!,
          onPressed: () => PreScreeningDialog().showDialogSlik(
            context: context,
            status: vm.summaryPerusahaan?.slik?.status ?? '',
            reason: vm.summaryPerusahaan?.slik?.reason ?? '',
            onTap: () => vm.downloadFileSlikPerusahaan(
              vm.summaryPerusahaan?.name ?? '',
              context,
            ),
          ),
          isScreeningAwal: true,
        ),
        DetailPrescreeningButton(
          label: 'DHN',
          description: vm.summaryPerusahaan!.dhn!.status!,
          onPressed: () => PreScreeningDialog().showDialogDhn(
            context,
            vm.summaryPerusahaan?.name ?? '',
          ),
          isScreeningAwal: true,
        ),
      ],
    );
  }
}
