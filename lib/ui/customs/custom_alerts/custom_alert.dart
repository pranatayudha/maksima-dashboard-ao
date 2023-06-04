import 'package:flutter/material.dart';

import '../../../application/app/constants/custom_color.dart';
import 'custom_alert_style.dart';
import 'custom_alert_utils.dart';

class CustomAlert extends StatefulWidget {
  final AlertVisibility visibility;
  final Widget? heading;
  final bool closeButton;
  final CustomAlertStyle style;
  final TextStyle? textStyle;
  final TextStyle? headingTextStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onClose;
  final Widget? child;

  const CustomAlert({
    Key? key,
    this.visibility = AlertVisibility.block,
    this.closeButton = false,
    this.heading,
    this.style = CustomAlertStyle.primary,
    this.textStyle,
    this.headingTextStyle,
    this.margin,
    this.padding,
    this.child,
    this.onClose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomAlertState();
  }
}

class _CustomAlertState extends State<CustomAlert> {
  bool _visibility = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(microseconds: 500),
      () {
        BreakPoint breakPoint = BreakPoint.of(context);
        _visibility = widget.visibility.breakPoints.contains(breakPoint.state);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_visibility
        ? Container()
        : Container(
            margin: widget.margin,
            padding: widget.padding ?? const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: widget.style.color!.backgroundColor,
              borderRadius: widget.style.borderRadius,
              border: Border.all(
                color: widget.style.color!.borderColor,
                width: 2,
              ),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: CustomColor.primaryBlack,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ).merge(widget.textStyle),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.heading == null
                            ? Container()
                            : DefaultTextStyle(
                                style: TextStyle(
                                  color: widget.style.color!.color,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: widget.heading,
                                ),
                              ),
                        Row(
                          children: [
                            Expanded(child: Container(child: widget.child)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  !widget.closeButton
                      ? Container(width: 0)
                      : TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size(20.0, 20.0),
                          ),
                          onPressed: () => _closeCustomAlert(),
                          child: const Icon(
                            Icons.close,
                            size: 14.0,
                            color: CustomColor.primaryBlack,
                          ),
                        ),
                ],
              ),
            ),
          );
  }

  void _closeCustomAlert() {
    setState(() {
      _visibility = false;
      if (widget.onClose != null) widget.onClose!();
    });
  }
}
