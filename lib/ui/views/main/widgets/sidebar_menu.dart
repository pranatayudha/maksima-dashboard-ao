import 'package:flutter/material.dart';

import '../../../../application/app/constants/custom_color.dart';
import '../../../../application/app/constants/icon_constants.dart';
import '../../../shared/base_view.dart';
import '../../../shared/custom_collapsible_item.dart';
import '../../../shared/custom_collapsible_sidebar.dart';
import 'body_menu.dart';

// ignore: must_be_immutable
class SidebarPage extends StatefulWidget {
  final String username;
  final String personalNumber;
  final String photo;
  final Function() onPressedLogout;
  int selectedPage;
  SidebarPage({
    super.key,
    required this.username,
    required this.personalNumber,
    required this.photo,
    required this.onPressedLogout,
    this.selectedPage = 2,
  });

  @override
  State<SidebarPage> createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CustomCollapsibleItem> _items = [];
  int indexSelected = 2;

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    indexSelected = widget.selectedPage;
  }

  List<CustomCollapsibleItem> get _generateItems {
    return [
      CustomCollapsibleItem(
        text: 'Dashboard',
        iconUnSelected: IconConstants.dashboardInactive,
        iconSelected: IconConstants.dashboardActive,
        onPressed: () => setState(() => widget.selectedPage = 0),
      ),
      CustomCollapsibleItem(
        text: 'Pipeline',
        iconUnSelected: IconConstants.pipelineInactive,
        iconSelected: IconConstants.pipelineActive,
        onPressed: () => setState(() => widget.selectedPage = 1),
      ),
      CustomCollapsibleItem(
        text: 'Prakarsa',
        iconUnSelected: IconConstants.prakarsaInactive,
        iconSelected: IconConstants.prakarsaActive,
        onPressed: () => setState(() => widget.selectedPage = 2),
        isSelected: true,
      ),
      CustomCollapsibleItem(
        text: 'Monitoring',
        iconUnSelected: IconConstants.monitoringInactive,
        iconSelected: IconConstants.monitoringActive,
        onPressed: () => setState(() => widget.selectedPage = 3),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: CustomCollapsibleSidebar(
        isCollapsed: MediaQuery.of(context).size.width <= 1024,
        items: _items,
        // avatarImg: _avatarImg,
        title: 'Dashboard RM',
        body: _body(
          size,
          context,
          widget.username,
          widget.personalNumber,
          widget.photo,
          widget.onPressedLogout,
        ),
        backgroundColor: CustomColor.sideBarBackground,
        selectedTextColor: Colors.black,
        unselectedTextColor: Colors.white,
        selectedIconColor: CustomColor.sideBarBackground,
        unselectedIconColor: Colors.white,
        selectedIconBox: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        toggleTitleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        borderRadius: 0.0,
        screenPadding: 0,
        iconSize: 20,
        sidebarBoxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }

  // ignore: long-parameter-list
  Widget _body(
    Size size,
    BuildContext context,
    String username,
    String personalNumber,
    String photo,
    Function() onPressedLogout,
  ) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color(0xFFE5E5E5),
      child: Column(
        children: [
          BaseView(
            username: username,
            personalNumber: personalNumber,
            photo: photo,
            onPressedLogout: onPressedLogout,
          ),
          BodyMenu(
            index: widget.selectedPage,
          ),
        ],
      ),
    );
  }
}
