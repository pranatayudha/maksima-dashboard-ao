import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../application/app/constants/custom_color.dart';
import '../../../application/app/constants/icon_constants.dart';
import '../../../application/app/constants/text_style_constants.dart';
import '../../../application/models/postal_code_model.dart';
import '../custom_button.dart';
import '../custom_textfield.dart';
import 'postal_code_viewmodel.dart';

class PostalCodeView extends ViewModelBuilderWidget<PostalCodeViewModel> {
  final Function(PostalCodeModel) callBack;
  const PostalCodeView({
    super.key,
    required this.callBack,
  });

  @override
  PostalCodeViewModel viewModelBuilder(BuildContext context) =>
      PostalCodeViewModel();

  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    PostalCodeViewModel viewModel,
    Widget? child,
  ) {
    Timer? debounce;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: CustomColor.primaryBlue,
          child: Center(
            child: Text(
              'Cari Kode Pos',
              style: titleStyle20.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextField(
                      textEditingController:
                          viewModel.searchPostalCodeController,
                      hintText: 'Cari Kodepos / Lokasi',
                      withPrefixIcon: true,
                      prefixIconImagePath: IconConstants.searchBlack,
                      textCapitalization: TextCapitalization.words,
                      onSave: viewModel.updatePostalCode,
                      onChanged: (String val) {
                        if (viewModel.isBusy) {
                          return;
                        }

                        if (debounce?.isActive ?? false) {
                          debounce!.cancel();
                        }

                        debounce = Timer(
                          const Duration(milliseconds: 800),
                          () {
                            viewModel.updatePostalCode(val);
                            viewModel.updateValue(0);
                          },
                        );
                      },
                    ),
                  ),
                  if (viewModel.listPostalCode.isNotEmpty)
                    for (var i = 0; i < viewModel.listPostalCode.length; i++)
                      _singleChildComponent(
                        context,
                        i + 1,
                        viewModel.value,
                        (value) => viewModel.updateValue(value),
                        viewModel.listPostalCode[i],
                      ),
                ],
              ),
            ],
          ),
        ),
        _buttonSelect(
          context,
          viewModel.value,
          viewModel,
        ),
      ],
    );
  }

  Container _buttonSelect(
    BuildContext context,
    int value,
    PostalCodeViewModel viewModel,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(40, 41, 61, 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color.fromRGBO(96, 97, 112, 0.24),
            blurRadius: 32,
            offset: Offset(0, 20),
          ),
        ],
      ),
      // ignore: no-empty-block
      child: CustomButton(
        label: 'Pilih',
        onPressed: () {
          callBack(viewModel.listPostalCode[value - 1]);
          Navigator.pop(context);
        },
        isBusy: false,
        color: value == 0 ? Colors.grey[350] : const Color(0xff027DEF),
      ),
    );
  }

// ignore: long-parameter-list
  InkWell _singleChildComponent(
    BuildContext context,
    int value,
    int groupValue,
    ValueChanged<dynamic> onChanged,
    PostalCodeModel postalCode,
  ) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: isSelected ? 2.0 : 1.0,
              color: isSelected
                  ? const Color(0xff38BAA7)
                  : const Color(0xffCDD3D8),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
            child: Row(
              children: [
                Column(
                  children: [
                    const Text(
                      'Kode POS',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(22, 43, 58, 0.4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      postalCode.postalCode!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff03213E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTitleAndSubtitle(
                        'Kode Kelurahan:',
                        postalCode.villageCode!,
                      ),
                      _buildTitleAndSubtitle('Kelurahan:', postalCode.village!),
                      _buildTitleAndSubtitle(
                        'Kecamatan:',
                        postalCode.district!,
                      ),
                      _buildTitleAndSubtitle('Kota:', postalCode.city!),
                      _buildTitleAndSubtitle('Provinsi:', postalCode.province!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildTitleAndSubtitle(
    String title,
    String subtitle, {
    Color color = const Color(0xff162B3A),
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff828896),
            ),
          ),
          Expanded(
            child: AutoSizeText(
              subtitle,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
