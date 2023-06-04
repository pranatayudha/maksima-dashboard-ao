import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../shared/detail_prescreening_button.dart';
import '../screening_viewmodel.dart';
import 'prescreening_dialog.dart';

class ScreeningPeroranganCard extends StatelessWidget {
  final ScreeningViewModel vm;
  const ScreeningPeroranganCard({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Responsive(
          children: [
            if (vm.screeningPerorangan!.summaryScreening![1] != null) ...[
              Div(
                divison: const Division(
                  colS: 6,
                  colM: 6,
                  colL: 6,
                  colXL: 6,
                ),
                child: DebiturSection(
                  vm: vm,
                ),
              ),
              Div(
                divison: const Division(
                  colS: 6,
                  colM: 6,
                  colL: 6,
                  colXL: 6,
                ),
                child: SpouseSection(
                  vm: vm,
                ),
              ),
            ] else
              Div(
                divison: const Division(
                  colS: 12,
                  colM: 12,
                  colL: 12,
                  colXL: 12,
                ),
                child: DebiturSection(
                  vm: vm,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class DebiturSection extends StatelessWidget {
  final ScreeningViewModel vm;
  const DebiturSection({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vm.summaryDebitur.dukcapil!.reason![1].fieldName!,
          style: titleStyle16,
        ),
        const SizedBox(height: 8.0),
        DetailPrescreeningButton(
          label: 'LPG',
          description: vm.summaryDebitur.lpg!.status!,
          onPressed: () => PreScreeningDialog().showDialogLpg(
            context,
            title: vm.summaryDebitur.dukcapil!.reason![1].fieldName ?? '',
          ),
        ),
        DetailPrescreeningButton(
          label: 'SLIK',
          description: vm.summaryDebitur.slik!.status!,
          onPressed: () => PreScreeningDialog().showDialogSlik(
            context: context,
            onTap: () => vm.downloadFileSlikPerorangan(
              0,
              vm.summaryDebitur.dukcapil?.reason![1].fieldName ?? '',
              context,
            ),
            status: vm.summaryDebitur.slik?.status ?? '-',
            reason: vm.summaryDebitur.slik?.reason ?? '-',
          ),
        ),
        DetailPrescreeningButton(
          label: 'Dukcapil',
          description: vm.summaryDebitur.dukcapil!.status!,
          onPressed: () => PreScreeningDialog().showDialogDukcapil(
            context,
            data: vm.summaryDebitur.dukcapil?.reason,
            onTap: () =>
                vm.openFile(context: context, url: vm.preScreeningPath[0]),
            urlFile: vm.preScreeningPath[0],
          ),
        ),
        DetailPrescreeningButton(
          label: 'DHN',
          description: vm.summaryDebitur.dhn!.status!,
          onPressed: () => PreScreeningDialog().showDialogDhn(
            context,
            vm.summaryDebitur.dukcapil?.reason?[1].fieldName ?? '-',
          ),
        ),
      ],
    );
  }
}

class SpouseSection extends StatelessWidget {
  final ScreeningViewModel vm;
  const SpouseSection({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vm.summarySpouse!.dukcapil!.reason![1].fieldName!,
          style: titleStyle16,
        ),
        const SizedBox(height: 8.0),
        DetailPrescreeningButton(
          label: 'Dukcapil',
          description: vm.summarySpouse!.dukcapil!.status!,
          onPressed: () => PreScreeningDialog().showDialogDukcapil(
            context,
            data: vm.summarySpouse?.dukcapil?.reason,
            onTap: () =>
                vm.openFile(context: context, url: vm.preScreeningPath[1]),
            urlFile: vm.preScreeningPath[1],
          ),
        ),
        DetailPrescreeningButton(
          label: 'SLIK',
          description: vm.summarySpouse!.slik!.status!,
          onPressed: () => PreScreeningDialog().showDialogSlik(
            context: context,
            onTap: () => vm.downloadFileSlikPerorangan(
              1,
              vm.summarySpouse?.dukcapil?.reason![1].fieldName ?? '',
              context,
            ),
            status: vm.summarySpouse?.slik?.status ?? '-',
            reason: vm.summarySpouse?.slik?.reason ?? '-',
          ),
        ),
        DetailPrescreeningButton(
          label: 'DHN',
          description: vm.summarySpouse!.dhn!.status!,
          onPressed: () => PreScreeningDialog().showDialogDhn(
            context,
            vm.summarySpouse?.dukcapil?.reason?[1].fieldName ?? '-',
          ),
        ),
      ],
    );
  }
}
