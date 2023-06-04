class HeaderTableModel {
  HeaderTableModel({
    required this.title,
    this.onTap,
  });

  final String title;
  final Function()? onTap;
}
