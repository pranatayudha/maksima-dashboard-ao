import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../../application/models/foto_kunjungan_model.dart';
import '../../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../../shared/dotted_border_button_icon.dart';
import '../../../../../../../../../../shared/styles.dart';
import '../../../../../lkn/widgets/open_preview_lkn.dart';
import '../form_agunan_persediaan_viewmodel.dart';
import 'foto_item.dart';

class FotoAgunanPersediaanSection
    extends HookViewModelWidget<FormAgunanPersediaanViewModel> {
  const FotoAgunanPersediaanSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormAgunanPersediaanViewModel viewModel,
  ) {
    return BaseFromLayout(
      title: 'Foto Agunan',
      subtitle: 'Upload minimal 1 foto agunan persediaan debitur',
      rightSection: _buildFotoAgunan(viewModel, context),
    );
  }

  Widget _buildFotoAgunan(
    FormAgunanPersediaanViewModel viewModel,
    BuildContext ctx,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foto Agunan Persediaan',
          style: tsCaption1,
        ),
        const SizedBox(height: 5),
        if (viewModel.listPathFotoPersediaanPublic.isNotEmpty)
          GridView.builder(
            itemCount: viewModel.listPathFotoPersediaanPublic.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) => FotoItem(
              label: viewModel.listLocationDateFotoPersediaan[index]!,
              subLabel: viewModel.listLocationNameFotoPersediaan[index],
              docUrl: viewModel.listPathFotoPersediaanPublic[index],
              onTapClose: () => viewModel.clearFotoAgunanPersediaan(index, 0),
              onTap: () => OpenPreviewLKN().openPreviewLKN(
                titleMain: 'Preview Foto Agunan',
                titleSecondary: 'Lokasi Foto Agunan',
                context: context,
                width: viewModel.width,
                data: FotoKunjunganModel(
                  imageUrl: viewModel.listPathFotoPersediaanPublic[index],
                  width: viewModel.width,
                  title: 'Foto Agunan Persediaan',
                  tagLocation: {
                    'name': viewModel.listLocationNameFotoPersediaan[index],
                    'latLng': viewModel.listLocationFotoPersediaan[index],
                  },
                  date: viewModel.listLocationDateFotoPersediaan[index],
                  address: viewModel.listLocationNameFotoPersediaan[index],
                  time: viewModel.listLocationTimeFotoPersediaan[index],
                ),
              ),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorderButtonIcon(
              labelButton: 'Tambah Foto',
              onTap: () => viewModel.uploadFotoAgunanPersediaan(ctx),
            ),
            const SizedBox(height: 5),
            Text(
              'Pastikan foto Agunan Debitur secara langsung',
              style: tsCaption1.copyWith(
                color: CustomColor.darkGrey,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
