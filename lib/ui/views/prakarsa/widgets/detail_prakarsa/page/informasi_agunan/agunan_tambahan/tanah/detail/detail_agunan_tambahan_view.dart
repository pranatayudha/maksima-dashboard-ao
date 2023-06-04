import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../../shared/loading_indicator.dart';
import '../../../../../widgets/warning_alert.dart';
import '../../penilaian/detail/detail_penilaian_view.dart';
import 'detail_agunan_tambahan_viewmodel.dart';
import 'widgets/detail_agunan_tambahan_tanah_data_pembanding_section.dart';
import 'widgets/detail_agunan_tambahan_tanah_info_umum_section.dart';

class DetailAgunanTambahanView
    extends ViewModelBuilderWidget<DetailAgunanTambahanViewModel> {
  final ListAgunanTambahanModel? dataAgunan;
  final String prakarsaId;
  final int codeTable;
  final Function(dynamic) selectedAgunan;

  const DetailAgunanTambahanView({
    super.key,
    required this.dataAgunan,
    required this.prakarsaId,
    required this.codeTable,
    required this.selectedAgunan,
  });

  @override
  void onViewModelReady(DetailAgunanTambahanViewModel viewModel) =>
      viewModel.initialize();

  @override
  DetailAgunanTambahanViewModel viewModelBuilder(BuildContext context) =>
      DetailAgunanTambahanViewModel(
        id: dataAgunan?.id ?? '',
        prakarsaId: prakarsaId,
        codeTable: codeTable,
        dataAgunan: dataAgunan,
      );

  @override
  // ignore: long-method
  Widget builder(
    BuildContext context,
    DetailAgunanTambahanViewModel viewModel,
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
                    child: Text(
                      'Agunan Tambahan #${viewModel.indexAgunan} - Tanah',
                      // 'Agunan Tambahan #1 - Tanah',
                      style: titleStyle16,
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => viewModel.deleteAgunanTambahan(
                          int.parse(
                            dataAgunan?.id ?? '',
                          ),
                        ),
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
        const WarningAlert(
          title: 'Seluruh data Agunan Pokok wajib dilengkapi',
          subtitle: 'Pastikan data yang diterima dari debitur lengkap',
        ),
        const SizedBox(
          height: 12,
        ),
        Flexible(
          child: DefaultTabController(
            length: viewModel.jenisPenilaian == 'Penilaian Internal' ? 3 : 2,
            child: TabBar(
              onTap: (index) => viewModel.onChangeIndex(index),
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
                    viewModel.getStatus(
                      viewModel.stepperAgunanTambahan?.data?.informasiUmum ?? 0,
                    ),
                    const Tab(
                      text: 'Informasi Umum Agunan',
                    ),
                  ],
                ),
                if (viewModel.jenisPenilaian == 'Penilaian Internal')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      viewModel.getStatus(
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
                    viewModel.getStatus(
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
        IndexedStack(
          index: viewModel.index,
          children: [
            DetailAgunanTambahanTanahInfoUmumSection(
              dataAgunan: dataAgunan,
              selectedAgunan: (data) {
                ListAgunanTambahanModel temp = data;
                temp.jenisPenilaian = viewModel.jenisPenilaian;
                selectedAgunan(temp);
              },
            ),
            if (viewModel.jenisPenilaian == 'Penilaian Internal')
              DetailAgunanTambahanTanahDataPembandingSection(
                dataAgunan: dataAgunan,
                selectedAgunan: (data) {
                  ListAgunanTambahanModel temp = data;
                  temp.jenisPenilaian = viewModel.jenisPenilaian;
                  selectedAgunan(temp);
                },
              ),
            if (viewModel.jenisPenilaian == 'Penilaian Internal')
              DetailPenilaianView(
                dataAgunan: viewModel.selectedDataAgunan,
                prakarsaId: prakarsaId,
                codeTable: codeTable,
                selectedAgunan: (data) {
                  ListAgunanTambahanModel temp = data;
                  temp.jenisPenilaian = viewModel.jenisPenilaian;
                  selectedAgunan(temp);
                },
              )
            else
              DetailPenilaianView(
                dataAgunan: dataAgunan,
                prakarsaId: prakarsaId,
                codeTable: codeTable,
                selectedAgunan: (data) {
                  ListAgunanTambahanModel temp = data;
                  temp.jenisPenilaian = viewModel.jenisPenilaian;
                  selectedAgunan(temp);
                },
              ),
          ],
        ),
      ],
    );
  }
}
