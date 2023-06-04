import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/icon_constants.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Function? onSubmitted;
  final Function? onChanged;
  final bool isSearchActive;

  const CustomSearchBar({
    this.controller,
    required this.hintText,
    this.onSubmitted,
    this.onChanged,
    required this.isSearchActive,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(color: Color(0xff99A0AF)),
        ),
        suffixIcon: Image.asset(
          isSearchActive
              ? IconConstants.searchActive
              : IconConstants.searchBlack,
          scale: 3,
        ),
        hintStyle: const TextStyle(color: CustomColor.darkGrey),
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
      ),
      onChanged: onChanged != null ? (val) => onChanged!(val) : null,
      onSubmitted: onSubmitted != null ? (val) => onSubmitted!(val) : null,
      textInputAction: TextInputAction.search,
    );
  }
}
