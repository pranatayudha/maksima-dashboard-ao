import 'package:flutter/material.dart';

import '../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../shared/title_with_count_box.dart';
import 'reject_prescreening_box.dart';

class ScreeningHeader extends StatelessWidget {
  final int codeTable;
  final String? preScreeningResult;
  final String name;
  final String? noHp;
  final String? npwp;
  final Function? onTap;
  const ScreeningHeader({
    super.key,
    required this.codeTable,
    this.preScreeningResult,
    required this.name,
    this.noHp,
    this.npwp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleScreening(codeTable, name, noHp, npwp),
          if ((preScreeningResult ?? '') == 'LOLOS')
            TitleWithCountBox(
              title: 'Hasil Pre-Screening',
              count: preScreeningResult ?? '-',
              color: (preScreeningResult ?? '-') == 'LOLOS'
                  ? const Color(0xff38BAA7)
                  : Colors.red,
              align: 2,
            )
          else
            RejectPrescreeningBox(
              result: preScreeningResult ?? '',
              onPressed: onTap,
            ),
        ],
      ),
    );
  }

  Widget titleScreening(
    int codeTable,
    String name,
    String? noHp,
    String? npwp,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: titleStyle20.copyWith(
            fontSize: 22.0,
          ),
        ),
        Text(
          codeTable == 1 || codeTable == 4
              ? 'Nomor HP: $noHp'
              : 'Nomor NPWP: $npwp',
          style: titleStyle16.copyWith(
            fontWeight: FontWeight.normal,
            color: CustomColor.darkGrey,
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
