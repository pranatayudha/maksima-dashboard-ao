import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/foto_item.dart';
import '../../../../../../../../../shared/not_exist_photo.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../detail_legalitas_viewmodel.dart';

class AktaPendirianSection
    extends HookViewModelWidget<DetailLegalitasViewModel> {
  const AktaPendirianSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailLegalitasViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Akta Pendirian',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. Akta Pendirian',
                value: viewModel.legalitas!.deedEstNum != null
                    ? viewModel.legalitas!.deedEstNum!
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal Akta Pendirian',
                value: viewModel.legalitas!.dateOfDeedEst != null
                    ? DateStringFormatter.forOutputRitel(
                        viewModel.legalitas!.dateOfDeedEst!,
                      )
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Tempat Akta Pendirian',
                value: viewModel.legalitas!.placeOfDeedEst != null
                    ? viewModel.legalitas!.placeOfDeedEst!
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Nama Notaris',
                value: viewModel.legalitas!.notaryName != null
                    ? viewModel.legalitas!.notaryName!
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Tempat Kedudukan Notaris',
                value: viewModel.legalitas!.notaryPosition != null
                    ? viewModel.legalitas!.notaryPosition!
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. SK Kumham Pendirian',
                value: viewModel.legalitas!.skKumhamNum != null
                    ? viewModel.legalitas!.skKumhamNum != ''
                        ? viewModel.legalitas!.skKumhamNum!
                        : '-'
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal SK Kumham Pendirian',
                value: viewModel.legalitas!.dateOfSkKumham != null
                    ? DateStringFormatter.forOutputRitel(
                        viewModel.legalitas!.dateOfSkKumham!,
                      )
                    : '-',
              ),
            ],
          ),
          Text(
            'Dokumen',
            style: titleStyle16,
          ),
          RowItemDetail(
            listWidget: [
              _aktaPendirianDoc(viewModel),
              _skKumhamPendirianDoc(viewModel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aktaPendirianDoc(DetailLegalitasViewModel vm) {
    return vm.legalitas!.deedEstPath == null || vm.deedEstPath.isEmpty
        ? const NotExistPhoto(desc: 'Belum ada dokumen Akta Pendirian')
        : FotoItem('Akta Pendirian', vm.deedEstPath);
  }

  Widget _skKumhamPendirianDoc(DetailLegalitasViewModel vm) {
    return vm.legalitas!.skKumhamPath == null ||
            vm.skKumhamPendirianPath.isEmpty
        ? const NotExistPhoto(desc: 'Belum ada dokumen SK Kumham Pendirian')
        : FotoItem('SK Kumham Pendirian', vm.skKumhamPendirianPath);
  }
}
