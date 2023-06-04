import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../../application/enums/document_name.dart';
import '../../../../../../../../../../customs/custom_dialogs/show_document_dialog.dart';
import '../../../../../../../../../../shared/base_form_layout.dart';
import '../../../../../../../../../../shared/divider_form.dart';
import '../../../../agunan_pokok/widgets/upload_document_agunan.dart';
import '../form_agunan_tanah_bangunan_viewmodel.dart';

class DokumenAgunanSection extends HookViewModelWidget<FormAgunanTanahBangunanViewModel> {
  const DokumenAgunanSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    FormAgunanTanahBangunanViewModel viewModel,
  ) {
    return BaseFromLayout(
      title: 'Dokumen Agunan',
      subtitle: 'Sertifikat bukti kepemilikan dan bukti bayar PBB terakhir',
      rightSection: _buildDokumenAgunan(context, viewModel),
    );
  }

  Widget _buildDokumenAgunan(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return Column(
      children: [
        UploadDocumentAgunan(
          label: 'Upload Sertifikat Kepemilikan',
          docUrl: viewModel.urlDocPublic[DocName.docKepemilikan],
          isLoading: viewModel.isLoadDoc[DocName.docKepemilikan] ?? false,
          subLabel: 'Format file PNG, JPG atau PDF (max 25 MB)',
          onTap: () => (viewModel.urlDocPublic[DocName.docKepemilikan] == '')
              ? viewModel.uploadDoc(DocName.docKepemilikan)
              : viewModel.clearDoc(DocName.docKepemilikan),
          onTapLihat: () => showDocumnet(
            context: context,
            path: viewModel.urlDocPublic[DocName.docKepemilikan] ?? '',
          ),
        ),
        const DividerForm(),
        UploadDocumentAgunan(
          label: 'Upload Bukti Bayar PBB Terakhir',
          docUrl: viewModel.urlDocPublic[DocName.docBuktiPBB],
          isLoading: viewModel.isLoadDoc[DocName.docBuktiPBB] ?? false,
          subLabel: 'Format file PNG, JPG atau PDF (max 25 MB)',
          onTap: () => (viewModel.urlDocPublic[DocName.docBuktiPBB] == '')
              ? viewModel.uploadDoc(DocName.docBuktiPBB)
              : viewModel.clearDoc(DocName.docBuktiPBB),
          onTapLihat: () => showDocumnet(
            context: context,
            path: viewModel.urlDocPublic[DocName.docBuktiPBB] ?? '',
          ),
        ),
        const DividerForm(),
        UploadDocumentAgunan(
          label: 'Upload Dokumen IMB',
          docUrl: viewModel.urlDocPublic[DocName.docIMB],
          isLoading: viewModel.isLoadDoc[DocName.docIMB] ?? false,
          subLabel: 'Format file PNG, JPG atau PDF (max 25 MB)',
          onTap: () => (viewModel.urlDocPublic[DocName.docIMB] == '')
              ? viewModel.uploadDoc(DocName.docIMB)
              : viewModel.clearDoc(DocName.docIMB),
          onTapLihat: () => showDocumnet(
            context: context,
            path: viewModel.urlDocPublic[DocName.docIMB] ?? '',
          ),
        ),
        const DividerForm(),
        if (Common.jenisPenilaianKJPPList.contains(viewModel.jenisPenilaianController.text))
          _buildDokumenKJPP(context, viewModel),
        if (Common.jenisPenilaianKJPPNonList.contains(viewModel.jenisPenilaianController.text))
          _buildDokumenKJPPNon(context, viewModel),
      ],
    );
  }

  Widget _buildDokumenKJPP(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return Column(
      children: [
        UploadDocumentAgunan(
          label: 'Upload Dokumen KJPP',
          docUrl: viewModel.urlDocPublic[DocName.docKJPP],
          isLoading: viewModel.isLoadDoc[DocName.docKJPP] ?? false,
          subLabel: 'Format file PNG, JPG atau PDF (max 25 MB)',
          onTap: () => (viewModel.urlDocPublic[DocName.docKJPP] == '')
              ? viewModel.uploadDoc(DocName.docKJPP)
              : viewModel.clearDoc(DocName.docKJPP),
          onTapLihat: () => showDocumnet(
            context: context,
            path: viewModel.urlDocPublic[DocName.docKJPP] ?? '',
          ),
        ),
        const DividerForm(),
      ],
    );
  }

  Widget _buildDokumenKJPPNon(BuildContext context, FormAgunanTanahBangunanViewModel viewModel) {
    return Column(
      children: [
        UploadDocumentAgunan(
          label: 'Upload Dokumen Izin Prinsip',
          docUrl: viewModel.urlDocPublic[DocName.docIzin],
          isLoading: viewModel.isLoadDoc[DocName.docIzin] ?? false,
          subLabel: 'Format file PNG, JPG atau PDF (max 25 MB)',
          onTap: () => (viewModel.urlDocPublic[DocName.docIzin] == '')
              ? viewModel.uploadDoc(DocName.docIzin)
              : viewModel.clearDoc(DocName.docIzin),
          onTapLihat: () => showDocumnet(
            context: context,
            path: viewModel.urlDocPublic[DocName.docIzin] ?? '',
          ),
        ),
        const DividerForm(),
      ],
    );
  }
}
