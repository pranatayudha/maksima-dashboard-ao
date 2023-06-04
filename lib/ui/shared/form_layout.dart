import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../application/app/constants/custom_color.dart';
import 'custom_button.dart';
import 'network_sensitive.dart';
import 'styles.dart';
import 'thick_light_grey_divider.dart';

class FormLayout<T extends ChangeNotifier> extends StatefulWidget {
  final String title;
  final String description;
  final Widget? header;
  final Function onBackButtonPressed;
  final bool? forwardButtonVisible;
  final Function? onForwardButtonPressed;
  final bool isBusy;
  final bool? buttonBusy;
  final String mainButtonTitle;
  final double? labelSize;
  final Color? color;
  final Future<dynamic> Function()? onMainButtonPressed;
  final Widget child;

  const FormLayout({
    required this.title,
    required this.description,
    this.header,
    required this.onBackButtonPressed,
    this.forwardButtonVisible = false,
    this.onForwardButtonPressed,
    required this.isBusy,
    this.buttonBusy,
    required this.mainButtonTitle,
    required this.onMainButtonPressed,
    this.labelSize,
    this.color,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<FormLayout> createState() => _FormLayoutState();
}

class _FormLayoutState<T extends ChangeNotifier> extends State<FormLayout> {
  static const double emptySpace = 10.0;
  late ScrollController _scrollController;
  bool isScrolledToTop = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!isScrolledToTop) {
        setState(() {
          isScrolledToTop = true;
        });
      }
    } else {
      if (_scrollController.offset > emptySpace && isScrolledToTop) {
        setState(() {
          isScrolledToTop = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: isScrolledToTop ? 0 : 4,
          backgroundColor: Colors.white,
          title: Text(widget.title, style: tsHeading6),
          centerTitle: true,
          leadingWidth: 30.0,
          leading: Container(
            margin: const EdgeInsets.only(left: 5.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xff606060),
                size: 24.0,
              ),
              onPressed: () => widget.onBackButtonPressed(),
            ),
          ),
          actions: [
            if (widget.forwardButtonVisible!)
              Container(
                margin: const EdgeInsets.only(right: 15.0),
                padding: EdgeInsets.zero,
                width: 30.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xff606060),
                    size: 24.0,
                  ),
                  onPressed: () => widget.onForwardButtonPressed!(),
                ),
              )
            else
              Container(),
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: widget.isBusy,
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () async => false,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0, 20.0, 16.0),
                          child: Text(
                            widget.description,
                            style: tsDescription14,
                          ),
                        ),
                        if (widget.header != null)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: widget.header!,
                          ),
                      ],
                    ),
                    const ThickLightGreyDivider(),
                    widget.child,
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: const Offset(0, -2),
                            color: CustomColor.primaryBlack.withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: CustomButton(
                        label: widget.mainButtonTitle,
                        onPressed: widget.onMainButtonPressed,
                        isBusy: widget.buttonBusy ?? widget.isBusy,
                        labelSize: widget.labelSize,
                        color: widget.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
