class CustomCollapsibleItem {
  CustomCollapsibleItem({
    required this.text,
    required this.iconSelected,
    required this.iconUnSelected,
    required this.onPressed,
    this.isSelected = false,
  });

  final String text;
  final String iconSelected;
  final String iconUnSelected;
  final Function onPressed;
  bool isSelected;
}
