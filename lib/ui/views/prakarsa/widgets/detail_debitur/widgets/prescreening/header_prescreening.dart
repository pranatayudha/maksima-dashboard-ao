import 'package:flutter/material.dart';

import '../../../../../../shared/title_with_count_box.dart';
import '../../../detail_prakarsa/page/screening/widget/reject_prescreening_box.dart';

class HeaderPrescreening extends StatelessWidget {
  final String? preScreeningResult;
  final Function? onTap;
  const HeaderPrescreening({
    Key? key,
    required this.preScreeningResult,
    required this.onTap,
  }) : super(key: key);

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
          if ((preScreeningResult ?? '-') == 'LOLOS')
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
              result: preScreeningResult ?? '-',
              onPressed: onTap,
            ),
        ],
      ),
    );
  }
}
