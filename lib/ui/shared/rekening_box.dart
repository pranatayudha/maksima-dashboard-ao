import 'package:flutter/material.dart';

import '../../application/app/constants/image_constants.dart';
import 'styles.dart';

class RekeningBox extends StatelessWidget {
  final int type;
  final String namaDebitur;
  final String noRekening;
  const RekeningBox({
    Key? key,
    required this.type,
    required this.namaDebitur,
    required this.noRekening,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type == 1 ? 'Rekening Pencairan' : 'Rekening Escrow Pembayaran',
            style: tsCaption1,
          ),
          const SizedBox(height: 6.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ImageConstants.raya,
                    scale: 3,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        namaDebitur,
                        style: tsHeading10,
                      ),
                      Text(
                        noRekening,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Color(0xff99A0AF),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
