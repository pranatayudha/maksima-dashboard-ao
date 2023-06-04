import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/models/list_agunan_pokok_model.dart';
import '../../../../../widgets/base_view.dart';
import '../../../../../widgets/header_content.dart';
import '../../../../../widgets/warning_alert.dart';
import 'detail_agunan_persediaan_viewmodel.dart';
import 'widgets/detail_agunan_persediaan_section.dart';

class DetailAgunanPersediaanView
    extends ViewModelBuilderWidget<DetailAgunanPersediaanViewModel> {
  final ListAgunanModel? dataAgunan;
  final String prakarsaId;
  final int codeTable;
  final Function(dynamic) selectedAgunan;
  final double width;

  const DetailAgunanPersediaanView({
    super.key,
    required this.dataAgunan,
    required this.prakarsaId,
    required this.codeTable,
    required this.selectedAgunan,
    required this.width,
  });

  @override
  void onViewModelReady(DetailAgunanPersediaanViewModel viewModel) =>
      viewModel.initialize();

  @override
  DetailAgunanPersediaanViewModel viewModelBuilder(BuildContext context) =>
      DetailAgunanPersediaanViewModel(
        id: dataAgunan?.id ?? '',
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        width: width,
      );

  @override
  Widget builder(
    BuildContext context,
    DetailAgunanPersediaanViewModel viewModel,
    Widget? child,
  ) {
    return BaseView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: HeaderContent(
                  title:
                      'Agunan Pokok #${dataAgunan?.index} - ${viewModel.agunanType}',
                  onTap: () {
                    selectedAgunan(dataAgunan);
                    viewModel.navigateTo(
                      ConstantPageRoute.formAgunanPokok,
                    );
                  },
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      'Hapus Agunan',
                      style: valueStyle.copyWith(
                        color: CustomColor.primaryRed80,
                      ),
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 1) {
                    viewModel.validateDelete(
                      id: int.parse(
                        dataAgunan?.id ?? '',
                      ),
                    );
                  }
                },
                offset: const Offset(0, 50),
                child: Container(
                  height: 32,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    border: Border.all(
                      color: CustomColor.primaryBlue,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.more_vert,
                      color: CustomColor.primaryBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const WarningAlert(
            title: 'Seluruh data Agunan Pokok wajib dilengkapi',
            subtitle: 'Pastikan data yang diterima dari debitur lengkap',
          ),
          const SizedBox(
            height: 12,
          ),
          const DetailAgunanPersediaanSection(),
        ],
      ),
    );
  }
}
