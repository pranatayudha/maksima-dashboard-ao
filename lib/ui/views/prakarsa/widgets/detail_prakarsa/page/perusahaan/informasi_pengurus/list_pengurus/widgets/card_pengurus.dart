// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';

class CardPengurus extends StatelessWidget {
  final bool isKeyPerson;
  final Widget status;
  final String name;
  final String position;
  final Function() onTap;
  const CardPengurus({
    Key? key,
    required this.isKeyPerson,
    required this.status,
    required this.name,
    required this.position,
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
                  status,
                  const SizedBox(width: 16),
                  Image.asset(IconConstants.user, scale: 3),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xff03213E),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      RichText(
                        text: TextSpan(
                          text: position,
                          style: const TextStyle(fontSize: 12),
                          children: isKeyPerson
                              ? [
                                  const TextSpan(
                                    text: ' (Key Person)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: CustomColor.primaryBlue,
                                    ),
                                  ),
                                ]
                              : [],
                        ),
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
