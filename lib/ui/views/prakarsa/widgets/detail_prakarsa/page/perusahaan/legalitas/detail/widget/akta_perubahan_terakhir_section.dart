import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../../../application/models/detail_legalitas.dart';
import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/foto_item.dart';
import '../../../../../../../../../shared/not_exist_photo.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../detail_legalitas_viewmodel.dart';

class AktaPerubahanSection
    extends HookViewModelWidget<DetailLegalitasViewModel> {
  const AktaPerubahanSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailLegalitasViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(viewModel.legalitas!.deedOthers!.length, (index) {
        DeedOthers deedOthers = viewModel.legalitas!.deedOthers![index];

        return BaseDetailSection(
          title: 'Akta Perubahan ${index == 0 ? 'Terakhir' : 'Lain'}',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowItemDetail(
                listWidget: [
                  DetailPrakarsaItem(
                    title:
                        'No. Akta Perubahan ${index == 0 ? 'Terakhir' : 'Lain'}',
                    value: deedOthers.deedEstNum != null
                        ? deedOthers.deedEstNum!
                        : '-',
                  ),
                  DetailPrakarsaItem(
                    title:
                        'Tanggal Akta Perubahan ${index == 0 ? 'Terakhir' : 'Lain'}',
                    value: deedOthers.dateOfDeedEst != null
                        ? DateStringFormatter.forOutputRitel(
                            deedOthers.dateOfDeedEst!,
                          )
                        : '-',
                  ),
                ],
              ),
              RowItemDetail(
                listWidget: [
                  DetailPrakarsaItem(
                    title:
                        'Tempat Akta Perubahan ${index == 0 ? 'Terakhir' : 'Lain'}',
                    value: deedOthers.placeOfDeedEst != null
                        ? deedOthers.placeOfDeedEst!
                        : '-',
                  ),
                ],
              ),
              RowItemDetail(
                listWidget: [
                  DetailPrakarsaItem(
                    title: 'Nama Notaris',
                    value: deedOthers.notaryName != null
                        ? deedOthers.notaryName!
                        : '-',
                  ),
                  DetailPrakarsaItem(
                    title: 'Tempat Kedudukan Notaris',
                    value: deedOthers.notaryPosition != null
                        ? deedOthers.notaryPosition!
                        : '-',
                  ),
                ],
              ),
              RowItemDetail(
                listWidget: [
                  DetailPrakarsaItem(
                    title:
                        'No. SK Kumham Perubahan ${index == 0 ? 'Terakhir' : 'Lain'}',
                    value: deedOthers.skKumhamNum != null
                        ? deedOthers.skKumhamNum != ''
                            ? deedOthers.skKumhamNum!
                            : '-'
                        : '-',
                  ),
                  DetailPrakarsaItem(
                    title:
                        'Tanggal SK Kumham Perubahan ${index == 0 ? 'Terakhir' : 'Lain'}',
                    value: deedOthers.dateOfSkKumham != null
                        ? DateStringFormatter.forOutputRitel(
                            deedOthers.dateOfSkKumham!,
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
                  _aktaPerubahanDoc(viewModel, deedOthers, index),
                  _skKumhamPerubahanDoc(viewModel, deedOthers, index),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _aktaPerubahanDoc(
    DetailLegalitasViewModel vm,
    DeedOthers deedOthers,
    int i,
  ) {
    return deedOthers.deedEstFilePath == null || vm.deedLastPath.isEmpty
        ? NotExistPhoto(
            desc:
                'Belum ada dokumen Akta Perubahan ${i == 0 ? 'Terakhir' : 'Lain'}',
          )
        : FotoItem(
            'Akta Perubahan ${i == 0 ? 'Terakhir' : 'Lain'}',
            vm.deedLastPath[i],
          );
  }

  Widget _skKumhamPerubahanDoc(
    DetailLegalitasViewModel vm,
    DeedOthers deedOthers,
    int i,
  ) {
    return deedOthers.skKumhamFilePath == null ||
            vm.skKumhamPerubahanPath.isEmpty
        ? NotExistPhoto(
            desc:
                'Belum ada dokumen SK Kumham Perubahan ${i == 0 ? 'Terakhir' : 'Lain'}',
          )
        : FotoItem(
            'SK Kumham Perubahan ${i == 0 ? 'Terakhir' : 'Lain'}',
            vm.skKumhamPerubahanPath[i],
          );
  }
}
