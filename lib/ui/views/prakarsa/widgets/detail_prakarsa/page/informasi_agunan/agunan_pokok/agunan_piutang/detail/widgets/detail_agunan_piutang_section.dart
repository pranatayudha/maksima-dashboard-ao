import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../../application/services/url_launcher_service.dart';
import '../../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../../shared/row_item_detail.dart';
import '../../../../../../../../../../shared/thick_light_grey_divider.dart';
import '../../../widgets/upload_document_agunan.dart';
import '../detail_agunan_piutang_viewmodel.dart';

class DetailAgunanPiutangSection
    extends HookViewModelWidget<DetailAgunanPiutangViewModel> {
  const DetailAgunanPiutangSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailAgunanPiutangViewModel viewModel,
  ) {
    return Column(
      children: [
        BaseFromLayout(
          title: 'Jenis Agunan',
          subtitle: 'Piutang / Persediaan',
          rightSection: DetailPrakarsaItem(
            title: 'Jenis Agunan Pokok',
            value: viewModel.agunanType,
          ),
        ),
        BaseFromLayout(
          rightSection: RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Nominal Piutang',
                value: (viewModel.detailAgunanPokok?.nPW?.isNotEmpty ?? false)
                    ? RupiahFormatter.format(
                        viewModel.detailAgunanPokok?.nPW,
                      )
                    : '-',
                valueTextStyle: titleStyle16,
              ),
              DetailPrakarsaItem(
                title: 'Posisi Periode Laporan Keuangan',
                value: viewModel.calculationAgunan?.period ?? '-',
                valueTextStyle: titleStyle16,
              ),
            ],
          ),
        ),
        BaseFromLayout(
          rightSection: UploadDocumentAgunan(
            docUrl: viewModel.agunanPublicUrl,
            label: 'Rincian Piutang a.n Debitur',
            onTapLihat: () => locator<URLLauncherService>().browse(
              viewModel.agunanPublicUrl!,
            ),
            isLoading: false,
            isEditable: false,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: ThickLightGreyDivider(
            verticalPadding: 0.0,
          ),
        ),
        BaseFromLayout(
          title: 'Pengikatan',
          rightSection: RowItemDetail(
            listWidget: [
              buildJenisPengikatan(viewModel),
            ],
          ),
        ),
        BaseFromLayout(
          title: 'Nilai Pasar Wajar (NPW)',
          rightSection: buildNpw(viewModel),
        ),
        BaseFromLayout(
          title: 'Nilai Likuidasi (NL)',
          rightSection: buildNl(viewModel),
        ),
        BaseFromLayout(
          title: 'Proyeksi Nilai Pasar Wajar (PNPW)',
          rightSection: buildPnpw(viewModel),
        ),
        BaseFromLayout(
          title: 'Proyeksi Nilai Likuidasi (PNL)',
          rightSection: buildPnl(viewModel),
        ),
        BaseFromLayout(
          title: 'Nilai Pengikatan',
          rightSection: buildNilaiPengikatan(viewModel),
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
          rightSection: buildhasilAnalisaAgunan(viewModel),
        ),
      ],
    );
  }

  Widget buildJenisPengikatan(
    DetailAgunanPiutangViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: DetailPrakarsaItem(
        title: 'Jenis Pengikatan',
        value: viewModel.detailAgunanPokok?.jenisPengikatan ?? '-',
      ),
    );
  }

  Widget buildNpw(
    DetailAgunanPiutangViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'NPW',
        value: RupiahFormatter.format(viewModel.detailAgunanPokok?.nPW ?? '0'),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio NPW',
        value: '${viewModel.detailAgunanPokok?.rasio?.coverageNpw ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildNl(
    DetailAgunanPiutangViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'NL',
        value: RupiahFormatter.format(viewModel.detailAgunanPokok?.nL ?? '0'),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio NL',
        value: '${viewModel.detailAgunanPokok?.rasio?.coverageNl ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildPnpw(
    DetailAgunanPiutangViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'PNPW',
        value: RupiahFormatter.format(viewModel.detailAgunanPokok?.pNPW ?? '0'),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio PNPW',
        value: '${viewModel.detailAgunanPokok?.rasio?.coverangePnPw ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildPnl(
    DetailAgunanPiutangViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'PNL',
        value: RupiahFormatter.format(viewModel.detailAgunanPokok?.pNL ?? '0'),
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Ratio PNL',
        value: '${viewModel.detailAgunanPokok?.rasio?.coveragePnl ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildNilaiPengikatan(
    DetailAgunanPiutangViewModel viewModel,
  ) {
    return BaseFormSection(
      leftSection: DetailPrakarsaItem(
        title: 'Nilai Pengikatan',
        value:
            (viewModel.detailAgunanPokok?.nilaiPengikatan?.isNotEmpty ?? false)
                ? RupiahFormatter.format(
                    viewModel.detailAgunanPokok?.nilaiPengikatan ?? '0',
                  )
                : '-',
      ),
      rightSection: DetailPrakarsaItem(
        title: 'Coverage Nilai Pengikatan',
        value:
            '${viewModel.detailAgunanPokok?.rasio?.coverageNilaiPengikat ?? '-'} %',
        valueTextStyle: titleStyle16,
      ),
      isLast: true,
    );
  }

  Widget buildhasilAnalisaAgunan(
    DetailAgunanPiutangViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 20),
      child: DetailPrakarsaItem(
        title: 'Analisa Agunan Pokok',
        value: viewModel.detailAgunanPokok?.analisapokok ?? '-',
      ),
    );
  }
}
