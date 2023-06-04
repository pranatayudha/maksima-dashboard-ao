import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../shared/foto_item.dart';
import '../../../../../../../../shared/not_exist_photo.dart';
import '../../../../../../../../shared/row_item_detail.dart';
import '../detail_izin_usaha_viewmodel.dart';

class IzinUsahaCard extends HookViewModelWidget<DetailIzinUsahaViewModel> {
  final int index;
  const IzinUsahaCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailIzinUsahaViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Izin Usaha ${index + 1}',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Jenis Dokumen',
                value: (viewModel.izinUsaha![index].jenisDokumen ?? '')
                    .toUpperCase(),
              ),
              DetailPrakarsaItem(
                title: 'No. Dokumen',
                value: viewModel.izinUsaha![index].numDokumen ?? '',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Tanggal Terbit',
                value: viewModel.izinUsaha![index].tanggalDokumen != null
                    ? viewModel.izinUsaha![index].tanggalDokumen != ''
                        ? DateStringFormatter.forOutputDate(
                            viewModel.izinUsaha![index].tanggalDokumen!,
                          )
                        : ''
                    : '',
              ),
              DetailPrakarsaItem(
                title: 'Tempat Terbit',
                value: viewModel.izinUsaha![index].tempatTerbitDokumen ?? '',
              ),
            ],
          ),
          Text(
            'Dokumen',
            style: titleStyle16,
          ),
          RowItemDetail(
            listWidget: [
              _dokumenIzinUsaha(viewModel, index),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dokumenIzinUsaha(
    DetailIzinUsahaViewModel vm,
    int i,
  ) {
    return vm.izinUsaha![i].pathDokumen == null || vm.docPath.isEmpty
        ? NotExistPhoto(
            desc: 'Belum ada dokumen ${vm.izinUsaha![i].jenisDokumen ?? ''}',
          )
        : FotoItem(
            vm.izinUsaha![i].jenisDokumen!,
            vm.docPath[i],
          );
  }
}
