import 'package:flutter/material.dart';

import 'styles.dart';

class StatefulAppBarElevationAware extends StatefulWidget {
  final String appBarTitle;
  final Function onLeadingPressed;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const StatefulAppBarElevationAware({
    required this.appBarTitle,
    required this.onLeadingPressed,
    required this.children,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulAppBarElevationAware> createState() =>
      _StatefulAppBarElevationAwareState();
}

class _StatefulAppBarElevationAwareState
    extends State<StatefulAppBarElevationAware> {
  /// emptySpace is a distance of empty padding,
  /// only after scrolling through it the content starts
  /// getting under the app bar.
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
      /// Call setState only when values are about to change
      if (!isScrolledToTop) {
        setState(() {
          //reach the top
          isScrolledToTop = true;
        });
      }
    } else {
      /// Call setState only when values are about to change
      if (_scrollController.offset > emptySpace && isScrolledToTop) {
        setState(() {
          /// Not the top
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: isScrolledToTop ? 0 : 4,
        backgroundColor: Colors.white,
        title: Text(widget.appBarTitle, style: tsHeading6),
        centerTitle: true,
        leading: Container(
          padding: EdgeInsets.zero,
          width: 30.0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff606060)),
            onPressed: () => widget.onLeadingPressed(),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          padding: widget.padding ?? const EdgeInsets.fromLTRB(0, 0, 0, 20),
          children: widget.children,
        ),
      ),
    );
  }
}
