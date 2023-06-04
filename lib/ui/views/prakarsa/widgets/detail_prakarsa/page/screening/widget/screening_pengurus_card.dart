import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../application/models/summary_screening_debitur.dart';
import '../../../../../../../shared/detail_prescreening_button.dart';
import '../screening_viewmodel.dart';
import 'prescreening_dialog.dart';

class ScreeningPengurusCard extends StatelessWidget {
  final ScreeningViewModel vm;
  final int index;
  const ScreeningPengurusCard({
    Key? key,
    required this.vm,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        Text(
          'Pengurus $index',
          style: titleStyle16,
        ),
        const SizedBox(height: 10.0),
        Responsive(
          children: [
            if (vm.screeningPerusahaan!.summaryScreening[index]['spouseData'] !=
                null) ...[
              Div(
                divison: const Division(
                  colS: 6,
                  colM: 6,
                  colL: 6,
                  colXL: 6,
                ),
                child: PengurusSection(
                  vm: vm,
                  index: index,
                ),
              ),
              Div(
                divison: const Division(
                  colS: 6,
                  colM: 6,
                  colL: 6,
                  colXL: 6,
                ),
                child: SpousePengurusSection(
                  vm: vm,
                  index: index,
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
                child: PengurusSection(
                  vm: vm,
                  index: index,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class PengurusSection extends StatelessWidget {
  final ScreeningViewModel vm;
  final int index;
  const PengurusSection({
    Key? key,
    required this.vm,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screeningPengurus =
        vm.screeningPerusahaan!.summaryScreening[index]['data'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          screeningPengurus['name'],
          style: titleStyle16,
        ),
        const SizedBox(height: 8.0),
        DetailPrescreeningButton(
          label: 'SLIK',
          description: screeningPengurus['slik']['status'],
          onPressed: () => PreScreeningDialog().showDialogSlik(
            context: context,
            status: screeningPengurus['slik']['status'] ?? '',
            reason: screeningPengurus['slik']['reason'] ?? '',
            onTap: () => vm.downloadFileSlikPengurus(
              index,
              context,
              false,
            ),
          ),
          isScreeningAwal: true,
        ),
        DetailPrescreeningButton(
          label: 'Dukcapil',
          description: screeningPengurus['dukcapil']['status'],
          onPressed: () => PreScreeningDialog().showDialogDukcapil(
            context,
            data: List.generate(
              screeningPengurus['dukcapil']['reason'].length ?? 0,
              (i) => Reason.fromJson(
                screeningPengurus['dukcapil']['reason'][i],
              ),
            ),
            urlFile: vm.preScreeningPengurusPath[index - 1],
            onTap: () => vm.openFile(
              context: context,
              url: vm.preScreeningPengurusPath[index - 1],
            ),
          ),
          isScreeningAwal: true,
        ),
        DetailPrescreeningButton(
          label: 'DHN',
          description: screeningPengurus['dhn']['status'],
          onPressed: () => PreScreeningDialog().showDialogDhn(
            context,
            screeningPengurus['dukcapil']['reason'][1]['fieldName'],
          ),
          isScreeningAwal: true,
        ),
      ],
    );
  }
}

class SpousePengurusSection extends StatelessWidget {
  final ScreeningViewModel vm;
  final int index;
  const SpousePengurusSection({
    Key? key,
    required this.vm,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screeningSpousePengurus =
        vm.screeningPerusahaan!.summaryScreening[index]['spouseData'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              screeningSpousePengurus['name'],
              style: titleStyle16,
            ),
            Text(
              ' (Pasangan)',
              style: titleStyle16.copyWith(color: CustomColor.darkGrey),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        DetailPrescreeningButton(
          label: 'Dukcapil',
          description: screeningSpousePengurus['dukcapil']['status'],
          onPressed: () => PreScreeningDialog().showDialogDukcapil(
            context,
            data: List.generate(
              screeningSpousePengurus['dukcapil']['reason'].length ?? 0,
              (i) => Reason.fromJson(
                screeningSpousePengurus['dukcapil']['reason'][i],
              ),
            ),
            urlFile: vm.preScreeningSpousePath[index - 1],
            onTap: () => vm.openFile(
              context: context,
              url: vm.preScreeningSpousePath[index - 1],
            ),
          ),
          isScreeningAwal: true,
        ),
        DetailPrescreeningButton(
          label: 'SLIK',
          description: screeningSpousePengurus['slik']['status'],
          onPressed: () => PreScreeningDialog().showDialogSlik(
            context: context,
            status: screeningSpousePengurus['slik']['status'] ?? '',
            reason: screeningSpousePengurus['slik']['reason'] ?? '',
            onTap: () => vm.downloadFileSlikPengurus(
              index,
              context,
              true,
            ),
          ),
          isScreeningAwal: true,
        ),
        DetailPrescreeningButton(
          label: 'DHN',
          description: screeningSpousePengurus['dhn']['status'],
          onPressed: () => PreScreeningDialog().showDialogDhn(
            context,
            screeningSpousePengurus['dukcapil']['reason'][1]['fieldName'],
          ),
          isScreeningAwal: true,
        ),
      ],
    );
  }
}
