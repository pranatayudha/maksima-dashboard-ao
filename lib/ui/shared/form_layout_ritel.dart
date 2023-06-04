import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../application/app/constants/custom_color.dart';
import 'custom_button.dart';
import 'network_sensitive.dart';
import 'styles.dart';

class FormLayoutRitel<T extends ChangeNotifier> extends StatefulWidget {
  final String title;
  final Function onBackButtonPressed;
  final bool? addButtonVisible;
  final Function? onAddButtonPressed;
  final bool isBusy;
  final bool? buttonBusy;
  final String mainButtonTitle;
  final Future<dynamic> Function()? onMainButtonPressed;
  final Widget child;
  final double? labelSize;
  final Color? color;

  const FormLayoutRitel({
    required this.title,
    required this.onBackButtonPressed,
    this.addButtonVisible = false,
    this.onAddButtonPressed,
    required this.isBusy,
    this.buttonBusy,
    required this.mainButtonTitle,
    required this.onMainButtonPressed,
    required this.child,
    this.labelSize,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<FormLayoutRitel> createState() => _FormLayoutRitelState();
}

class _FormLayoutRitelState<T extends ChangeNotifier>
    extends State<FormLayoutRitel> {
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
            if (widget.addButtonVisible!)
              Container(
                margin: const EdgeInsets.only(right: 15.0),
                padding: EdgeInsets.zero,
                width: 30.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xffF07126),
                    size: 24.0,
                  ),
                  onPressed: () => widget.onAddButtonPressed!(),
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
