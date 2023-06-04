import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../../../../../../../application/app/app.locator.dart';
import '../../../../../../../../../../../../application/app/constants/image_constants.dart';
import '../../../../../../../../../../../../application/app/constants/page_route.dart';
import '../../../../../../../../../../../../application/enums/dialog_type.dart';
import '../../../../../../../../../../../../application/helpers/is_image_or_pdf.dart';
import '../../../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../../../../../../application/models/detail_agunan_tambahan_model.dart';
import '../../../../../../../../../../../../application/models/foto_kunjungan_model.dart';
import '../../../../../../../../../../../../application/models/postal_code_model.dart';
import '../../../../../../../../../../../../application/services/media_service.dart';
import '../../../../../../../../../../../../infrastructure/apis/agunan_tambahan_api.dart';
import '../../../../../../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../customs/custom_dialogs/loading_custom_dialog.dart';

class FormPenilaianAgunanViewModel extends BaseViewModel with RouteMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  final _mediaService = locator<MaksimaMediaService>();
  final _masterAPI = locator<MasterAPI>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _agunanTambahanAPI = locator<AgunanTambahanAPI>();

  final String prakarsaId;
  final int codeTable;
  final String jenisPenilaian;
  final String id;
  FormPenilaianAgunanViewModel({
    required this.prakarsaId,
    required this.codeTable,
    required this.jenisPenilaian,
    required this.id,
  });

  TextEditingController statusKepemilikanController = TextEditingController();
  TextEditingController jenisPengikatanController = TextEditingController();
  TextEditingController permukaanTanahController = TextEditingController();
  TextEditingController bentukTanahController = TextEditingController();
  TextEditingController luasTanahController = TextEditingController();
  TextEditingController batasBaratController = TextEditingController();
  TextEditingController batasUtaraController = TextEditingController();
  TextEditingController batasTimurController = TextEditingController();
  TextEditingController batasSelatanController = TextEditingController();
  TextEditingController tagLocationController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kodePosController = TextEditingController();
  TextEditingController rtController = TextEditingController();
  TextEditingController rwController = TextEditingController();
  TextEditingController jenisSertifikatController = TextEditingController();
  TextEditingController noJenisSertifikatController = TextEditingController();
  TextEditingController noSPPTController = TextEditingController();
  TextEditingController namaPemilikController = TextEditingController();
  TextEditingController jatuhTempoController = TextEditingController();
  TextEditingController njopController = TextEditingController();
  TextEditingController njopPerMeterController = TextEditingController();

  TextEditingController namaKJPPController = TextEditingController();
  TextEditingController nomorPersetujuanIzinPrinsipController =
      TextEditingController();
  TextEditingController nomorPenilaianController = TextEditingController();
  TextEditingController tanggalPersetujuanIzinPrinsipController =
      TextEditingController();
  TextEditingController tanggalPenilaianController = TextEditingController();
  TextEditingController tanggalLaporanController = TextEditingController();

  DetailAgunanTambahanModel? _detailAgunanTambahan;
  DetailAgunanTambahanModel? get detailAgunanTambahan => _detailAgunanTambahan;

  bool isLoadDocKepemilikan = false;
  bool isLoadDocKJPP = false;
  bool isLoadBuktiPbb = false;
  bool isLoadIzinPrinsipKJPP = false;
  bool isLoadForm = false;

  String? urlDocKepemilikanPublic;
  String? urlDocKepemilikan;
  String? urlBuktiPbbPublic;
  String? urlBuktiPbb;
  String? urlDocKJPP;
  String? urlIzinPrinsipKJPP;

  String? idAgunan;

  String selectedLatLng = '';

  List<String> urlAgunanTambahan = [];
  List<FotoKunjunganModel> listFotoKunjungan = [];

  PostalCodeModel? selectedPostalCode;

  final dateNow = DateTime.now();

  List<String> statusKepemilikan = [
    'Milik Sendiri',
    'Milik Pengurus/Pemilik',
  ];

  List<String> jenisPengikatan = [
    'HT 1',
    'HT 2',
    'HT 3',
    'HT 4',
  ];

  List<String> listPermukaanTanah = [
    'Rata',
    'Bergelombang',
    'Landai',
  ];

  List<String> listBentukTanah = [
    'Segitiga',
    'Segiempat',
    'Trapesium',
    'Tidak Beraturan',
  ];

  List<String> jenisSertifikat = [
    'SHM',
    'SHGB',
    'SHGU',
  ];

  void initialize() async {
    if (id.isNotEmpty) {
      setLoadForm(true);

      await fetchDetailAgunanTambahan();
      if (jenisPenilaian != 'Penilaian internal') {
        _prePopulateFormKJPP();
      }
      _prePopulateForm();
      setLoadForm(false);
      notifyListeners();
    }
  }

  void setLoadForm(bool val) {
    isLoadForm = val;
    notifyListeners();
  }

  // ignore: long-method
  void _prePopulateForm() {
    statusKepemilikanController
      ..text = _detailAgunanTambahan?.statusKepemilikan ?? ''
      ..selection = TextSelection.collapsed(
        offset: statusKepemilikanController.text.length,
      );

    jenisPengikatanController
      ..text = _detailAgunanTambahan?.jenisPengikatan ?? ''
      ..selection = TextSelection.collapsed(
        offset: jenisPengikatanController.text.length,
      );

    luasTanahController
      ..text = (_detailAgunanTambahan?.luasTanah ?? '').isNotEmpty
          ? RupiahFormatter.formatWithOutRp(
              double.parse(_detailAgunanTambahan?.luasTanah ?? '')
                  .round()
                  .toString(),
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: luasTanahController.text.length,
      );

    permukaanTanahController
      ..text = _detailAgunanTambahan?.permukaanTanah ?? ''
      ..selection = TextSelection.collapsed(
        offset: permukaanTanahController.text.length,
      );

    bentukTanahController
      ..text = _detailAgunanTambahan?.bentukTanah ?? ''
      ..selection = TextSelection.collapsed(
        offset: bentukTanahController.text.length,
      );

    batasBaratController
      ..text = _detailAgunanTambahan?.batasBarat ?? ''
      ..selection = TextSelection.collapsed(
        offset: batasBaratController.text.length,
      );

    batasUtaraController
      ..text = _detailAgunanTambahan?.batasUtara ?? ''
      ..selection = TextSelection.collapsed(
        offset: batasUtaraController.text.length,
      );

    batasTimurController
      ..text = _detailAgunanTambahan?.batasTimur ?? ''
      ..selection = TextSelection.collapsed(
        offset: batasTimurController.text.length,
      );

    batasSelatanController
      ..text = _detailAgunanTambahan?.batasSelatan ?? ''
      ..selection = TextSelection.collapsed(
        offset: batasSelatanController.text.length,
      );

    tagLocationController
      ..text = _detailAgunanTambahan?.detail ?? ''
      ..selection = TextSelection.collapsed(
        offset: tagLocationController.text.length,
      );

    alamatController
      ..text = _detailAgunanTambahan?.alamatSesuaiSertifikat ?? ''
      ..selection = TextSelection.collapsed(
        offset: alamatController.text.length,
      );

    kodePosController
      ..text = (_detailAgunanTambahan?.postalCode ?? '').isNotEmpty
          ? '${_detailAgunanTambahan?.postalCode}, ${_detailAgunanTambahan?.province}, ${_detailAgunanTambahan?.city}, ${_detailAgunanTambahan?.district}, ${_detailAgunanTambahan?.village}'
          : ''
      ..selection = TextSelection.collapsed(
        offset: kodePosController.text.length,
      );

    rtController
      ..text = _detailAgunanTambahan?.rt ?? ''
      ..selection = TextSelection.collapsed(
        offset: rtController.text.length,
      );

    rwController
      ..text = _detailAgunanTambahan?.rw ?? ''
      ..selection = TextSelection.collapsed(
        offset: rwController.text.length,
      );

    jenisSertifikatController
      ..text = _detailAgunanTambahan?.jenisSertifikat ?? ''
      ..selection = TextSelection.collapsed(
        offset: jenisSertifikatController.text.length,
      );

    noJenisSertifikatController
      ..text = _detailAgunanTambahan?.numSertifikat ?? ''
      ..selection = TextSelection.collapsed(
        offset: noJenisSertifikatController.text.length,
      );

    namaPemilikController
      ..text = _detailAgunanTambahan?.namaPemilik ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaPemilikController.text.length,
      );

    jatuhTempoController
      ..text = _detailAgunanTambahan?.jatuhTempo ?? ''
      ..selection = TextSelection.collapsed(
        offset: jatuhTempoController.text.length,
      );

    noSPPTController
      ..text = _detailAgunanTambahan?.nOP ?? ''
      ..selection = TextSelection.collapsed(
        offset: noSPPTController.text.length,
      );

    njopController
      ..text = (_detailAgunanTambahan?.nJOP ?? '').isNotEmpty
          ? RupiahFormatter.formatWithOutRp(
              double.parse(_detailAgunanTambahan?.nJOP ?? '')
                  .round()
                  .toString(),
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: njopController.text.length,
      );

    njopPerMeterController
      ..text = (_detailAgunanTambahan?.nJOPm2 ?? '').isNotEmpty
          ? RupiahFormatter.formatWithOutRp(
              double.parse(_detailAgunanTambahan?.nJOPm2 ?? '')
                  .round()
                  .toString(),
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: njopPerMeterController.text.length,
      );
  }

  void _prePopulateFormKJPP() {
    namaKJPPController
      ..text = _detailAgunanTambahan?.namaKjpp ?? ''
      ..selection = TextSelection.collapsed(
        offset: namaKJPPController.text.length,
      );
    nomorPersetujuanIzinPrinsipController
      ..text = _detailAgunanTambahan?.nomorPersetujuanIzinPrinsip ?? ''
      ..selection = TextSelection.collapsed(
        offset: nomorPersetujuanIzinPrinsipController.text.length,
      );
    nomorPenilaianController
      ..text = _detailAgunanTambahan?.nomorPenilaian ?? ''
      ..selection = TextSelection.collapsed(
        offset: nomorPenilaianController.text.length,
      );
    tanggalPersetujuanIzinPrinsipController
      ..text = _detailAgunanTambahan?.tanggalPersetujuanIzinPrinsip ?? ''
      ..selection = TextSelection.collapsed(
        offset: tanggalPersetujuanIzinPrinsipController.text.length,
      );
    tanggalPersetujuanIzinPrinsipController
      ..text = (_detailAgunanTambahan?.tanggalPersetujuanIzinPrinsip ?? '')
              .toString()
              .isNotEmpty
          ? DateStringFormatter.forOutputDate(
              _detailAgunanTambahan?.tanggalPersetujuanIzinPrinsip ?? '',
            )
          : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalPersetujuanIzinPrinsipController.text.length,
      );

    tanggalPenilaianController
      ..text =
          (_detailAgunanTambahan?.tanggalPenilaian ?? '').toString().isNotEmpty
              ? DateStringFormatter.forOutputDate(
                  _detailAgunanTambahan?.tanggalPenilaian ?? '',
                )
              : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalPenilaianController.text.length,
      );

    tanggalLaporanController
      ..text =
          (_detailAgunanTambahan?.tanggalLaporan ?? '').toString().isNotEmpty
              ? DateStringFormatter.forOutputDate(
                  _detailAgunanTambahan?.tanggalLaporan ?? '',
                )
              : ''
      ..selection = TextSelection.collapsed(
        offset: tanggalLaporanController.text.length,
      );
  }

  void setStatusKepemilikan(String value) {
    statusKepemilikanController.text = value;
    notifyListeners();
  }

  void setJenisPengikatan(String value) {
    jenisPengikatanController.text = value;
    notifyListeners();
  }

  void setPermukaanTanah(String value) {
    permukaanTanahController.text = value;
    notifyListeners();
  }

  void setBentukTanah(String value) {
    bentukTanahController.text = value;
    notifyListeners();
  }

  void setJenisSertifikat(String value) {
    jenisSertifikatController.text = value;
    notifyListeners();
  }

  void setNoJenisSertifikat(String value) {
    noJenisSertifikatController.text = value;
    notifyListeners();
  }

  void setNamaKJPP(String value) {
    namaKJPPController.text = value;
    notifyListeners();
  }

  void setTanggalPersetujuanIzinPrinsip(String value) {
    tanggalPersetujuanIzinPrinsipController.text = value;
    notifyListeners();
  }

  void setTanggalPenilaian(String value) {
    tanggalPenilaianController.text = value;
    notifyListeners();
  }

  void setTanggalLaporan(String value) {
    tanggalLaporanController.text = value;
    notifyListeners();
  }

  void updateNjopPerMeter() {
    int tempNjop = int.parse(njopController.text.replaceAll('.', ''));
    int tempLuasTanah = int.parse(luasTanahController.text.replaceAll('.', ''));

    njopPerMeterController.text = RupiahFormatter.formatWithOutRp(
      (tempNjop / tempLuasTanah).toString(),
    );
    notifyListeners();
  }

  void clearFotoKunjungan(int index) {
    urlAgunanTambahan.removeAt(index);
    listFotoKunjungan.removeAt(index);
    notifyListeners();
  }

  void updatePostalCode(PostalCodeModel val) {
    selectedPostalCode = val;
    kodePosController.text =
        '${val.postalCode}, ${val.province}, ${val.city}, ${val.district}, ${val.village}';
    notifyListeners();
  }

  void updateTagloc(Map<String, dynamic> data) {
    LatLng tempLatLng = data['latLng'];

    selectedLatLng = '${tempLatLng.latitude}, ${tempLatLng.longitude}';

    tagLocationController
      ..text = data['address']
      ..selection = TextSelection.collapsed(
        offset: tagLocationController.text.length,
      );

    notifyListeners();
  }

  void openFile({
    required BuildContext context,
    required String url,
    String type = '',
  }) {
    if (url.contains('png') || url.contains('jpg') || url.contains('jpeg')) {
      openDialog(
        context: context,
        child: Image.network(url),
      );
    } else if (url.contains('pdf')) {
      openDialog(
        context: context,
        child: SfPdfViewer.network(url),
      );
    } else {
      openDialog(
        context: context,
        child: Text('Invalid File Format! $url'),
      );
    }
  }

  void openDialog({required BuildContext context, required Widget child}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: child,
            ),
          ),
        );
      },
    );
  }

  void clearDocumentAgunan(String label) {
    switch (label) {
      case 'Upload Sertifikat Kepemilikan':
        urlDocKepemilikanPublic = null;
        urlDocKepemilikan = null;
        break;
      case 'Upload Bukti Bayar PBB Terakhir':
        urlBuktiPbb = null;
        urlBuktiPbbPublic = null;
        break;
      default:
    }
  }

  Future fetchDetailAgunanTambahan() async {
    final response = await runBusyFuture(
      _agunanTambahanAPI.fetchAgunanTambahanTanahDetail(
        id: int.parse(id),
        prakarsaId: prakarsaId,
      ),
    );

    await response.fold(
      (l) => null,
      (res) async {
        _detailAgunanTambahan = res;

        if ((detailAgunanTambahan?.pathBuktiBayarPBBTerakhir ?? [])
            .isNotEmpty) {
          for (String element
              in detailAgunanTambahan?.pathBuktiBayarPBBTerakhir ?? []) {
            urlBuktiPbbPublic = await _getPublicFile(element);
            urlBuktiPbb = element;
          }
        }

        if ((detailAgunanTambahan?.pathSertifikatKepemilikan ?? '')
            .isNotEmpty) {
          urlDocKepemilikan =
              detailAgunanTambahan?.pathSertifikatKepemilikan ?? '';
          urlDocKepemilikanPublic = await _getPublicFile(
            detailAgunanTambahan?.pathSertifikatKepemilikan ?? '',
          );
        }

        if ((detailAgunanTambahan?.pathFotoAgunanTambahan ?? []).isNotEmpty) {
          for (PathFotoAgunanTambahan element
              in detailAgunanTambahan!.pathFotoAgunanTambahan!) {
            urlAgunanTambahan.add(element.path ?? '');
            listFotoKunjungan.add(
              FotoKunjunganModel(
                imageUrl: await _getPublicFile(element.path ?? ''),
                tagLocation: {
                  'latLng': element.tagLocation?.latLng ?? '',
                  'name': element.tagLocation?.name ?? '',
                },
                date: element.photoName,
                address: element.tagLocation?.name ?? '',
              ),
            );
          }
        }
      },
    );
    notifyListeners();
  }

  Future validateInputs({
    required bool isSavedDrafts,
    required String tipePeniaian,
  }) async {
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
      res = await addAgunanTambahan(isSavedDrafts, tipePeniaian);
    }

    return res;
  }

  Future<String> addAgunanTambahan(bool isDraft, String tipe) async {
    final res = (_detailAgunanTambahan?.id ?? '').isEmpty
        ? await _agunanTambahanAPI.addAgunanTambahan(
            jenisAgunan: 'tanah',
            payload: generatePayload(isDraft, tipe),
          )
        : await _agunanTambahanAPI.updateAgunanTambahan(
            jenisAgunan: 'tanah',
            payload: generatePayload(isDraft, tipe),
          );

    res.fold(
      (errorMsg) => _showErrorDialogForm(),
      (id) {
        updateIdAgunan(id);
      },
    );

    return idAgunan ?? '';
  }

  Future showSuccessDialog(
    bool isSavedDrafts,
  ) async {
    await _dialogService
        .showCustomDialog(
      variant: DialogType.baseImage,
      data: {
        'imageAsset': ImageConstants.successVerification,
      },
      title:
          isSavedDrafts ? 'Data Disimpan Sementara' : 'Data Berhasil Disimpan',
      description: isSavedDrafts
          ? 'Pastikan lengkapi seluruh data agunan Tambahan'
          : 'Data telah berhasil disimpan di Sistem',
      mainButtonTitle: 'Sip, mengerti',
    )
        .then(
      (_) {
        navigateBack(isPassed: true);
        if ((_detailAgunanTambahan?.id ?? '').isEmpty) {
          navigateTo(ConstantPageRoute.detailAgunanTambahan);
        }
      },
    );
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

  Map<String, dynamic> generatePayload(
    bool isDraft,
    String tipeJenisPenilaian,
  ) {
    return {
      'prakarsaId': prakarsaId,
      'isDraft': isDraft,
      'jenisPengikatan': jenisPengikatanController.text,
      if (tipeJenisPenilaian != 'Penilaian Internal')
        'namaKjpp':
            namaKJPPController.text.isEmpty ? '' : namaKJPPController.text,
      if (tipeJenisPenilaian != 'Penilaian Internal')
        'nomorPenilaian': nomorPenilaianController.text.isEmpty
            ? ''
            : nomorPenilaianController.text,
      if (tipeJenisPenilaian != 'Penilaian Internal')
        'tanggalLaporan': tanggalLaporanController.text.isEmpty
            ? ''
            : DateStringFormatter.forInputDate(
                tanggalLaporanController.text,
              ),
      if (tipeJenisPenilaian != 'Penilaian Internal')
        'tanggalPenilaian': tanggalPenilaianController.text.isEmpty
            ? ''
            : DateStringFormatter.forInputDate(
                tanggalPenilaianController.text,
              ),
      if (tipeJenisPenilaian != 'Penilaian Internal')
        'nomorPersetujuanIzinPrinsip':
            nomorPersetujuanIzinPrinsipController.text.isEmpty
                ? ''
                : nomorPersetujuanIzinPrinsipController.text,
      if (tipeJenisPenilaian != 'Penilaian Internal')
        'tanggalPersetujuanIzinPrinsip':
            tanggalPersetujuanIzinPrinsipController.text.isEmpty
                ? ''
                : DateStringFormatter.forInputDate(
                    tanggalPersetujuanIzinPrinsipController.text,
                  ),
      'luasTanah': int.parse(luasTanahController.text.replaceAll('.', '')),
      'NOP': noSPPTController.text,
      'jenisSertifikat': jenisSertifikatController.text,
      'numSertifikat': noJenisSertifikatController.text,
      'namaPemilik': namaPemilikController.text,
      'jatuhTempo': jatuhTempoController.text,
      'pathBuktiBayarPBBTerakhir': urlBuktiPbb != null ? [urlBuktiPbb] : [],
      'pathFotoAgunanTambahan': List.generate(
        listFotoKunjungan.length,
        (index) => {
          'path': urlAgunanTambahan[index],
          'photoName': listFotoKunjungan[index].title,
          'tagLocation': {
            'latLng': listFotoKunjungan[index].tagLocation?['latLng'] ?? '',
            'name': listFotoKunjungan[index].address,
          },
        },
      ),
      'detail': tagLocationController.text,
      'postalCode': selectedPostalCode?.postalCode ?? '',
      'province': selectedPostalCode?.province ?? '',
      'city': selectedPostalCode?.city ?? '',
      'district': selectedPostalCode?.district ?? '',
      'village': selectedPostalCode?.village ?? '',
      'rt': rtController.text,
      'rw': rwController.text,
      'jenisPenilaian': tipeJenisPenilaian.toString(),
      'statusKepemilikan': statusKepemilikanController.text,
      'permukaanTanah': permukaanTanahController.text,
      'bentukTanah': bentukTanahController.text,
      'batasBarat': batasBaratController.text,
      'batasUtara': batasUtaraController.text,
      'batasTimur': batasTimurController.text,
      'batasSelatan': batasSelatanController.text,
      'alamatSesuaiSertifikat': alamatController.text,
      'NJOP': int.parse(njopController.text.replaceAll('.', '')),
      'pathSertifikatKepemilikan': urlDocKepemilikan ?? '',
      if ((_detailAgunanTambahan?.id ?? '').isNotEmpty)
        'id': _detailAgunanTambahan?.id ?? '',
    };
  }

  Future uploadDokumenAgunan(BuildContext ctx, String label) async {
    final res = await _mediaService.getMultiFileType();

    if (res != null) {
      if (isImageOrPdf(res.extension!)) {
        loadingCustomDialog(ctx);
        _setDokumenAgunan(res, label);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
        );
      }
    }
    notifyListeners();
  }

  Future _setDokumenAgunan(PlatformFile file, String label) async {
    final res = await runBusyFuture(
      _masterAPI.uploadFile(
        file: file,
      ),
    );

    res.fold(
      (errorMessage) => _showErrorDialog(errorMessage),
      (url) async {
        switch (label) {
          case 'Upload Sertifikat Kepemilikan':
            urlDocKepemilikan = url;
            urlDocKepemilikanPublic = await _getPublicFile(url);
            break;
          case 'Upload Bukti Bayar PBB Terakhir':
            urlBuktiPbb = url;
            urlBuktiPbbPublic = await _getPublicFile(url);
            break;
          default:
        }
        _navigationService.back();
        notifyListeners();
      },
    );
  }

  Future uploadFotoKunjungan(BuildContext ctx) async {
    final res = await _mediaService.getMultiFileType();

    if (res != null) {
      if (isImageOrPdf(res.extension!)) {
        loadingCustomDialog(ctx);
        _setFotoKunjungan(res);
        notifyListeners();
      } else {
        _showErrorDialog(
          'File yang diperbolehkan hanya jpg, jpeg, png atau pdf!',
        );
      }
    }
    notifyListeners();
  }

  Future _setFotoKunjungan(PlatformFile file) async {
    final res = await runBusyFuture(
      _masterAPI.uploadFile(
        file: file,
      ),
    );

    res.fold(
      (errorMessage) => _showErrorDialog(errorMessage),
      (url) async {
        urlAgunanTambahan.add(url);
        var temp = await _getPublicFile(url);
        final outputFormat = DateFormat('dd MMM yyyy', 'id');
        String date = outputFormat.format(dateNow);
        listFotoKunjungan.add(
          FotoKunjunganModel(
            imageUrl: temp,
            date: date,
            address: tagLocationController.text,
            tagLocation: {
              'latLng': selectedLatLng,
            },
          ),
        );
        _navigationService.back();
        notifyListeners();
      },
    );
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

  Future _showErrorDialog(String errorMessage) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.error,
      title: 'Gagal',
      description: errorMessage,
      mainButtonTitle: 'COBA LAGI',
    );
  }

  void updateIdAgunan(String val) {
    idAgunan = val;
    notifyListeners();
  }
}
