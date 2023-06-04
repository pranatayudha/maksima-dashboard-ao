// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/services/local_db_service.dart';

class FeedbackSuccessDialog extends StatefulWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const FeedbackSuccessDialog({
    this.request,
    this.completer,
    Key? key,
  }) : super(key: key);

  @override
  _FeedbackSuccessDialogState createState() => _FeedbackSuccessDialogState();
}

class _FeedbackSuccessDialogState extends State<FeedbackSuccessDialog> {
  final _localDBService = locator<LocalDBService>();

  @override
  Widget build(BuildContext context) {
    final userName = _localDBService.getUser()!.userName;

    return Dialog(
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Stack(
        children: [
          Container(
            width: 500.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 22.0,
              vertical: 80.0,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Terima kasih ',
                style: const TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 16.0,
                  letterSpacing: 0.29,
                  height: 1.5,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        ', kritik dan saran Anda dapat membantu kami untuk menjadi lebih baik.',
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: GestureDetector(
              onTap: () => widget.completer!(DialogResponse(confirmed: false)),
              child: ClipOval(
                child: Container(
                  height: 23.56,
                  width: 23.56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black87),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.clear,
                      size: 20.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
