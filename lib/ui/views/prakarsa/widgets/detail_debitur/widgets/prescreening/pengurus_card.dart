import 'package:flutter/material.dart';

import '../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../application/models/summary_screening_debitur.dart';
import '../../../../../../shared/detail_prescreening_button.dart';
import '../../../detail_prakarsa/page/screening/widget/prescreening_dialog.dart';
import '../../detail_debitur_viewmodel.dart';

class PengurusCard extends StatelessWidget {
  final DetailDebiturViewModel vm;
  final int index;
  const PengurusCard({
    Key? key,
    required this.vm,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PengurusSection(
          vm: vm,
          index: index,
        ),
        SpousePengurusSection(
          vm: vm,
          index: index,
        ),
      ],
    );
  }
}

class PengurusSection extends StatelessWidget {
  final DetailDebiturViewModel vm;
  final int index;
  const PengurusSection({
    Key? key,
    required this.vm,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screeningPengurus =
        vm.debiturPerusahaan!.preScreening!.summary[index]['data'];

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
              context,
              screeningPengurus,
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
  final DetailDebiturViewModel vm;
  final int index;
  const SpousePengurusSection({
    Key? key,
    required this.vm,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vm.debiturPerusahaan!.preScreening!.summary[index]['spouseData'] !=
        null) {
      final screeningSpousePengurus =
          vm.debiturPerusahaan!.preScreening!.summary[index]['spouseData'];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Text(
            screeningSpousePengurus['name'],
            style: titleStyle16,
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
                context,
                screeningSpousePengurus,
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
    } else {
      return Container();
    }
  }
}
