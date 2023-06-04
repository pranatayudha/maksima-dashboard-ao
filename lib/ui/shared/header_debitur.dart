import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/text_style_constants.dart';
import '../../application/helpers/responsive_helpers.dart';
import '../../application/helpers/rupiah_formatter.dart';

class HeaderDebitur extends StatelessWidget {
  final Map<String, dynamic> dataDebitur;
  const HeaderDebitur({
    Key? key,
    required this.dataDebitur,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: CustomColor.primaryBlue,
                child: Container(
                  decoration: const BoxDecoration(
                    color: CustomColor.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    dataDebitur['initial'],
                    style: initialName,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataDebitur['name'],
                    style: titleStyle20,
                  ),
                  buildStatus(
                    'Plafond',
                    RupiahFormatter.format(dataDebitur['loanAmount']),
                  ),
                ],
              ),
            ],
          ),
          if (ResponsiveHelpers.isDesktop(context)) const Divider(),
        ],
      ),
    );
  }

  Widget buildStatus(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ),
      margin: const EdgeInsets.only(
        right: 10,
        bottom: 10,
        top: 8,
      ),
      decoration: BoxDecoration(
        color: CustomColor.lightGrey,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
