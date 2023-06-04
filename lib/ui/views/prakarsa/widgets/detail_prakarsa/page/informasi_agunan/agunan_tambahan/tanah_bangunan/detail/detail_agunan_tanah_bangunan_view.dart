import 'package:flutter/material.dart';
import 'package:pinang_maksima_dashboard_ao/ui/views/prakarsa/widgets/detail_prakarsa/page/informasi_agunan/agunan_tambahan/tanah_bangunan/detail/widgets/detail_agunan_tambahan_tanah_data_pembanding_section.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../../shared/loading_indicator.dart';
import '../../../../../widgets/header_content.dart';
import 'detail_agunan_tanah_bangunan_viewmodel.dart';
import 'widgets/detail_agunan_tanah_bangunan_section.dart';

class DetailAgunanTanahBangunanView
    extends ViewModelBuilderWidget<DetailAgunanTanahBangunanViewModel> {
  final ListAgunanTambahanModel? dataAgunan;
  final String prakarsaId;
  final int codeTable;
  final Function(dynamic) selectedAgunan;

  const DetailAgunanTanahBangunanView({
    super.key,
    required this.dataAgunan,
    required this.prakarsaId,
    required this.codeTable,
    required this.selectedAgunan,
  });

  @override
  void onViewModelReady(DetailAgunanTanahBangunanViewModel viewModel) =>
      viewModel.initialize();

  @override
  DetailAgunanTanahBangunanViewModel viewModelBuilder(BuildContext context) =>
      DetailAgunanTanahBangunanViewModel(
        id: dataAgunan?.id ?? '',
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        dataAgunan: dataAgunan,
      );

  @override
  Widget builder(
    BuildContext context,
    DetailAgunanTanahBangunanViewModel viewModel,
    Widget? child,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        viewModel.isBusy
            ? const LoadingIndicator()
            : Row(
                children: [
                  Expanded(
                    child: HeaderContent(
                      title:
                          'Agunan Tambahan #${dataAgunan?.index ?? ''} - ${dataAgunan?.codeTable}',
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          'Hapus Agunan',
                          style: valueStyle.copyWith(
                            color: CustomColor.primaryRed80,
                          ),
                        ),
                      ),
                    ],
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
        const SizedBox(
          height: 24,
        ),
        Flexible(
          child: DefaultTabController(
            length: 3,
            child: TabBar(
              onTap: viewModel.onChangeIndex,
              labelColor: Colors.black,
              indicatorColor: CustomColor.primaryBlue,
              labelStyle: titleStyle14,
              unselectedLabelStyle: normalStyle.copyWith(
                color: CustomColor.darkGrey,
              ),
              unselectedLabelColor: CustomColor.darkGrey,
              tabs: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getStatus(
                      viewModel.stepperAgunanTambahan?.data?.informasiUmum ?? 0,
                    ),
                    const Tab(
                      text: 'Informasi Umum Agunan',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getStatus(
                      viewModel.stepperAgunanTambahan?.data?.pembanding ?? 0,
                    ),
                    const Tab(
                      text: 'Data Pembanding',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getStatus(
                      viewModel.stepperAgunanTambahan?.data?.penilaian ?? 0,
                    ),
                    const Tab(
                      text: 'Penilaian',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        viewModel.isBusy
            ? const LoadingIndicator()
            : IndexedStack(
                index: viewModel.index,
                children: [
                  const DetailAgunanTanahBangunanSection(),
                  DetailAgunanTanahBangunanDataPembandingSection(
                    dataAgunan: dataAgunan,
                    selectedAgunan: (data) {
                      ListAgunanTambahanModel temp = data;
                      temp.jenisPenilaian = viewModel.jenisPenilaian;
                      selectedAgunan(temp);
                    },
                  ),
                  const Text('Penilaian'),
                ],
              ),
      ],
    );
  }

  Widget _getStatus(int status) {
    if (status > 0) {
      return Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color:
              status == 2 ? CustomColor.stateSuccess : CustomColor.warningText,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Image.asset(
          status == 2 ? IconConstants.iconChecked : IconConstants.iconWarning,
          height: 16,
        ),
      );
    }

    return Container(
      height: 16,
      width: 16,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        border: Border.all(color: CustomColor.darkGrey),
      ),
    );
  }
}
