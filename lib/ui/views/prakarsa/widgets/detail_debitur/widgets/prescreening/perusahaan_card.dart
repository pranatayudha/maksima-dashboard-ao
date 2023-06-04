import 'package:flutter/material.dart';

import '../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../shared/detail_prescreening_button.dart';
import '../../../detail_prakarsa/page/screening/widget/prescreening_dialog.dart';
import '../../detail_debitur_viewmodel.dart';

class PerusahaanCard extends StatelessWidget {
  final DetailDebiturViewModel vm;
  const PerusahaanCard({
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
          vm.screeningPerusahaan!.name!,
          style: titleStyle16,
        ),
        const SizedBox(height: 8.0),
        DetailPrescreeningButton(
          label: 'LPG',
          description: vm.screeningPerusahaan!.lpg!.status!,
          onPressed: () => PreScreeningDialog().showDialogLpg(
            context,
            title: vm.screeningPerusahaan?.name ?? '',
          ),
          isScreeningAwal: true,
        ),
        DetailPrescreeningButton(
          label: 'SLIK',
          description: vm.screeningPerusahaan!.slik!.status!,
          onPressed: () => PreScreeningDialog().showDialogSlik(
            context: context,
            status: vm.screeningPerusahaan?.slik?.status ?? '',
            reason: vm.screeningPerusahaan?.slik?.reason ?? '',
            onTap: () => vm.downloadFileSlikPerusahaan(
              vm.screeningPerusahaan?.name ?? '',
              context,
            ),
          ),
          isScreeningAwal: true,
        ),
        DetailPrescreeningButton(
          label: 'DHN',
          description: vm.screeningPerusahaan!.dhn!.status!,
          onPressed: () => PreScreeningDialog().showDialogDhn(
            context,
            vm.screeningPerusahaan?.name ?? '',
          ),
          isScreeningAwal: true,
        ),
      ],
    );
  }
}
