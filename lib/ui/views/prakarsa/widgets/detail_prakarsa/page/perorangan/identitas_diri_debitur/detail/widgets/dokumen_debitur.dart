import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/foto_item.dart';
import '../../../../../../../../../shared/not_exist_photo.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../detail_identitas_diri_viewmodel.dart';

class DokumenDebitur extends HookViewModelWidget<DetailIdentitasDiriViewModel> {
  const DokumenDebitur({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    DetailIdentitasDiriViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Dokumen',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              viewModel.urlKtpDebiturPublic.isNotEmpty
                  ? FotoItem(
                      'Foto E-KTP Debitur',
                      viewModel.urlKtpDebiturPublic,
                    )
                  : const NotExistPhoto(desc: 'Belum ada E-KTP Debitur'),
              viewModel.urlNpwpDebiturPublic.isNotEmpty
                  ? FotoItem(
                      'NPWP Debitur',
                      viewModel.urlNpwpDebiturPublic,
                    )
                  : const NotExistPhoto(desc: 'Belum ada NPWP Debitur'),
            ],
          ),
          if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.ceraiMati)
            RowItemDetail(
              listWidget: [
                viewModel.urlKkDebiturPublic.isNotEmpty
                    ? FotoItem(
                        'Kartu Keluarga',
                        viewModel.urlKkDebiturPublic,
                      )
                    : const NotExistPhoto(
                        desc: 'Belum ada Kartu Keluarga',
                      ),
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
          if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.kawin)
            RowItemDetail(
              listWidget: [
                viewModel.urlKkDebiturPublic.isNotEmpty
                    ? FotoItem(
                        'Kartu Keluarga',
                        viewModel.urlKkDebiturPublic,
                      )
                    : const NotExistPhoto(
                        desc: 'Belum ada Kartu Keluarga',
                      ),
                viewModel.urlAktaNikahPublic.isNotEmpty
                    ? FotoItem(
                        'Akta Nikah',
                        viewModel.urlAktaNikahPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada Akta Nikah'),
              ],
            ),
          if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.ceraiHidup)
            RowItemDetail(
              listWidget: [
                viewModel.urlKkDebiturPublic.isNotEmpty
                    ? FotoItem(
                        'Kartu Keluarga',
                        viewModel.urlKkDebiturPublic,
                      )
                    : const NotExistPhoto(
                        desc: 'Belum ada Kartu Keluarga',
                      ),
                viewModel.urlSuratCeraiPublic.isNotEmpty
                    ? FotoItem(
                        'Akta Cerai',
                        viewModel.urlSuratCeraiPublic,
                      )
                    : const NotExistPhoto(desc: 'Belum ada Akta Cerai'),
              ],
            ),
          if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.belumKawin)
            RowItemDetail(
              listWidget: [
                viewModel.urlKkDebiturPublic.isNotEmpty
                    ? FotoItem(
                        'Kartu Keluarga',
                        viewModel.urlKkDebiturPublic,
                      )
                    : const NotExistPhoto(
                        desc: 'Belum ada Kartu Keluarga',
                      ),
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
