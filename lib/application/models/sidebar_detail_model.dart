class SidebarDetailModel {
  final String flag;
  final List<Menu> menu;

  SidebarDetailModel({
    required this.flag,
    required this.menu,
  });
}

class Menu {
  final String title;
  final bool? status;
  final List<SubMenu> subMenu;
  final Function? onTap;

  Menu({
    required this.title,
    required this.status,
    required this.subMenu,
    this.onTap,
  });
}

class SubMenu {
  final String title;
  final bool? status;
  final Function? onTap;

  SubMenu({required this.title, required this.status, this.onTap});
}
