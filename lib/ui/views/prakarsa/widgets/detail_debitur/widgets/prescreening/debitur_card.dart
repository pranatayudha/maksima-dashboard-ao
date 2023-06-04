import 'package:flutter/material.dart';

import '../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../shared/detail_prescreening_button.dart';
import '../../../detail_prakarsa/page/screening/widget/prescreening_dialog.dart';
import '../../detail_debitur_viewmodel.dart';

class DebiturCard extends StatelessWidget {
  final DetailDebiturViewModel vm;
  const DebiturCard({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DebiturSection(vm: vm),
        SpouseSection(vm: vm),
      ],
    );
  }
}

class DebiturSection extends StatelessWidget {
  final DetailDebiturViewModel vm;
  const DebiturSection({
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
          vm.screeningDebitur.dukcapil!.reason![1].fieldName!,
          style: titleStyle16,
        ),
        const SizedBox(height: 8.0),
        DetailPrescreeningButton(
          label: 'LPG',
          description: vm.screeningDebitur.lpg!.status!,
          onPressed: () => PreScreeningDialog().showDialogLpg(
            context,
            title: vm.screeningDebitur.dukcapil!.reason![1].fieldName ?? '',
          ),
        ),
        DetailPrescreeningButton(
          label: 'SLIK',
          description: vm.screeningDebitur.slik!.status!,
          onPressed: () => PreScreeningDialog().showDialogSlik(
            context: context,
            onTap: () => vm.downloadFileSlikPerorangan(
              0,
              vm.screeningDebitur.dukcapil?.reason![1].fieldName ?? '',
              context,
            ),
            status: vm.screeningDebitur.slik?.status ?? '-',
            reason: vm.screeningDebitur.slik?.reason ?? '-',
          ),
        ),
        DetailPrescreeningButton(
          label: 'Dukcapil',
          description: vm.screeningDebitur.dukcapil!.status!,
          onPressed: () => PreScreeningDialog().showDialogDukcapil(
            context,
            data: vm.screeningDebitur.dukcapil?.reason,
            onTap: () =>
                vm.openFile(context: context, url: vm.preScreeningPath[2]),
            urlFile: vm.preScreeningPath[0],
          ),
        ),
        DetailPrescreeningButton(
          label: 'DHN',
          description: vm.screeningDebitur.dhn!.status!,
          onPressed: () => PreScreeningDialog().showDialogDhn(
            context,
            vm.screeningDebitur.dukcapil?.reason?[1].fieldName ?? '-',
          ),
        ),
      ],
    );
  }
}

class SpouseSection extends StatelessWidget {
  final DetailDebiturViewModel vm;
  const SpouseSection({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vm.screeningSpouse != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          Text(
            vm.screeningSpouse!.dukcapil!.reason![1].fieldName!,
            style: titleStyle16,
          ),
          const SizedBox(height: 8.0),
          DetailPrescreeningButton(
            label: 'Dukcapil',
            description: vm.screeningSpouse!.dukcapil!.status!,
            onPressed: () => PreScreeningDialog().showDialogDukcapil(
              context,
              data: vm.screeningSpouse?.dukcapil?.reason,
              onTap: () =>
                  vm.openFile(context: context, url: vm.preScreeningPath[1]),
              urlFile: vm.preScreeningPath[1],
            ),
          ),
          DetailPrescreeningButton(
            label: 'SLIK',
            description: vm.screeningSpouse!.slik!.status!,
            onPressed: () => PreScreeningDialog().showDialogSlik(
              context: context,
              onTap: () => vm.downloadFileSlikPerorangan(
                1,
                vm.screeningSpouse?.dukcapil?.reason![1].fieldName ?? '',
                context,
              ),
              status: vm.screeningSpouse?.slik?.status ?? '-',
              reason: vm.screeningSpouse?.slik?.reason ?? '-',
            ),
          ),
          DetailPrescreeningButton(
            label: 'DHN',
            description: vm.screeningSpouse!.dhn!.status!,
            onPressed: () => PreScreeningDialog().showDialogDhn(
              context,
              vm.screeningSpouse?.dukcapil?.reason?[1].fieldName ?? '-',
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
