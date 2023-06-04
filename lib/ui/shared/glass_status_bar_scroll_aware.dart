import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../application/app/constants/custom_color.dart';
import 'network_sensitive.dart';
import 'processing_indicator.dart';

class GlassStatusBarScrollAware extends StatefulWidget {
  final List<Widget> children;
  final Function? onRefresh;
  final bool? withModalProgressHUD;
  final bool? inAsyncCall;
  final String? processingIndicatorMessage;
  final Color? backgroundColor;

  const GlassStatusBarScrollAware({
    Key? key,
    required this.children,
    this.onRefresh,
    this.withModalProgressHUD = false,
    this.inAsyncCall,
    this.processingIndicatorMessage,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<GlassStatusBarScrollAware> createState() =>
      _GlassStatusBarScrollAwareState();
}

class _GlassStatusBarScrollAwareState extends State<GlassStatusBarScrollAware> {
  static const double _emptySpace = 10.0;
  late ScrollController _scrollController;
  bool _isScrolledToTop = true;

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
      if (!_isScrolledToTop) {
        setState(() {
          _isScrolledToTop = true;
        });
      }
    } else {
      if (_scrollController.offset > _emptySpace && _isScrolledToTop) {
        setState(() {
          _isScrolledToTop = false;
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
        backgroundColor: widget.backgroundColor ?? Colors.grey.shade100,
        body: Stack(
          children: [
            widget.onRefresh != null && !widget.withModalProgressHUD!
                ? RefreshIndicator(
                    onRefresh: () => widget.onRefresh!(),
                    child: ListView(
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: widget.children,
                    ),
                  )
                : ModalProgressHUD(
                    inAsyncCall: widget.inAsyncCall!,
                    progressIndicator: ProcessingIndicator(
                      label: widget.processingIndicatorMessage!,
                      labelColor: CustomColor.primaryBlack,
                    ),
                    child: Container(
                      color: Colors.grey.shade100,
                      child: ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: widget.children,
                      ),
                    ),
                  ),
            if (!_isScrolledToTop)
              Container(height: MediaQuery.of(context).padding.top).asGlass(),
          ],
        ),
      ),
    );
  }
}
