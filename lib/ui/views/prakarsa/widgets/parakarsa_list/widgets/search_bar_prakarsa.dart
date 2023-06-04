import 'package:flutter/material.dart';
import '../../../../../../application/helpers/responsive_helpers.dart';
import '../../../../../shared/custom_dropdown.dart';
import '../../../../../shared/custom_search_bar.dart';
import '../../../../../../application/app/constants/filter_constants.dart';

class SearchBarPrakarsa extends StatelessWidget {
  final double width;
  final String hintText;
  final Function(String val)? onSearch;
  final Function(String val)? onChangedLoanType;
  final Function(String val)? onChangedStatus;
  const SearchBarPrakarsa({
    Key? key,
    required this.width,
    required this.hintText,
    required this.onSearch,
    required this.onChangedLoanType,
    required this.onChangedStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _buildSearchBar(context, width),
        _buildDropDownFilter(
          ResponsiveHelpers.isMobile(context)
              ? (width - 48) / 2
              : (width / 5) * 1.2,
          loanTypeFilter,
          'Jenis Kredit',
          onChangedLoanType,
        ),
        _buildDropDownFilter(
          ResponsiveHelpers.isMobile(context)
              ? (width - 48) / 2
              : (width / 5) * 1.2,
          submissionStatusFilter,
          'Status Pengajuan',
          onChangedStatus,
        ),
      ],
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    double width,
  ) {
    return Container(
      width:
          ResponsiveHelpers.isMobile(context) ? width - 32 : (width / 5) * 1.75,
      height: 48,
      margin: const EdgeInsets.all(8),
      child: CustomSearchBar(
        hintText: hintText,
        onChanged: onSearch,
        onSubmitted: onSearch,
        isSearchActive: true,
      ),
    );
  }

  Widget _buildDropDownFilter(
    double width,
    List<String> listData,
    String hintText,
    Function? onChanged,
  ) {
    return Container(
      width: width,
      height: 48,
      margin: const EdgeInsets.all(8),
      child: CustomDropDown(
        listData: listData,
        hintText: hintText,
        selectedValue: TextEditingController(),
        onChanged: onChanged,
      ),
    );
  }
}
