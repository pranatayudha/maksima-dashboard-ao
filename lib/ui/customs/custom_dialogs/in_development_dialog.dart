import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/constants/image_constants.dart';
import '../../shared/custom_button.dart';
import '../../shared/styles.dart';

class InDevelopmentDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const InDevelopmentDialog({
    this.request,
    this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        width: 500.0,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.blueTexturedBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                child:
                    Image.asset(ImageConstants.pinangMaximaWhite, scale: 1.8),
              ),
            ),
            const SizedBox(height: 40.0),
            const Text('Upcoming', style: tsHeading4White),
            const SizedBox(height: 4.0),
            const Text(
              'Nantikan updatenya segera, \nhanya di Pinang Maksima!',
              style: tsBody6White,
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              label: 'OK',
              labelColor: const Color(0xff0F6FC2),
              radius: 8.0,
              color: Colors.white,
              onPressed: () => completer!(DialogResponse(confirmed: true)),
              isBusy: false,
            ),
          ],
        ),
      ),
    );
  }
}
