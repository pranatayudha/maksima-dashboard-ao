import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../application/models/foto_kunjungan_model.dart';
import '../../../../../../../../shared/dotted_border_button_icon.dart';
import '../../../../../../../../shared/foto_kunjungan_item.dart';
import '../../../../../../../../shared/thick_light_grey_divider.dart';
import '../../widgets/open_preview_lkn.dart';
import '../form_lkn_viewmodel.dart';

class LKNUploadSection extends HookViewModelWidget<FormLKNViewModel> {
  final double width;
  const LKNUploadSection({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormLKNViewModel viewModel,
  ) {
    return Responsive(
      children: [
        Div(
          divison: const Division(
            colS: 12,
            colM: 12,
            colL: 12,
            colXL: 12,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Upload Foto Kunjungan',
              style: titleStyle20,
            ),
          ),
        ),
        Div(
          divison: const Division(
            colS: 12,
            colM: 12,
            colL: 12,
            colXL: 12,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              children: [
                if (viewModel.detailLKN!.dataLkn!.visitPath!.isNotEmpty)
                  Column(
                    children: List.generate(
                      viewModel.fotoKunjunganPublicURL.length,
                      (i) => FotoKunjunganItem(
                        onTap: (data) => OpenPreviewLKN().openPreviewLKN(
                          context: context,
                          width: width,
                          data: data,
                        ),
                        data: FotoKunjunganModel(
                          imageUrl: viewModel.fotoKunjunganPublicURL[i],
                          width: width,
                          title: 'Lokasi Foto Kunjungan',
                          tagLocation: {
                            'name': viewModel.detailLKN!.dataLkn!.visitPath![i]
                                .meta!.locationDetail!.name,
                            'latLng': viewModel.detailLKN!.dataLkn!
                                .visitPath![i].meta!.locationDetail!.latLng!,
                          },
                          date: viewModel.detailLKN!.dataLkn!.visitPath![i]
                              .meta!.photoName!,
                          address: viewModel.detailLKN!.dataLkn!.visitPath![i]
                              .meta!.locationDetail!.name,
                          time: viewModel.detailLKN!.dataLkn!.visitPath![i]
                              .meta!.timeName!,
                        ),
                      ),
                    ),
                  ),
                if (viewModel.detailLKN!.dataLkn!.visitPath!.length != 5)
                  DottedBorderButtonIcon(
                    label: 'Foto Kunjungan *',
                    labelButton: 'Upload Foto',
                    onTap: () => locator<DialogService>().showCustomDialog(
                      variant: DialogType.baseImage,
                      data: {
                        'imageAsset': ImageConstants.failedVerification,
                        'color': CustomColor.secondaryBlue,
                      },
                      title:
                          'Foto LKN hanya bisa diakses melalui aplikasi mobile',
                      description:
                          'Pastikan foto usaha langsung di lokasi debitur menggunakan aplikasi mobile',
                      mainButtonTitle: 'Sip, mengerti',
                    ),
                  ),
              ],
            ),
          ),
        ),
        const ThickLightGreyDivider(
          verticalPadding: 14.0,
        ),
      ],
    );
  }
}
