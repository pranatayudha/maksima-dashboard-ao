import 'package:flutter/material.dart';

import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/models/list_agunan_pokok_model.dart';

class AgunanPokokCard extends StatelessWidget {
  final int index;
  final ListAgunanModel dataAgunan;
  final Function() onTap;
  const AgunanPokokCard({
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
                        'Agunan Pokok #${index + 1} - ${dataAgunan.jenisAgunanPokok != 250 ? 'Persediaan' : 'Piutang'}',
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
