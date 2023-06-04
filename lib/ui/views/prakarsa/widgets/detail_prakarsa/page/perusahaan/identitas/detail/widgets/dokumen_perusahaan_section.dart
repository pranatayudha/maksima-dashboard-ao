import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/foto_item.dart';
import '../../../../../../../../../shared/not_exist_photo.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../detail_identitas_perusahaan_viewmodel.dart';

class DokumenPerusahaanSection
    extends HookViewModelWidget<DetailIdentitasPerusahaanViewModel> {
  const DokumenPerusahaanSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailIdentitasPerusahaanViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Dokumen',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              viewModel.identitasPerusahaan!.companyNpwpPath == null ||
                      viewModel.npwpPath.isEmpty
                  ? const NotExistPhoto(desc: 'Belum ada NPWP Perusahaan')
                  : FotoItem('NPWP Perusahaan', viewModel.npwpPath),
            ],
          ),
        ],
      ),
      isLast: true,
    );
  }
}
