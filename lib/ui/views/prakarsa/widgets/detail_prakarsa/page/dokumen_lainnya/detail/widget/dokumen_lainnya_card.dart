import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../shared/foto_item.dart';
import '../../../../../../../../shared/not_exist_photo.dart';
import '../../../../../../../../shared/row_item_detail.dart';
import '../detail_dokumen_lainnya_viewmodel.dart';

class DokumenLainnyaCard
    extends HookViewModelWidget<DetailDokumenLainnyaViewModel> {
  final int index;
  const DokumenLainnyaCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailDokumenLainnyaViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Dokumen ${index + 1}',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Jenis Dokumen',
                value: (viewModel.dokumenLainnyaMap[index]['label'] ?? '')
                    .toUpperCase(),
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. Dokumen',
                value: viewModel.dokumenLainnya![index].docNum ?? '',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal Terbit',
                value: viewModel.dokumenLainnya![index].dateOfDocument != null
                    ? viewModel.dokumenLainnya![index].dateOfDocument! != ''
                        ? DateStringFormatter.forOutputDate(
                            viewModel.dokumenLainnya![index].dateOfDocument!,
                          )
                        : ''
                    : '',
              ),
            ],
          ),
          Text(
            'Dokumen',
            style: titleStyle16,
          ),
          RowItemDetail(
            listWidget: [
              _dokumenLainnya(viewModel, index),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dokumenLainnya(
    DetailDokumenLainnyaViewModel vm,
    int i,
  ) {
    return vm.dokumenLainnya![i].path == null ||
            vm.dokumenLainnyaMap[index]['path'].isEmpty
        ? NotExistPhoto(
            desc: 'Belum ada dokumen ${vm.dokumenLainnyaMap[i]['path'] ?? ''}',
          )
        : FotoItem(
            vm.dokumenLainnyaMap[i]['label'],
            vm.dokumenLainnyaMap[i]['path'],
          );
  }
}
