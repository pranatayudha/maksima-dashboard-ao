import 'package:flutter/material.dart';

import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/models/list_agunan_tambahan_model.dart';

class AgunanTambahanCard extends StatelessWidget {
  final int index;
  final ListAgunanTambahanModel dataAgunan;
  final Function() onTap;
  const AgunanTambahanCard({
    Key? key,
    required this.index,
    required this.dataAgunan,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(IconConstants.paper, scale: 3),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agunan Tambahan #${index + 1} - ${dataAgunan.codeTable}',
                        style: titleStyle14,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        dataAgunan.status ?? '-',
                        style: valueStatusStyle,
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset(IconConstants.arrowRight, scale: 3),
            ],
          ),
        ),
      ),
    );
  }
}
