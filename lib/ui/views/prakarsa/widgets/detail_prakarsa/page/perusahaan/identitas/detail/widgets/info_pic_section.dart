import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../detail_identitas_perusahaan_viewmodel.dart';

class InfoPICSection
    extends HookViewModelWidget<DetailIdentitasPerusahaanViewModel> {
  const InfoPICSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailIdentitasPerusahaanViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Info PIC Perusahaan',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Nama Lengkap PIC',
                value: viewModel.identitasPerusahaan!.fullnamePIC != null
                    ? viewModel.identitasPerusahaan!.fullnamePIC != ''
                        ? viewModel.identitasPerusahaan!.fullnamePIC!
                        : '-'
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Posisi PIC',
                value: viewModel.identitasPerusahaan!.positionPIC != null
                    ? viewModel.identitasPerusahaan!.positionPIC != ''
                        ? viewModel.identitasPerusahaan!.positionPIC!
                        : '-'
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. Handphone PIC',
                value: viewModel.identitasPerusahaan!.phoneNumPIC != null
                    ? viewModel.identitasPerusahaan!.phoneNumPIC != ''
                        ? viewModel.identitasPerusahaan!.phoneNumPIC!
                        : '-'
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Email',
                value: viewModel.identitasPerusahaan!.emailPIC != null
                    ? viewModel.identitasPerusahaan!.emailPIC != ''
                        ? viewModel.identitasPerusahaan!.emailPIC!
                        : '-'
                    : '-',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
