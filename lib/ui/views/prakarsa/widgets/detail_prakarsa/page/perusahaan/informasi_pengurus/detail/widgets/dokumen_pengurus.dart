import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/foto_item.dart';
import '../../../../../../../../../shared/not_exist_photo.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../detail_pengurus_viewmodel.dart';

class DokumenPengurus
    extends HookViewModelWidget<DetailInformasiPengurusViewModel> {
  const DokumenPengurus({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailInformasiPengurusViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Dokumen',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              viewModel.urlKtpPengurusPublic.isNotEmpty
                  ? FotoItem(
                      'Foto E-KTP Pengurus',
                      viewModel.urlKtpPengurusPublic,
                    )
                  : const NotExistPhoto(desc: 'Belum ada E-KTP Pengurus'),
              viewModel.urlNpwpPengurusPublic.isNotEmpty
                  ? FotoItem(
                      'NPWP Pengurus',
                      viewModel.urlNpwpPengurusPublic,
                    )
                  : const NotExistPhoto(desc: 'Belum ada NPWP Pengurus'),
            ],
          ),
          if (viewModel.dataPengurus.maritalStatus == Common.ceraiMati)
            RowItemDetail(
              listWidget: [
                viewModel.urlKkPengurusPublic.isNotEmpty
                    ? FotoItem(
                        'Kartu Keluarga',
                        viewModel.urlKkPengurusPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada Kartu Keluarga'),
                viewModel.urlSuratKematianPublic.isNotEmpty
                    ? FotoItem(
                        'Sertifikat Kematian',
                        viewModel.urlSuratKematianPublic,
                      )
                    : const NotExistPhoto(
                        desc: 'Belum ada Sertifikat Kematian',
                      ),
              ],
            ),
          if (viewModel.dataPengurus.maritalStatus == Common.kawin) ...[
            RowItemDetail(
              listWidget: [
                viewModel.urlKtpPasanganPublic.isNotEmpty
                    ? FotoItem(
                        'E-KTP Pasangan',
                        viewModel.urlKtpPasanganPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada E-KTP Pasangan'),
                viewModel.urlKkPengurusPublic.isNotEmpty
                    ? FotoItem(
                        'Kartu Keluarga',
                        viewModel.urlKkPengurusPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada Kartu Keluarga'),
              ],
            ),
            RowItemDetail(
              listWidget: [
                viewModel.urlAktaNikahPublic.isNotEmpty
                    ? FotoItem(
                        'Akta Nikah',
                        viewModel.urlAktaNikahPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada Akta Nikah'),
              ],
            ),
          ],
          if (viewModel.dataPengurus.maritalStatus == Common.ceraiHidup)
            RowItemDetail(
              listWidget: [
                viewModel.urlKkPengurusPublic.isNotEmpty
                    ? FotoItem(
                        'Kartu Keluarga',
                        viewModel.urlKkPengurusPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada Kartu Keluarga'),
                viewModel.urlSuratCeraiPublic.isNotEmpty
                    ? FotoItem(
                        'Akta Cerai',
                        viewModel.urlSuratCeraiPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada Akta Cerai'),
              ],
            ),
          if (viewModel.dataPengurus.maritalStatus == Common.belumKawin)
            RowItemDetail(
              listWidget: [
                viewModel.urlKkPengurusPublic.isNotEmpty
                    ? FotoItem(
                        'Kartu Keluarga',
                        viewModel.urlKkPengurusPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada Kartu Keluarga'),
                viewModel.urlBelumNikahPublic.isNotEmpty
                    ? FotoItem(
                        'Surat Keterangan Belum Menikah',
                        viewModel.urlBelumNikahPublic,
                      )
                    : const NotExistPhoto(
                        desc: 'Belum ada Surat Keterangan Belum Menikah',
                      ),
              ],
            ),
        ],
      ),
      isLast: true,
    );
  }
}
