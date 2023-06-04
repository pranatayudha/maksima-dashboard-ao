import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../../application/helpers/input_validators.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_textfield.dart';
import '../../../../../../../../../shared/postal_code/widgets/open_postal_code.dart';
import '../../../../../../../../../shared/thick_light_grey_divider.dart';
import '../form_info_usaha_viewmodel.dart';

class FormInfoUsahaSection extends HookViewModelWidget<FormInfoUsahaViewModel> {
  final double width;
  const FormInfoUsahaSection({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  // ignore: long-method
  Widget buildViewModelWidget(
    BuildContext context,
    FormInfoUsahaViewModel viewModel,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            _buildBusinessName(viewModel),
            BaseFormSection(
              leftSection: _buildEconomySectorName(viewModel),
              rightSection: _buildSubEconomySectorName(viewModel),
              isLast: true,
            ),
            _buildTagLocUsaha(width, context, viewModel),
            _buildAddress(viewModel),
            _buildPostalCode(context, viewModel, constraints.maxWidth),
            BaseFormSection(
              leftSection: _buildProvince(viewModel),
              rightSection: _buildCity(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildDistrict(viewModel),
              rightSection: _buildVillage(viewModel),
              isLast: true,
            ),
            BaseFormSection(
              leftSection: _buildRT(viewModel),
              rightSection: _buildRW(viewModel),
              isLast: true,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 14.0),
              child: ThickLightGreyDivider(
                verticalPadding: 0.0,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBusinessName(
    FormInfoUsahaViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.businessNameController,
        label: 'Nama Usaha *',
        enabled: false,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  CustomTextField _buildEconomySectorName(
    FormInfoUsahaViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.economySectorNameController,
      label: 'Sektor Ekonomi *',
      enabled: false,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildSubEconomySectorName(
    FormInfoUsahaViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.subEconomySectorNameController,
      label: 'Sub Sektor Ekonomi *',
      enabled: false,
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      fillColor: Colors.grey.shade100,
    );
  }

  Widget _buildTagLocUsaha(
    double width,
    BuildContext context,
    FormInfoUsahaViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.tagLocationNameController,
        label: 'Tag Location Alamat Usaha *',
        enabled: false,
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.location,
        fillColor: Colors.grey.shade100,
        // onTap: () => OpenMaps().openGetTagLoc(
        //   context: context,
        //   width: width,
        //   addressInfo: (data) => viewModel.updateTagloc(data),
        // ),
      ),
    );
  }

  Widget _buildAddress(
    FormInfoUsahaViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.addressController,
        label: 'Alamat Usaha *',
        enabled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildPostalCode(
    BuildContext context,
    FormInfoUsahaViewModel viewModel,
    double maxWidth,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        textEditingController: viewModel.postalCodeController,
        label: 'Kode Pos *',
        enabled: false,
        withSuffixIcon: true,
        suffixIconImagePath: IconConstants.searchBlack,
        fillColor: Colors.white,
        onTap: () => OpenPostalCode().openDialog(
          context: context,
          width: maxWidth,
          data: (data) => viewModel.updatePostalCode(data),
        ),
      ),
    );
  }

  CustomTextField _buildProvince(
    FormInfoUsahaViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.provinceController,
      label: 'Provinsi *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildCity(
    FormInfoUsahaViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.cityController,
      label: 'Kota *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildDistrict(
    FormInfoUsahaViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.districController,
      label: 'Kecamatan *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildVillage(
    FormInfoUsahaViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.villageController,
      label: 'Kelurahan *',
      withSuffixIcon: true,
      suffixIconImagePath: IconConstants.chevronDown,
      enabled: false,
      fillColor: Colors.grey.shade100,
    );
  }

  CustomTextField _buildRT(
    FormInfoUsahaViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.rtController,
      label: 'RT *',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) =>
          InputValidators.validateRTRW(value, fieldType: 'RT'),
    );
  }

  CustomTextField _buildRW(
    FormInfoUsahaViewModel viewModel,
  ) {
    return CustomTextField(
      textEditingController: viewModel.rwController,
      label: 'RW *',
      enabled: true,
      fillColor: Colors.white,
      validator: (value) =>
          InputValidators.validateRTRW(value, fieldType: 'RW'),
    );
  }
}
