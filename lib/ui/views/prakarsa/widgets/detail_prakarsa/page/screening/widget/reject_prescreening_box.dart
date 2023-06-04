import 'package:flutter/material.dart';

import '../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../shared/custom_outlined_button.dart';

class RejectPrescreeningBox extends StatelessWidget {
  final String result;
  final Function? onPressed;
  const RejectPrescreeningBox({
    Key? key,
    required this.result,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 304,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xffF6F6F8),
        boxShadow: [
          BoxShadow(color: Color(0xffE5E5E5), spreadRadius: 1.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            result,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: CustomColor.primaryRed80,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: 'Dukcapil',
              style: titleStyle14,
              children: [
                TextSpan(
                  text: ' ditolak saat Pre-Screening',
                  style: titleStyle14.copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomOutlinedButton(
            label: 'Lihat Catatan',
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
