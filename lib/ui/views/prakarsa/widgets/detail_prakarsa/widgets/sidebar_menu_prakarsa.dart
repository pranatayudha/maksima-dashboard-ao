import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../../../../../../application/app/constants/common.dart';
import '../../../../../../application/helpers/responsive_helpers.dart';
import '../../../../../../application/models/sidebar_detail_model.dart';
import '../../../../../shared/custom_dropdown.dart';
import '../../../../../shared/header_debitur.dart';
import '../../../../../shared/list_menu.dart';

class SidebarMenuPrakarsa extends StatelessWidget {
  final String selectedPage;
  final Function(Map<String, dynamic> val)? onTap;
  final List<SidebarDetailModel> listSidebar;
  final Map<String, dynamic> dataDebitur;
  final int codeTable;
  final double height;
  const SidebarMenuPrakarsa({
    super.key,
    required this.listSidebar,
    required this.selectedPage,
    required this.onTap,
    required this.dataDebitur,
    required this.codeTable,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveHelpers.isDesktop(context) ? height : null,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: Colors.white,
      ),
      child: Responsive(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Div(
            divison: const Division(
              colS: 6,
              colM: 12,
              colL: 12,
              colXL: 12,
            ),
            child: HeaderDebitur(dataDebitur: dataDebitur),
          ),
          if (ResponsiveHelpers.isDesktop(context))
            ListMenu(
              height: height,
              selectedValue: selectedPage,
              menus: listSidebar,
              onTap: (val) => onTap!(val),
            )
          else
            Div(
              divison: const Division(
                colS: 6,
                colM: 6,
                colL: 6,
                colXL: 6,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomDropDown(
                  listData: codeTable != 1 || codeTable != 4
                      ? Common.sideMenuPrakarsaPerusahaan
                      : Common.sideMenuPrakarsaPerorangan,
                  hintText: 'Screening Awal',
                  selectedValue: TextEditingController(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
