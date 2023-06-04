import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/icon_constants.dart';
import 'styles.dart';

class CustomTypeAheadFormField<T> extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function onClear;
  final FutureOr<Iterable<T>> Function(String) onFilter;
  final Function onSuggestionSelected;
  final Widget Function(BuildContext, T) itemBuilder;
  final String? Function(String?)? validator;

  const CustomTypeAheadFormField({
    required this.label,
    required this.controller,
    required this.onClear,
    required this.onFilter,
    required this.onSuggestionSelected,
    required this.itemBuilder,
    required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: tsCaption1),
              if (controller.text.isNotEmpty)
                GestureDetector(
                  onTap: () => onClear(),
                  child: const Text(
                    'Clear',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6.0),
          TypeAheadFormField<T>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              style: const TextStyle(height: 1.2),
              decoration: InputDecoration(
                suffixIcon: Image.asset(IconConstants.chevronDown, scale: 3),
                hintText: 'Pilih $label',
                hintStyle: const TextStyle(color: Colors.black38),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: controller.text.isNotEmpty
                        ? Colors.green
                        : Colors.black38,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: controller.text.isNotEmpty
                        ? Colors.green
                        : Colors.black38,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: controller.text.isNotEmpty
                        ? Colors.green
                        : Colors.black38,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                    color: controller.text.isNotEmpty
                        ? Colors.green
                        : CustomColor.secondaryBlue,
                  ),
                ),
              ),
              minLines: 1,
              maxLines: 3,
              onSubmitted: (val) => onClear(),
            ),
            suggestionsCallback: (pattern) {
              final query = pattern.toLowerCase();
              // ignore: newline-before-return
              return onFilter(query);
            },
            itemBuilder: itemBuilder,
            onSuggestionSelected: (suggestion) {
              onSuggestionSelected(suggestion);
            },
            noItemsFoundBuilder: (context) => Center(
              child: Text(
                '$label tidak ditemukan.',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
