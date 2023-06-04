import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/custom_button.dart';
import '../../../../../../../../../shared/custom_empty_state.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../../../../../../../../../shared/thick_light_grey_divider.dart';
import '../../../../../widgets/header_content.dart';
import 'detail_penilaian_viewmodel.dart';

class DetailPenilaianView
    extends ViewModelBuilderWidget<DetailPenilaianViewModel> {
  final ListAgunanTambahanModel? dataAgunan;
  final String prakarsaId;
  final int codeTable;
  final Function(dynamic) selectedAgunan;

  const DetailPenilaianView({
    super.key,
    required this.dataAgunan,
    required this.prakarsaId,
    required this.codeTable,
    required this.selectedAgunan,
  });

  @override
  void onViewModelReady(DetailPenilaianViewModel viewModel) =>
      viewModel.initialize();

  @override
  DetailPenilaianViewModel viewModelBuilder(BuildContext context) =>
      DetailPenilaianViewModel(
        id: dataAgunan?.id ?? '',
        prakarsaId: prakarsaId,
      );

  @override
  Widget builder(
    BuildContext context,
    DetailPenilaianViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.detailPenilaian != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: HeaderContent(
                      title: 'Penilaian Agunan',
                      onTap: () {
                        selectedAgunan(dataAgunan);
                        viewModel.navigateTo(
                          ConstantPageRoute.formPenilaian,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (dataAgunan?.jenisPenilaian == 'Penilaian Internal')
                BaseFromLayout(
                  title: 'Pengikatan',
                  subtitle: 'Metode penilaian Agunan',
                  rightSection: RowItemDetail(
                    listWidget: [
                      _buildSectionInternal(viewModel),
                    ],
                  ),
                ),
              if (viewModel.detailPenilaian!.jenisPenilaian ==
                  'Penilaian Internal')
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ThickLightGreyDivider(
                    verticalPadding: 0.0,
                  ),
                ),
              BaseFromLayout(
                title: 'Nilai Pasar Wajar (NPW)',
                rightSection: _buildNpw(viewModel),
              ),
              BaseFromLayout(
                title: 'Nilai Likuidasi (NL)',
                rightSection: _buildNl(viewModel),
              ),
              BaseFromLayout(
                title: 'Proyeksi Nilai Pasar Wajar (PNPW)',
                rightSection: _buildPnpw(viewModel),
              ),
              BaseFromLayout(
                title: 'Proyeksi Nilai Likuidasi (PNL)',
                rightSection: _buildPnl(viewModel),
              ),
              BaseFromLayout(
                title: 'Nilai Pengikatan',
                rightSection: _buildNilaiPengikatan(viewModel),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ThickLightGreyDivider(
                  verticalPadding: 0.0,
                ),
              ),
              BaseFromLayout(
                title: 'Hasil Analisa Agunan',
                subtitle: 'Asumsi agunan untuk Bank Raya',
                rightSection: _buildhasilAnalisaAgunan(viewModel),
              ),
            ],
          )
        : Column(
            children: [
              const CustomEmptyState(
                height: 200,
                title: 'Belum Ada Penilaian Agunan',
                subTitle: 'Buat penilaian agunan dari debitur',
                imageAsset: ImageConstants.emptyList,
              ),
              CustomButton(
                label: 'Tambah Agunan Pokok',
                onPressed: () {
                  selectedAgunan(dataAgunan);
                  viewModel.navigateTo(ConstantPageRoute.formPenilaian);
                },
                isBusy: false,
              ),
            ],
          );
  }

  Widget _buildSectionInternal(DetailPenilaianViewModel viewModel) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'Jenis Pengikatan',
        value: viewModel.detailPenilaian?.metodePendekatan ?? '-',
        valueTextStyle: titleStyle16,
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Judgement Harga Aset',
        value: viewModel.detailPenilaian?.judgementHargaAset ?? '-',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget _buildNpw(
    DetailPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'NPW',
        value: RupiahFormatter.format(viewModel.detailPenilaian?.nPW ?? '0'),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio NPW',
        value: '${viewModel.detailPenilaian?.coverageRatioNPW ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget _buildNl(
    DetailPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'NL',
        value: RupiahFormatter.format(viewModel.detailPenilaian?.nL ?? '0'),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio NL',
        value: '${viewModel.detailPenilaian?.coverageRatioNL ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget _buildPnpw(
    DetailPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'PNPW',
        value: RupiahFormatter.format(viewModel.detailPenilaian?.pNPW ?? '0'),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio PNPW',
        value: '${viewModel.detailPenilaian?.coverageRatioPNPW ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget _buildPnl(
    DetailPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'PNL',
        value: RupiahFormatter.format(viewModel.detailPenilaian?.pNL ?? '0'),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio PNL',
        value: '${viewModel.detailPenilaian?.coverageRatioPNL ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget _buildNilaiPengikatan(
    DetailPenilaianViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'Nilai Pengikatan',
        value: (viewModel.detailPenilaian?.nilaiPengikatan?.isNotEmpty ?? false)
            ? RupiahFormatter.format(
                viewModel.detailPenilaian?.nilaiPengikatan ?? '0',
              )
            : '-',
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Nilai Pengikatan',
        value:
            '${viewModel.detailPenilaian?.coverageRatioNilaiPengikatan ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget _buildhasilAnalisaAgunan(
    DetailPenilaianViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailPrakarsaItem(
            title: 'Hal - Hal Yang Perlu Diketahui Bank',
            value: viewModel.detailPenilaian?.thingsBanksNeedToKnow ?? '-',
          ),
          const SizedBox(
            height: 20,
          ),
          DetailPrakarsaItem(
            title: 'Analisa Agunan Tambahan',
            value: viewModel.detailPenilaian?.analisaAgunanTambahan ?? '-',
          ),
        ],
      ),
    );
  }
}
