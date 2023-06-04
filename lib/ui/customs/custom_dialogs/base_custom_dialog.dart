import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/constants/custom_color.dart';
import '../../shared/custom_button.dart';
import '../../shared/custom_outlined_button.dart';

class BaseCustomDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const BaseCustomDialog({
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
            width: 500.0,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  request!.title!,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  request!.description!,
                  style: const TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 30.0),
                request!.secondaryButtonTitle != null
                    ? Row(
                        children: [
                          Expanded(
                            child: CustomOutlinedButton(
                              label: request!.mainButtonTitle!,
                              radius: 8.0,
                              onPressed: () => completer!(
                                DialogResponse(
                                  confirmed: request?.data['main'] ?? true,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: CustomButton(
                              label: request!.secondaryButtonTitle!,
                              radius: 8.0,
                              onPressed: () => completer!(
                                DialogResponse(
                                  confirmed:
                                      request?.data['secondary'] ?? false,
                                ),
                              ),
                              isBusy: false,
                            ),
                          ),
                        ],
                      )
                    : CustomButton(
                        label: request!.mainButtonTitle!,
                        color: request!.data != null
                            ? request!.data['color'] as Color
                            : CustomColor.secondaryBlue,
                        radius: 8.0,
                        onPressed: () =>
                            completer!(DialogResponse(confirmed: true)),
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
