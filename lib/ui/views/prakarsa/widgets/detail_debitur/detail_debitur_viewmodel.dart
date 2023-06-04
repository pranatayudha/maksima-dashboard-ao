import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../application/app/app.locator.dart';
import '../../../../../application/app/constants/custom_color.dart';
import '../../../../../application/app/constants/icon_constants.dart';
import '../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../application/mixins/route_mixin.dart';
import '../../../../../application/models/detail_debitur_perorangan.dart';
import '../../../../../application/models/detail_debitur_perusahaan.dart';
import '../../../../../application/models/summary_screening_debitur.dart';
import '../../../../../application/models/summary_screening_perusahaan.dart';
import '../../../../../application/models/summary_screening_spouse.dart';
import '../../../../../infrastructure/apis/master_api.dart';
import '../../../../../infrastructure/apis/prakarsa_api.dart';
import '../../../../shared/base_dialog.dart';
import '../../../../shared/custom_button.dart';

class DetailDebiturViewModel extends BaseViewModel with RouteMixin {
  final _prakarsaAPI = locator<PrakarsaAPI>();
  final _masterAPI = locator<MasterAPI>();

  final String prakarsaId;
  final int codeTable;

  DetailDebiturViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  Future initialize() async {
    breadCrum = localDBService.getRoutes();

    await fetchDetailDebitur();
  }

  DetailDebiturPerorangan? _debiturPerorangan;
  DetailDebiturPerorangan? get debiturPerorangan => _debiturPerorangan;
  SummaryScreeningDebitur? _screeningDebitur;
  SummaryScreeningDebitur get screeningDebitur => _screeningDebitur!;
  SummaryScreeningSpouse? _screeningSpouse;
  SummaryScreeningSpouse? get screeningSpouse => _screeningSpouse;

  DetailDebiturPerusahaan? _debiturPerusahaan;
  DetailDebiturPerusahaan? get debiturPerusahaan => _debiturPerusahaan;
  SummaryScreeningPerusahaan? _screeningPerusahaan;
  SummaryScreeningPerusahaan? get screeningPerusahaan => _screeningPerusahaan;

  List<String> preScreeningPath = [];
  List<String> preScreeningPengurusPath = [];
  List<String> preScreeningSpousePath = [];

  Future fetchDetailDebitur() async {
    if (codeTable == 1 || codeTable == 4) {
      final res = await runBusyFuture(
        _prakarsaAPI.fetchDetailDebiturPerorangan(prakarsaId: prakarsaId),
      );

      res.fold(
        (error) => log('error', name: 'Error Debitur'),
        (debiturPerorangan) async {
          _debiturPerorangan = debiturPerorangan;
          if (_debiturPerorangan!.preScreening!.summary![1] == null) {
            _screeningDebitur = SummaryScreeningDebitur.fromJson(
              _debiturPerorangan!.preScreening!.summary![0],
            );
            preScreeningPath.add(
              await _getPublicFile(
                _screeningDebitur?.dukcapil?.reason?[4].path ?? '',
              ),
            );
          } else {
            _screeningDebitur = SummaryScreeningDebitur.fromJson(
              _debiturPerorangan!.preScreening!.summary![0],
            );
            _screeningSpouse = SummaryScreeningSpouse.fromJson(
              _debiturPerorangan!.preScreening!.summary![1],
            );
            preScreeningPath.add(
              await _getPublicFile(
                _screeningDebitur?.dukcapil?.reason?[4].path ?? '',
              ),
            );
            preScreeningPath.add(
              await _getPublicFile(
                _screeningSpouse?.dukcapil?.reason?[4].path ?? '',
              ),
            );
          }
          notifyListeners();
        },
      );
    } else {
      final res = await runBusyFuture(
        _prakarsaAPI.fetchDetailDebiturPerusahaan(prakarsaId: prakarsaId),
      );

      res.fold(
        (error) => log('error', name: 'Error Debitur'),
        (r) async {
          _debiturPerusahaan = r;
          _screeningPerusahaan = SummaryScreeningPerusahaan.fromJson(
            _debiturPerusahaan!.preScreening!.summary[0]['data'],
          );
          for (int i = 1;
              i < debiturPerusahaan?.preScreening?.summary.length;
              i++) {
            preScreeningPengurusPath.add(
              await _getPublicFile(
                debiturPerusahaan?.preScreening?.summary[i]['data']['dukcapil']
                    ['reason'][4]['path'],
              ),
            );
            if (debiturPerusahaan?.preScreening?.summary[i]['spouseData'] !=
                null) {
              preScreeningSpousePath.add(
                await _getPublicFile(
                  debiturPerusahaan?.preScreening?.summary[i]['spouseData']
                      ['dukcapil']['reason'][4]['path'],
                ),
              );
            } else {
              preScreeningSpousePath.add('');
            }
          }
          notifyListeners();
        },
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

  void downloadFileSlikPerusahaan(String companyName, BuildContext context) {
    String slikBase64 = screeningPerusahaan?.slik?.path ?? '';
    if (slikBase64 != '') {
      downloadSlik(slikBase64, companyName);
    } else {
      showDialogSlikNotAvailable(context);
    }
  }

  void downloadFileSlikPengurus(
    BuildContext context,
    dynamic screeningPengurus,
  ) {
    String slikBase64 = screeningPengurus['slik']['path'];
    if (slikBase64 != '') {
      downloadSlik(slikBase64, screeningPengurus['name']);
    } else {
      showDialogSlikNotAvailable(context);
    }
  }

  void downloadFileSlikPerorangan(
    int index,
    String name,
    BuildContext context,
  ) {
    String slikBase64 = index == 0
        ? _screeningDebitur?.slik?.path ?? ''
        : _screeningSpouse?.slik?.path ?? '';
    if (slikBase64 != '') {
      downloadSlik(slikBase64, name);
    } else {
      showDialogSlikNotAvailable(context);
    }
  }

  void downloadSlik(String base64, String name) {
    String url = 'data:application/zip;base64,$base64';
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = 'SLIK-$name.zip';
    anchorElement.click();
  }

  void showDialogSlikNotAvailable(BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return BaseDialog(
          hideButtonClose: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  child: Image.asset(IconConstants.slikReject, scale: 2),
                ),
                SizedBox(
                  width: 400,
                  child: Text(
                    'iDeb SLIK Tidak Tersedia',
                    textAlign: TextAlign.center,
                    style: titleStyle20,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  width: 400,
                  child: Text(
                    'Silahkan kordinasi dengan pihak developer',
                    style: valueStatusStyle,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: CustomColor.primaryBlue,
                          ),
                          child: Center(
                            child: Text(
                              'Ok',
                              style: titleStyle14.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
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

  void openPrescreeningNote({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Catatan Pre-Screening',
                          style: titleStyle20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(IconConstants.x, height: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                if ((debiturPerorangan?.preScreening?.notes?.dukcapil ?? '')
                        .isNotEmpty ||
                    (debiturPerusahaan?.preScreening?.notes?.dukcapil ?? '')
                        .isNotEmpty) ...[
                  Text(
                    'Catatan Dukcapil',
                    style: titleValue,
                  ),
                  Text(
                    (codeTable == 1 || codeTable == 4)
                        ? debiturPerorangan?.preScreening?.notes?.dukcapil ??
                            '-'
                        : debiturPerusahaan?.preScreening?.notes?.dukcapil ??
                            '-',
                    style: valueStyle,
                  ),
                ],
                if ((debiturPerorangan?.preScreening?.notes?.slik ?? '')
                        .isNotEmpty ||
                    (debiturPerusahaan?.preScreening?.notes?.slik ?? '')
                        .isNotEmpty) ...[
                  Text(
                    'Catatan Slik',
                    style: titleValue,
                  ),
                  Text(
                    (codeTable == 1 || codeTable == 4)
                        ? debiturPerorangan?.preScreening?.notes?.slik ?? '-'
                        : debiturPerusahaan?.preScreening?.notes?.slik ?? '-',
                    style: valueStyle,
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CustomButton(
                    label: 'Sip, mengerti',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    isBusy: false,
                    color: CustomColor.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
