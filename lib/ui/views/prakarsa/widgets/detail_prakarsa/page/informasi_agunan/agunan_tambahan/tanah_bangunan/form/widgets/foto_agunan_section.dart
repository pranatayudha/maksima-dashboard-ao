import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../../shared/dotted_upload_button.dart';
import '../../../../../../../../../../shared/styles.dart';
import '../../../../../lkn/widgets/open_preview_lkn.dart';
import '../../../widgets/dialog_pilih_agunan.dart/upload_foto_kunjungan.dart';
import '../form_agunan_tanah_bangunan_viewmodel.dart';

class FotoAgunanSection extends HookViewModelWidget<FormAgunanTanahBangunanViewModel> {
  final double width;
  const FotoAgunanSection({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return BaseFromLayout(
      title: 'Foto Agunan',
      subtitle: 'Foto langsung agunan debitur',
      rightSection: _buildFotoAgunan(viewModel),
    );
  }

  Widget _buildFotoAgunan(FormAgunanTanahBangunanViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foto Agunan Tambahan',
          style: tsCaption1,
        ),
        const SizedBox(
          height: 8,
        ),
        if (viewModel.fotoAgunanTambahanList.isNotEmpty)
          GridView.builder(
            itemCount: viewModel.fotoAgunanTambahanList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) => UploadFotoKunjungan(
              label: viewModel.fotoAgunanTambahanList[index].date ?? '-',
              subLabel: viewModel.fotoAgunanTambahanList[index].address ?? '-',
              docUrl: viewModel.fotoAgunanTambahanList[index].imageUrl,
              onTapClose: () => viewModel.clearAgunanTambahan(index),
              onTap: () => OpenPreviewLKN().openPreviewLKN(
                context: context,
                width: width,
                data: viewModel.fotoAgunanTambahanList[index],
              ),
            ),
          ),
        if (viewModel.fotoAgunanTambahanList.length < 5)
          Column(
            children: [
              InkWell(
                onTap: viewModel.onTapFotoAgunanTambahan,
                child: const DottedUploadButton(),
              ),
            ],
          ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Pastikan foto Agunan Debitur secara langsung',
          style: tsHeading11.copyWith(
            color: CustomColor.darkGrey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
