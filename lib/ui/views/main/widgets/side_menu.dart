import 'package:flutter/material.dart';

import '../../../../application/app/constants/custom_color.dart';
import '../../../../application/app/constants/icon_constants.dart';
import '../../../../application/app/constants/image_constants.dart';
import '../../../shared/thick_light_grey_divider.dart';

class SideMenu extends StatefulWidget {
  final Function(int i) onTap;
  const SideMenu({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColor.sideBarBackground,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Image.asset(
                    ImageConstants.pinangMaximaWhite,
                    height: 50,
                  ),
                ),
                // const SizedBox(width: 10),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Dashboard RM',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const ThickLightGreyDivider(verticalPadding: 0.0),
          DrawerListTile(
            title: 'Dashboard',
            imgSrc: IconConstants.dashboardInactive,
            press: () => widget.onTap(0),
          ),
          DrawerListTile(
            title: 'Pipeline',
            imgSrc: IconConstants.pipelineInactive,
            press: () => widget.onTap(1),
          ),
          DrawerListTile(
            title: 'Prakarsa',
            imgSrc: IconConstants.prakarsaInactive,
            press: () => widget.onTap(2),
          ),
          DrawerListTile(
            title: 'Monitoring',
            imgSrc: IconConstants.monitoringInactive,
            press: () => widget.onTap(3),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, imgSrc;
  final VoidCallback press;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.imgSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 5.0,
      leading: Image.asset(
        imgSrc,
        scale: 3,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
