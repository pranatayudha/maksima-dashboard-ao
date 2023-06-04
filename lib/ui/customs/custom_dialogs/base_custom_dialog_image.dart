import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/constants/custom_color.dart';
import '../../shared/custom_button.dart';

class BaseCustomDialogImage extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const BaseCustomDialogImage({
    this.request,
    this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        children: [
          Container(
            width: 572.0,
            height: 574.0,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  request!.data['imageAsset'],
                  scale: 2,
                ),
                Text(
                  request!.title!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  request!.description!,
                  style: const TextStyle(fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                CustomButton(
                  label: request!.mainButtonTitle!,
                  color: CustomColor.secondaryBlue,
                  radius: 8.0,
                  onPressed: () => completer!(DialogResponse(confirmed: true)),
                  isBusy: false,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => completer!(DialogResponse()),
            ),
          ),
        ],
      ),
    );
  }
}
