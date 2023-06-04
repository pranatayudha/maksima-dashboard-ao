import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../application/enums/document_name.dart';
import '../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../../application/helpers/is_image_or_pdf.dart';
import '../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../application/models/detail_agunan_tambahan_model.dart';
import '../../../../../../../../../../application/models/foto_kunjungan_model.dart';
import '../../../../../../../../../../application/models/list_agunan_tambahan_model.dart';
import '../../../../../../../../../../application/services/media_service.dart';
import '../../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';
import '../../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../customs/custom_dialogs/loading_custom_dialog.dart';
import 'form_agunan_tanah_bangunan_mixin_viewmodel.dart';

class FormAgunanTanahBangunanViewModel extends BaseViewModel with FormAgunanTanahBangunanMixinViewModel, RouteMixin {
  final _navigationService = locator<NavigationService>();
  final _mediaService = locator<MaksimaMediaService>();
  final _dialogService = locator<DialogService>();
  final _masterAPI = locator<MasterAPI>();
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();

  final String prakarsaId;
  final int codeTable;
  final String id;
  final Function(dynamic) agunanId;

  String? idAgunan;

  DetailAgunanTambahanModel? _detailAgunanTambahan;
  DetailAgunanTambahanModel? get detailAgunanTambahan => _detailAgunanTambahan;

  FormAgunanTanahBangunanViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.id,
    required this.agunanId,
  });

  Future<void> uploadDoc(DocName docName) async {
    PlatformFile? res = await _mediaService.getMultiFileType();
    if (res == null) return;

    if (!isImageOrPdf(res.extension!)) {
      _showErrorDialog(
        'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
      );

      return;
    }

    _showLoadingDialog();
    isLoadDoc[docName] = true;
    notifyListeners();
    _uploadDoc(docName: docName, file: res);
  }

  Future<void> _uploadDoc({required DocName docName, required PlatformFile file}) async {
    final res = await runBusyFuture(
      _masterAPI.uploadFile(
        file: file,
      ),
    );
    res.fold((errorMessage) => _showErrorDialog(errorMessage), (url) async {
      urlDoc[docName] = url;
      urlDocPublic[docName] = await _getPublicFile(url);
    });

    _navigationService.back();
    isLoadDoc[docName] = false;
    notifyListeners();
  }

  void clearDoc(DocName docName) {
    urlDoc[docName] = '';
    urlDocPublic[docName] = '';
    notifyListeners();
  }

  Future<void> onTapFotoAgunanTambahan() async {
    List<String> allowedExtensions = ['jpg', 'jpeg', 'png'];
    FilePickerResult? res = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    PlatformFile? file = res?.files.single;
    if (file == null) return;

    if (!isImageOrPdf(file.extension!)) {
      _showErrorDialog(
        'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
      );

      return;
    }
    _showLoadingDialog();
    _uploadFotoAgunanTambahan(file);
    notifyListeners();
  }

  Future<void> _uploadFotoAgunanTambahan(PlatformFile file) async {
    final res = await runBusyFuture(
      _masterAPI.uploadFile(
        file: file,
      ),
    );
    res.fold((errorMessage) => _showErrorDialog(errorMessage), (url) async {
      urlFotoAgunanTambahan.add(url);

      String temp = await _getPublicFile(url);
      final dateNow = DateTime.now();
      final outputFormat = DateFormat('dd MMM yyyy', 'id');
      String date = outputFormat.format(dateNow);

      fotoAgunanTambahanList.add(
        FotoKunjunganModel(
          imageUrl: temp,
          date: date,
          address: tagLocationController.text,
          tagLocation: {
            'latLng': selectedLatLng,
            'name': tagLocationController.text,
          },
        ),
      );
    });

    _navigationService.back();
    notifyListeners();
  }

  void clearAgunanTambahan(int index) {
    urlFotoAgunanTambahan.removeAt(index);
    fotoAgunanTambahanList.removeAt(index);
    notifyListeners();
  }

  Future<void> onPressedSimpanDraft() async {
    String? dataId = await _validateInputs(isSavedDrafts: true);

    if (dataId != null && dataId.isNotEmpty) {
      agunanId(
        ListAgunanTambahanModel(
          id: dataId,
          codeTable: 'tanah bangunan',
        ),
      );
      _showSuccessDialog(true);
    }
  }

  Future<void> onPressedLanjutkan() async {
    String? dataId = await _validateInputs(isSavedDrafts: false);

    if (dataId != null && dataId.isNotEmpty) {
      agunanId(
        ListAgunanTambahanModel(
          id: dataId,
          codeTable: 'tanah bangunan',
        ),
      );
      _showSuccessDialog(false);
    }
  }

  Future<String?> _validateInputs({required bool isSavedDrafts}) async {
    String? res;

    final response = await _dialogService.showCustomDialog(
      variant: DialogType.base,
      title: 'Konfirmasi Pengisian Data',
      description: 'Apakah anda yakin data yang diisi sudah sesuai?',
      mainButtonTitle: 'Batalkan',
      secondaryButtonTitle: 'Ya, sesuai',
      data: {
        'main': false,
        'secondary': true,
      },
    );

    if (response != null && response.confirmed) {
      res = await _addAgunanTambahan(isSavedDrafts);
    }

    return res;
  }

  Future<String> _addAgunanTambahan(bool isDraft) async {
    final res = (_detailAgunanTambahan?.id ?? '').isEmpty
        ? await _agunanTambahanAPI.addAgunanTambahan(
            jenisAgunan: 'tanah-bangunan',
            payload: _generatePayload(isSaveDraft: isDraft),
          )
        : await _agunanTambahanAPI.updateAgunanTambahan(
            jenisAgunan: 'tanah-bangunan',
            payload: _generatePayload(isSaveDraft: isDraft),
          );

    res.fold(
      (errorMsg) => _showErrorDialogForm(),
      (id) {
        _updateIdAgunan(id);
      },
    );

    return idAgunan ?? '';
  }

  void _updateIdAgunan(String val) {
    idAgunan = val;
    notifyListeners();
  }

  Map<String, dynamic> _generatePayload({required bool isSaveDraft}) {
    return {
      'prakarsaId': prakarsaId,
      'isDraft': isSaveDraft,
      'jenisPengikatan': jenisPengikatanController.text,
      'luasTanah': luasTanahController.text.isNotEmpty ? int.parse(luasTanahController.text.replaceAll('.', '')) : '',
      'luasBangunan':
          luasBangunanController.text.isNotEmpty ? int.parse(luasBangunanController.text.replaceAll('.', '')) : '',
      'isNotIMBReady': isNotIMBReady,
      'numResiIMB': noImbController.text,
      'numIMB': noImbController.text,
      'tagLocation': {
        'latLng': selectedLatLng,
        'name': tagLocationController.text,
      },
      'detail': tagLocationController.text,
      'postalCode': postalCode?.postalCode ?? '',
      'province': postalCode?.province ?? '',
      'city': postalCode?.city ?? '',
      'district': postalCode?.district ?? '',
      'village': postalCode?.village ?? '',
      'rt': rtController.text,
      'rw': rwController.text,
      'NOP': noSPPTNOPController.text,
      'jenisSertifikat': jenisSertifikatController.text,
      'numSertifikat': noJenisSertifikatController.text,
      'namaPemilik': namaPemilikController.text,
      'jatuhTempo': tglJatuhTempoController.text.isNotEmpty
          ? DateStringFormatter.forInputDate(tglJatuhTempoController.text.trim())
          : '',
      'pathBuktiBayarPBBTerakhir': urlDoc[DocName.docBuktiPBB] != '' ? [urlDoc[DocName.docBuktiPBB]] : [],
      'pathFotoAgunanTambahan': List.generate(urlFotoAgunanTambahan.length, (index) => urlFotoAgunanTambahan[index]),
      'jenisPenilaian': jenisPenilaianController.text,
      'statusKepemilikan': statusKepemilikanController.text,
      'permukaanTanah': permukaanTanahController.text,
      'bentukTanah': bentukTanahController.text,
      'bentukBangunan': bentukBangunanController.text,
      'peruntukan': peruntukkanZoningController.text,
      'spesifikasiBangunan': spesifikasiBangunanController.text,
      'batasBarat': batasBaratController.text,
      'batasUtara': batasUtaraController.text,
      'batasTimur': batasTimurController.text,
      'batasSelatan': batasSelatanController.text,
      'alamatSesuaiSertifikat': alamatController.text,
      'NJOP': njopController.text.isNotEmpty ? int.parse(njopController.text.replaceAll('.', '')) : '',
      'NJOPTanahM2': njopTanahPerMeterController.text.isNotEmpty
          ? int.parse(njopTanahPerMeterController.text.replaceAll('.', ''))
          : '',
      'NJOPBangunanM2': njopBangunanPerMeterController.text.isNotEmpty
          ? int.parse(njopBangunanPerMeterController.text.replaceAll('.', ''))
          : '',
      'pathSertifikatKepemilikan': urlDoc[DocName.docKepemilikan],
      'namaKjpp': nameKJPPController.text,
      'nomorPenilaian': noLapPenilaianController.text,
      'tanggalLaporan': tglLaporanController.text.isNotEmpty
          ? DateStringFormatter.forInputDate(tglLaporanController.text.trim())
          : '',
      'tanggalPenilaian': tglPenilaianController.text.isNotEmpty
          ? DateStringFormatter.forInputDate(tglPenilaianController.text.trim())
          : '',
      'pathDokumenKjpp': urlDoc[DocName.docKJPP],
      'nomorPersetujuanIzinPrinsip': noPersetujuanIzinController.text,
      'tanggalPersetujuanIzinPrinsip': tglPersetjuanIzinController.text.isNotEmpty
          ? DateStringFormatter.forInputDate(tglPersetjuanIzinController.text.trim())
          : '',
      'pathDokumenIMB': urlDoc[DocName.docIMB],
      'pathDokumenPersetujuan': urlDoc[DocName.docIzin],
      if ((_detailAgunanTambahan?.id ?? '').isNotEmpty) 'id': _detailAgunanTambahan?.id ?? '',
    };
  }

  Future<String> _getPublicFile(String url) async {
    String temp = '';
    final res = await runBusyFuture(
      _masterAPI.getPublicFile(url),
    );

    res.fold(
      (err) => temp = '',
      (success) => temp = success,
    );

    return temp;
  }

  Future<void> _showSuccessDialog(
    bool isSavedDrafts,
  ) async {
    var result = await _dialogService.showCustomDialog(
      variant: DialogType.baseImage,
      data: {
        'imageAsset': ImageConstants.successVerification,
      },
      title: isSavedDrafts ? 'Data Disimpan Sementara' : 'Data Berhasil Disimpan',
      description:
          isSavedDrafts ? 'Pastikan lengkapi seluruh data agunan Tambahan' : 'Data telah berhasil disimpan di Sistem',
      mainButtonTitle: 'Sip, mengerti',
    );

    if (result != null) {
      navigateBack(isPassed: true);
      if ((_detailAgunanTambahan?.id ?? '').isEmpty) {
        navigateTo(ConstantPageRoute.detailAgunanTambahan);
      }
    }
  }

  Future _showErrorDialogForm() async {
    await _dialogService.showCustomDialog(
      variant: DialogType.baseImage,
      data: {
        'imageAsset': ImageConstants.failedVerification,
      },
      title: 'Data belum lengkap, lengkapi seluruh data yang tersedia',
      description: 'Simpan draft jika data yang diterima debitur belum lengkap',
      mainButtonTitle: 'Sip, mengerti',
    );
  }

  void _showLoadingDialog() {
    BuildContext? context = StackedService.navigatorKey?.currentContext;
    loadingCustomDialog(context!);
  }

  Future _showErrorDialog(String errorMessage) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.error,
      title: 'Gagal',
      description: errorMessage,
      mainButtonTitle: 'COBA LAGI',
    );
  }
}
