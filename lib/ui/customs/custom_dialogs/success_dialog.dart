import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/constants/custom_color.dart';
import '../../shared/custom_button.dart';

class SuccessDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const SuccessDialog({
    this.request,
    this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 500.0,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50.0),
                Text(
                  request!.description!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 30.0),
                CustomButton(
                  label: request!.mainButtonTitle!,
                  color: CustomColor.secondaryGreen,
                  radius: 8.0,
                  onPressed: () => completer!(DialogResponse(confirmed: true)),
                  isBusy: false,
                ),
              ],
            ),
          ),
          const Positioned(
            top: -48.0,
            child: CircleAvatar(
              minRadius: 48.0,
              maxRadius: 48.0,
              backgroundColor: CustomColor.secondaryGreen,
              child: Icon(
                Icons.check,
                size: 64.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
