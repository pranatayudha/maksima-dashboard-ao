import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;
  final bool? hideButtonClose;
  final Function()? onClose;
  const BaseDialog({
    Key? key,
    required this.child,
    this.hideButtonClose,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      content: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            child,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onClose ??
                      () {
                        Navigator.pop(context);
                      },
                  icon: Icon(
                    Icons.close,
                    color:
                        (hideButtonClose ?? false) ? Colors.white : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
