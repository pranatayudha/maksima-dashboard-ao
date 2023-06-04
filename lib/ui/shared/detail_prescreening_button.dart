import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../application/app/app.locator.dart';
import '../../../../application/app/constants/icon_constants.dart';
import '../../../../application/enums/dialog_type.dart';
import '../../application/app/constants/custom_color.dart';
import 'styles.dart';

class DetailPrescreeningButton extends StatelessWidget {
  final String label;
  final String description;
  final Function? onPressed;
  final bool? disabled;
  final bool? isScreeningAwal;

  const DetailPrescreeningButton({
    required this.label,
    required this.description,
    this.disabled = false,
    this.onPressed,
    this.isScreeningAwal = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return disabled! ? _buildDisabledButton() : _buildEnabledButton();
  }

  Widget _buildDisabledButton() {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: isScreeningAwal!
                ? const EdgeInsets.only(right: 15.0)
                : EdgeInsets.zero,
          ),
          onPressed: null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(label, style: tsHeading10DarkGrey)],
              ),
              Opacity(
                opacity: 0.3,
                child: Image.asset(IconConstants.chevronRight, scale: 3),
              ),
            ],
          ),
        ),
        Divider(
          color: const Color(0xffC8C8C8).withOpacity(0.4),
          height: 20.0,
          thickness: 1.0,
          endIndent: isScreeningAwal! ? 15.0 : 0.0,
        ),
      ],
    );
  }

  Widget _buildEnabledButton() {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: isScreeningAwal!
                ? const EdgeInsets.only(right: 15.0)
                : EdgeInsets.zero,
          ),
          onPressed: () => onPressed != null
              ? onPressed!()
              : locator<DialogService>()
                  .showCustomDialog(variant: DialogType.inDevelopment),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: tsHeading10),
                  const SizedBox(height: 2.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: description == 'Lolos' || description == 'LOLOS'
                          ? Colors.green
                          : description == 'Warning'
                              ? CustomColor.warningText
                              : CustomColor.secondaryRed80,
                    ),
                  ),
                ],
              ),
              Image.asset(IconConstants.chevronRight, scale: 3),
            ],
          ),
        ),
        Divider(
          color: const Color(0xffC8C8C8).withOpacity(0.4),
          height: 20.0,
          thickness: 1.0,
          endIndent: isScreeningAwal! ? 15.0 : 0.0,
        ),
      ],
    );
  }
}
