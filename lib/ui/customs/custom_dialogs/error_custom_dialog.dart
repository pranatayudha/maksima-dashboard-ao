import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../shared/custom_button.dart';

class ErrorCustomDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const ErrorCustomDialog({
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.red),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        request!.title!,
                        style: TextStyle(
                          fontSize: request!.title!.length > 20.0 ? 18.0 : 24.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.8,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  request!.description!,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                CustomButton(
                  label: request!.mainButtonTitle!,
                  radius: 8.0,
                  isBusy: false,
                  onPressed: () => completer!(DialogResponse(confirmed: true)),
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
