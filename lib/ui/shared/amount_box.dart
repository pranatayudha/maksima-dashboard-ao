import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../application/app/constants/custom_color.dart';
import 'styles.dart';

class AmountBox extends StatelessWidget {
  final String label;
  final dynamic amount;
  final Color? amountColor;
  final String? subtitle;
  final bool isRupiah;

  const AmountBox({
    required this.label,
    required this.amount,
    this.amountColor,
    this.subtitle,
    this.isRupiah = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###', 'id_ID');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xffF6F6F8),
        border: Border.all(color: const Color(0xffE5E5E5)),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(label, style: tsHeading12),
            const SizedBox(height: 8.0),
            if (subtitle != null) ...[
              Text(subtitle!, style: tsCaption2),
              const SizedBox(height: 8.0),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isRupiah ? 'Rp. ' : '',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    color: amountColor ?? CustomColor.primaryBlack40,
                  ),
                ),
                Text(
                  amount != null ? formatter.format(amount) : '0',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    color: amountColor ?? CustomColor.primaryBlack40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
