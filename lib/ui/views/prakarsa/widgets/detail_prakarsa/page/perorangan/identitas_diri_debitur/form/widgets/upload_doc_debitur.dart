import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../shared/base_form_section.dart';
import '../../../../../../../../../shared/upload_file.dart';
import '../form_identitas_diri_viewmodel.dart';

class UploadDocDebitur extends HookViewModelWidget<FormIdentitasDiriViewModel> {
  const UploadDocDebitur({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormIdentitasDiriViewModel viewModel,
  ) {
    return Column(
      children: [
        BaseFormSection(
          titleSection: 'Dokumen',
          leftSection: UploadFile(
            isLoading: viewModel.isLoadingFile[0],
            isEditable: false,
            label: 'Foto E-KTP Debitur *',
            imageUrl: viewModel.urlKtpDebiturPublic,
            onTap: () => viewModel.urlKtpDebiturPublic.isNotEmpty
                ? viewModel.clearFile(0)
                : viewModel.uploadFile(0),
          ),
          rightSection: UploadFile(
            isLoading: viewModel.isLoadingFile[1],
            label: 'NPWP Debitur *',
            imageUrl: viewModel.urlNpwpDebiturPublic,
            onTap: () => viewModel.urlNpwpDebiturPublic.isNotEmpty
                ? viewModel.clearFile(1)
                : viewModel.uploadFile(1),
          ),
          isLast: viewModel.codeTable == 2,
        ),
        if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
            Common.kawin) ...[
          BaseFormSection(
            leftSection: UploadFile(
              isLoading: viewModel.isLoadingFile[2],
              label: 'Foto E-KTP Pasangan *',
              imageUrl: viewModel.urlKtpPasanganPublic,
              onTap: () => viewModel.urlKtpPasanganPublic.isNotEmpty
                  ? viewModel.clearFile(2)
                  : viewModel.uploadFile(2),
            ),
            rightSection: UploadFile(
              isLoading: viewModel.isLoadingFile[3],
              label: 'Kartu Keluarga *',
              imageUrl: viewModel.urlKkDebiturPublic,
              onTap: () => viewModel.urlKkDebiturPublic.isNotEmpty
                  ? viewModel.clearFile(3)
                  : viewModel.uploadFile(3),
            ),
            isLast: true,
          ),
          BaseFormSection(
            leftSection: UploadFile(
              isLoading: viewModel.isLoadingFile[4],
              label: 'Akta Nikah *',
              imageUrl: viewModel.urlAktaNikahPublic,
              onTap: () => viewModel.urlAktaNikahPublic.isNotEmpty
                  ? viewModel.clearFile(4)
                  : viewModel.uploadFile(4),
            ),
            rightSection: const SizedBox(),
          ),
        ],
        if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
            Common.ceraiHidup)
          BaseFormSection(
            rightSection: UploadFile(
              isLoading: viewModel.isLoadingFile[5],
              label: 'Akta Cerai *',
              imageUrl: viewModel.urlSuratCeraiPublic,
              onTap: () => viewModel.urlSuratCeraiPublic.isNotEmpty
                  ? viewModel.clearFile(5)
                  : viewModel.uploadFile(5),
            ),
            leftSection: UploadFile(
              isLoading: viewModel.isLoadingFile[3],
              label: 'Kartu Keluarga *',
              imageUrl: viewModel.urlKkDebiturPublic,
              onTap: () => viewModel.urlKkDebiturPublic.isNotEmpty
                  ? viewModel.clearFile(3)
                  : viewModel.uploadFile(3),
            ),
          ),
        if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
            Common.ceraiMati)
          BaseFormSection(
            rightSection: UploadFile(
              isLoading: viewModel.isLoadingFile[6],
              label: 'Sertifikat Kematian *',
              imageUrl: viewModel.urlSuratKematianPublic,
              onTap: () => viewModel.urlSuratKematianPublic.isNotEmpty
                  ? viewModel.clearFile(6)
                  : viewModel.uploadFile(6),
            ),
            leftSection: UploadFile(
              isLoading: viewModel.isLoadingFile[3],
              label: 'Kartu Keluarga *',
              imageUrl: viewModel.urlKkDebiturPublic,
              onTap: () => viewModel.urlKkDebiturPublic.isNotEmpty
                  ? viewModel.clearFile(3)
                  : viewModel.uploadFile(3),
            ),
          ),
        if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
            Common.belumKawin)
          BaseFormSection(
            rightSection: UploadFile(
              isLoading: viewModel.isLoadingFile[7],
              label: 'Surat Keterangan Belum Menikah *',
              imageUrl: viewModel.urlBelumNikahPublic,
              onTap: () => viewModel.urlBelumNikahPublic.isNotEmpty
                  ? viewModel.clearFile(7)
                  : viewModel.uploadFile(7),
            ),
            leftSection: UploadFile(
              isLoading: viewModel.isLoadingFile[3],
              label: 'Kartu Keluarga *',
              imageUrl: viewModel.urlKkDebiturPublic,
              onTap: () => viewModel.urlKkDebiturPublic.isNotEmpty
                  ? viewModel.clearFile(3)
                  : viewModel.uploadFile(3),
            ),
          ),
      ],
    );
  }
}
