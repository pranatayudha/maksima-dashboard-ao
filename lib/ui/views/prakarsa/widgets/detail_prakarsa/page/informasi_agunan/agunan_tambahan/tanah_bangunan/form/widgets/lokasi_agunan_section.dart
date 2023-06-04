import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../../shared/location/open_maps.dart';
import '../../../../../../../../../../shared/postal_code/widgets/open_postal_code.dart';
import '../../../../../../../../../../shared/styles.dart';
import '../form_agunan_tanah_bangunan_viewmodel.dart';

class LokasiAgunanSection extends HookViewModelWidget<FormAgunanTanahBangunanViewModel> {
  final double width;
  const LokasiAgunanSection({
    super.key,
    required this.width,
  });

  @override
  Widget buildViewModelWidget(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return BaseFromLayout(
      title: 'Lokasi Agunan',
      subtitle: 'Tag Lokasi dan Alamat Agunan Debitur',
      rightSection: _buildLokasiAgunan(context, viewModel),
    );
  }

  Widget _buildLokasiAgunan(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: Checkbox(
                      activeColor: CustomColor.orange,
                      value: viewModel.isNotIMBReady,
                      onChanged: viewModel.onChangedNotIMBReady,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Debitur belum mengurus Izin Membangun Bangunan',
                    style: tsHeading13,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              CustomTextField(
                label: viewModel.isNotIMBReady ? 'No. Resi Izin Membangun Bangunan' : 'No. Izin Membangun Bangunan',
                textEditingController: viewModel.noImbController,
                enabled: true,
                hintText: viewModel.isNotIMBReady
                    ? 'Masukkan No. Resi Izin Membangun Bangunan'
                    : 'Masukkan No. Izin Membangun Bangunan',
                fillColor: Colors.white,
                validator: (value) => InputValidators.validateRequiredField(
                  value,
                  fieldType:
                      viewModel.isNotIMBReady ? 'No. Resi Izin Membangun Bangunan' : 'No. Izin Membangun Bangunan',
                ),
              ),
              CustomTextField(
                label: 'Tag Location Tanah',
                hintText: 'Tag Location',
                textEditingController: viewModel.tagLocationController,
                enabled: true,
                fillColor: Colors.white,
                withSuffixIcon: true,
                suffixIconImagePath: IconConstants.location,
                onTap: () => OpenMaps().openGetTagLoc(
                  context: context,
                  width: width,
                  addressInfo: (data) => viewModel.setTagLocationTanah(data),
                ),
                validator: (value) => InputValidators.validateRequiredField(
                  value,
                  fieldType: 'Tag Location Tanah',
                ),
              ),
              CustomTextField(
                label: 'Alamat Sesuai Sertifikat',
                hintText: 'Masukkan Alamat Sesuai Sertifikat',
                textEditingController: viewModel.alamatController,
                enabled: true,
                minLines: 2,
                verticalContentPadding: 16,
                fillColor: Colors.white,
                validator: (value) => InputValidators.validateRequiredField(
                  value,
                  fieldType: 'Alamat Sesuai Sertifikat',
                ),
              ),
              CustomTextField(
                label: 'Kode Pos',
                hintText: 'Cari Kodepos',
                textEditingController: viewModel.kodePosController,
                enabled: true,
                fillColor: Colors.white,
                withSuffixIcon: true,
                suffixIconImagePath: IconConstants.searchBlack,
                onTap: () => OpenPostalCode().openDialog(
                  context: context,
                  width: MediaQuery.of(context).size.width,
                  data: (data) => viewModel.setKodePos(data),
                ),
                validator: (value) => InputValidators.validateRequiredField(
                  value,
                  fieldType: 'Kode Pos',
                ),
              ),
            ],
          ),
        ),
        BaseFormSection(
          leftSection: CustomTextField(
            label: 'RT',
            hintText: 'cth. 005',
            textEditingController: viewModel.rtController,
            enabled: true,
            fillColor: Colors.white,
            validator: (value) => InputValidators.validateRTRW(
              value,
              fieldType: 'RT',
            ),
          ),
          rightSection: CustomTextField(
            label: 'RW',
            hintText: 'cth. 003',
            textEditingController: viewModel.rwController,
            enabled: true,
            fillColor: Colors.white,
            validator: (value) => InputValidators.validateRTRW(
              value,
              fieldType: 'RW',
            ),
          ),
          isLast: true,
        ),
      ],
    );
  }
}
