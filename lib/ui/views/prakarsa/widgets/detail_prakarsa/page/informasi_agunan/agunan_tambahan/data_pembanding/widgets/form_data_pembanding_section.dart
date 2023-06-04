import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../../application/models/foto_kunjungan_model.dart';
import '../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_detail_prakarsa.dart';
import '../../../../../../../../../shared/custom_dropdown.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../shared/dotted_upload_button.dart';
import '../../../../../../../../../shared/styles.dart';
import '../../../../../../../../../shared/upload_file.dart';
import '../../../../lkn/widgets/open_preview_lkn.dart';
import '../../widgets/dialog_pilih_agunan.dart/upload_foto_kunjungan.dart';
import '../form_data_pembanding_viewmodel.dart';

class FormDataPembandingSection
    extends HookViewModelWidget<FormDataPembandingViewModel> {
  final int index;

  const FormDataPembandingSection({
    super.key,
    required this.index,
  });

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormDataPembandingViewModel viewModel,
  ) {
    return BaseFromLayout(
      title: 'Data Pembanding ${index + 1}',
      subtitle: 'Foto langsung / internet',
      rightSection: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index > 0)
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => viewModel.deleteDataPembanding(index),
                      child: const Text(
                        'Hapus',
                        style: tsBody4SecondaryBlue,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Sumber Data',
                  style: tsCaption1,
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomDropDown(
                  listData: viewModel.listSumberData,
                  hintText: 'Pilih Sumber Data',
                  selectedValue: viewModel.listValue[index],
                  onChanged: (val) => viewModel.updateSumberData(val, index),
                ),
              ],
            ),
          ),
          if (viewModel.listValue[index].text == 'Foto Langsung')
            _buildFotoPembanding(viewModel, context)
          else if (viewModel.listValue[index].text == 'Internet') ...[
            _buildDocPembanding(viewModel, context),
            _buildLinkInternet(viewModel),
          ],
          _buildDataAsset(viewModel),
        ],
      ),
    );
  }

  Widget _buildFotoPembanding(
    FormDataPembandingViewModel viewModel,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Foto Data Pembanding',
            style: tsCaption1,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        if ((viewModel.listDataPembanding[index].pathFoto?.isNotEmpty ?? false))
          GridView.builder(
            itemCount: viewModel.listDataPembanding[index].pathFoto?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, i) => UploadFotoKunjungan(
              label:
                  viewModel.listDataPembanding[index].pathFoto?[i].photoName ??
                      '-',
              subLabel: viewModel.listDataPembanding[index].pathFoto?[i]
                      .tagLocation?.name ??
                  '-',
              docUrl: viewModel.urlPembandingPublic[index][i],
              onTapClose: () => viewModel.clearFotoPembanding(index, i),
              onTap: () => OpenPreviewLKN().openPreviewLKN(
                titleMain: 'Preview Foto Pembanding',
                context: context,
                width: viewModel.width,
                data: FotoKunjunganModel(
                  imageUrl: viewModel.urlPembandingPublic[index][i],
                  address: viewModel
                      .listDataPembanding[index].pathFoto?[i].tagLocation?.name,
                  date: viewModel
                      .listDataPembanding[index].pathFoto?[i].photoName,
                  tagLocation: {
                    'latLng': viewModel.listDataPembanding[index].pathFoto?[i]
                            .tagLocation?.latLng ??
                        '',
                    'name': viewModel.listDataPembanding[index].pathFoto?[i]
                            .tagLocation?.name ??
                        '',
                  },
                ),
              ),
            ),
          ),
        if ((viewModel.listDataPembanding[index].pathFoto?.length ?? 0) < 5)
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => viewModel.uploadFotoPembanding(context, index),
                  child: const DottedUploadButton(),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Pastikan foto Agunan Debitur secara langsung',
                  style: tsHeading11.copyWith(
                    color: CustomColor.darkGrey,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDocPembanding(
    FormDataPembandingViewModel viewModel,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Dokumen Pembanding',
            style: tsCaption1,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        if ((viewModel.listDataPembanding[index].pathDokumenPembanding ?? [])
            .isNotEmpty)
          GridView.builder(
            itemCount: viewModel
                .listDataPembanding[index].pathDokumenPembanding?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, i) => UploadFile(
              label: viewModel.listDataPembanding[index]
                      .pathDokumenPembanding?[i].photoName ??
                  '-',
              isLoading: false,
              imageUrl: viewModel.urlPembandingPublic[index][i],
              onTap: () => viewModel.clearFotoPembanding(index, i),
            ),
          ),
        if ((viewModel
                    .listDataPembanding[index].pathDokumenPembanding?.length ??
                0) <
            5)
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => viewModel.uploadFotoPembanding(context, index),
                  child: const DottedUploadButton(),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Format file PNG, JPG atau PDF (max 25 MB)',
                  style: tsHeading11.copyWith(
                    color: CustomColor.darkGrey,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLinkInternet(FormDataPembandingViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: CustomTextField(
        label: 'Link Internet',
        enabled: true,
        fillColor: Colors.white,
        textEditingController: viewModel.linkInternetController[index],
        validator: (value) => InputValidators.validateRequiredField(value),
        onChanged: (val) => viewModel.updateLinkInternet(index),
      ),
    );
  }

  Widget _buildDataAsset(FormDataPembandingViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'No. HP Pemilik / Agen',
            enabled: true,
            fillColor: Colors.white,
            prefixText: '+62',
            textEditingController: viewModel.noHpPemilikController[index],
            validator: (value) => InputValidators.validateMobileNumber(value),
            onChanged: (val) => viewModel.updateNoHp(index),
          ),
          rightSection: CustomTextField(
            label: 'Harga Aset Pembanding',
            enabled: true,
            fillColor: Colors.white,
            withPrefixIcon: true,
            prefixIconImagePath: IconConstants.rupiah,
            withThousandsSeparator: true,
            textEditingController: viewModel.hargaAssetController[index],
            validator: (value) => InputValidators.validateRequiredField(value),
            onChanged: (val) => viewModel.updateHargaAsset(index),
          ),
          isLast: true,
        ),
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'Luas Aset Pembanding',
            enabled: true,
            fillColor: Colors.white,
            withSuffixIcon: true,
            suffixIconImagePath: IconConstants.meter,
            withThousandsSeparator: true,
            textEditingController:
                viewModel.luasAssetPembandingController[index],
            validator: (value) => InputValidators.validateRequiredField(value),
            onChanged: (val) => viewModel.updateLuasAsset(index),
          ),
          rightSection: CustomDetailPrakarsa(
            title: 'Harga Tanah / m2',
            value: viewModel.hargaTanahController[index],
            prefixPath: IconConstants.rupiah,
          ),
          isLast: true,
        ),
      ],
    );
  }
}
