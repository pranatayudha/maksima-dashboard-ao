import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/icon_constants.dart';
import '../../application/app/constants/text_style_constants.dart';
import '../../application/models/sidebar_detail_model.dart';

class ListMenu extends StatefulWidget {
  final String selectedValue;
  final Function(Map<String, dynamic> val)? onTap;
  final List<SidebarDetailModel> menus;
  final double height;
  const ListMenu({
    Key? key,
    required this.menus,
    required this.selectedValue,
    required this.onTap,
    required this.height,
  }) : super(key: key);

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height - 100,
      padding: const EdgeInsets.only(bottom: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.menus.length,
              (index) => buildMenu(
                widget.menus[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenu(SidebarDetailModel menu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Text(
            menu.flag,
            style: titleStyle14,
          ),
        ),
        ...List.generate(
          menu.menu.length,
          (index) => Stack(
            children: [
              buildItemMenu(
                menu.menu[index],
              ),
              if (menu.menu[index].onTap == null)
                Container(
                  color: Colors.white.withOpacity(0.5),
                  child: const ListTile(
                    enabled: false,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItemMenu(Menu mainMenu) {
    if (mainMenu.subMenu.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: widget.selectedValue == mainMenu.title
              ? CustomColor.lighterBlue
              : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: const [
            BoxShadow(
              color: CustomColor.lightGrey,
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            mainMenu.title,
            style: normalStyle,
          ),
          onTap: (() {
            setState(() {
              widget.onTap!(
                {
                  'title': mainMenu.title,
                  'status': mainMenu.status,
                },
              );
            });
          }),
          trailing:
              mainMenu.status != null ? getStatus(mainMenu.status!) : null,
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColor.lightGrey,
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ExpansionTile(
          title: Text(
            mainMenu.title,
            style: normalStyle,
          ),
          initiallyExpanded:
              isSubmenuSelected(mainMenu.subMenu, widget.selectedValue),
          trailing: Wrap(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.keyboard_arrow_down_outlined),
              mainMenu.status != null
                  ? getStatus(mainMenu.status!)
                  : const SizedBox(),
            ],
          ),
          children: List.generate(
            mainMenu.subMenu.length,
            (index) => Container(
              color: mainMenu.subMenu[index].title == widget.selectedValue
                  ? CustomColor.lighterBlue
                  : Colors.white,
              child: ListTile(
                title: Text(
                  mainMenu.subMenu[index].title,
                  style: normalStyle,
                ),
                trailing: mainMenu.subMenu[index].status != null
                    ? getStatus(mainMenu.subMenu[index].status!)
                    : null,
                onTap: () {
                  setState(() {
                    widget.onTap!(
                      {
                        'title': mainMenu.subMenu[index].title,
                        'status': mainMenu.subMenu[index].status,
                      },
                    );
                  });
                },
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget getStatus(bool status) {
    return Container(
      decoration: BoxDecoration(
        color: status ? CustomColor.stateSuccess : CustomColor.warningText,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Image.asset(
        status ? IconConstants.iconChecked : IconConstants.iconWarning,
        height: 16,
      ),
    );
  }

  bool isSubmenuSelected(List<SubMenu> submenu, String value) {
    bool isFind = false;
    submenu.forEach((element) {
      if (element.title == value) {
        isFind = true;
      }
    });

    return isFind;
  }
}
