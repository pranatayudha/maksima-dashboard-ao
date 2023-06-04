import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../shared/custom_button.dart';
import 'content_dialog_agunan_viewmodel.dart';

class ContentDialogAgunanView
    extends ViewModelBuilderWidget<ContentDialogAgunanViewModel> {
  final Function(String) callBack;
  const ContentDialogAgunanView({
    super.key,
    required this.callBack,
  });

  @override
  ContentDialogAgunanViewModel viewModelBuilder(BuildContext context) =>
      ContentDialogAgunanViewModel();

  @override
  Widget builder(
    BuildContext context,
    ContentDialogAgunanViewModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Pilih Agunan Tambahan',
                      style: titleStyle20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(IconConstants.x, height: 14),
                ),
              ],
            ),
          ),
          ...List.generate(
            viewModel.listAgunanTambahanFilter.length,
            (index) => InkWell(
              onTap: viewModel.listAgunanTambahanFilter[index].status
                  ? () => viewModel.setAgunanTambahan(
                        viewModel.listAgunanTambahanFilter[index].value,
                      )
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio<String>(
                    value: viewModel.listAgunanTambahanFilter[index].value,
                    groupValue: viewModel.selectedAgunanTambahan,
                    onChanged: viewModel.listAgunanTambahanFilter[index].status
                        ? (flag) {
                            viewModel.setAgunanTambahan(
                              flag ?? '',
                            );
                          }
                        : null,
                  ),
                  Text(
                    '${viewModel.listAgunanTambahanFilter[index].value} ${viewModel.listAgunanTambahanFilter[index].status ? '' : '(Coming Soon)'}',
                    style: viewModel.listAgunanTambahanFilter[index].status
                        ? normalStyle
                        : normalStyle.copyWith(
                            color: CustomColor.lightGrey30,
                          ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomButton(
              label: 'Pilih',
              onPressed: () {
                callBack(viewModel.selectedAgunanTambahan);
                Navigator.pop(context);
              },
              isBusy: false,
              color: viewModel.selectedAgunanTambahan == ''
                  ? Colors.grey[350]
                  : const Color(0xff027DEF),
            ),
          ),
        ],
      ),
    );
  }
}
