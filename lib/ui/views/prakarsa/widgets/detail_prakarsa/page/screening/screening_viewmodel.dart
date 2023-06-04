import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../../application/app/app.locator.dart';
import '../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../application/mixins/route_mixin.dart';
import '../../../../../../../application/models/prescreening_perorangan.dart';
import '../../../../../../../application/models/prescreening_perusahaan.dart';
import '../../../../../../../application/models/summary_screening_debitur.dart';
import '../../../../../../../application/models/summary_screening_perusahaan.dart';
import '../../../../../../../application/models/summary_screening_spouse.dart';
import '../../../../../../../infrastructure/apis/master_api.dart';
import '../../../../../../../infrastructure/apis/screening_api.dart';
import '../../../../../../shared/base_dialog.dart';
import '../../../../../../shared/custom_button.dart';

class ScreeningViewModel extends BaseViewModel with RouteMixin {
  final _screeningAPI = locator<ScreeningAPI>();
  final _masterAPI = locator<MasterAPI>();

  final String prakarsaId;
  final int codeTable;
  ScreeningViewModel({
    required this.prakarsaId,
    required this.codeTable,
  });

  Future initialize() async {
    await _fetchScreening();
  }

  PrescreeningPerorangan? _screeningPerorangan;
  PrescreeningPerorangan? get screeningPerorangan => _screeningPerorangan;
  SummaryScreeningDebitur? _summaryDebitur;
  SummaryScreeningDebitur get summaryDebitur => _summaryDebitur!;
  SummaryScreeningSpouse? _summarySpouse;
  SummaryScreeningSpouse? get summarySpouse => _summarySpouse;

  PrescreeningPerusahaan? _screeningPerusahaan;
  PrescreeningPerusahaan? get screeningPerusahaan => _screeningPerusahaan;
  SummaryScreeningPerusahaan? _summaryPerusahaan;
  SummaryScreeningPerusahaan? get summaryPerusahaan => _summaryPerusahaan;

  List<String> preScreeningPath = [];
  List<String> preScreeningPengurusPath = [];
  List<String> preScreeningSpousePath = [];

  Future _fetchScreening() async {
    if (codeTable == 1 || codeTable == 4) {
      final res = await runBusyFuture(
        _screeningAPI.fetchPerorangan(prakarsaId: prakarsaId),
      );

      res.fold(
        (error) => log('error', name: 'Error Debitur'),
        (screeningPerorangan) async {
          _screeningPerorangan = screeningPerorangan;
          if (_screeningPerorangan!.summaryScreening![1] == null) {
            _summaryDebitur = SummaryScreeningDebitur.fromJson(
              _screeningPerorangan!.summaryScreening![0],
            );
            preScreeningPath.add(
              await _getPublicFile(
                _summaryDebitur?.dukcapil?.reason?[4].path ?? '',
              ),
            );
          } else {
            _summaryDebitur = SummaryScreeningDebitur.fromJson(
              _screeningPerorangan!.summaryScreening![0],
            );
            _summarySpouse = SummaryScreeningSpouse.fromJson(
              _screeningPerorangan!.summaryScreening![1],
            );
            preScreeningPath.add(
              await _getPublicFile(
                _summaryDebitur?.dukcapil?.reason?[4].path ?? '',
              ),
            );
            preScreeningPath.add(
              await _getPublicFile(
                _summarySpouse?.dukcapil?.reason?[4].path ?? '',
              ),
            );
          }
          notifyListeners();
        },
      );
    } else {
      final res = await runBusyFuture(
        _screeningAPI.fetchPerusahaan(prakarsaId: prakarsaId),
      );

      res.fold(
        (error) => log('error', name: 'Error Debitur'),
        (screeningPerusahaan) async {
          _screeningPerusahaan = screeningPerusahaan;
          _summaryPerusahaan = SummaryScreeningPerusahaan.fromJson(
            _screeningPerusahaan!.summaryScreening[0]['data'],
          );
          for (int i = 1;
              i < screeningPerusahaan.summaryScreening.length;
              i++) {
            preScreeningPengurusPath.add(
              await _getPublicFile(
                screeningPerusahaan.summaryScreening[i]['data']['dukcapil']
                    ['reason'][4]['path'],
              ),
            );
            if (screeningPerusahaan.summaryScreening[i]['spouseData'] != null) {
              preScreeningSpousePath.add(
                await _getPublicFile(
                  screeningPerusahaan.summaryScreening[i]['spouseData']
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
    String slikBase64 = _summaryPerusahaan?.slik?.path ?? '';
    if (slikBase64 != '') {
      downloadSlik(slikBase64, companyName);
    } else {
      showDialogSlikNotAvailable(context);
    }
  }

  void downloadFileSlikPengurus(
    int index,
    BuildContext context,
    bool isSpouse,
  ) {
    String slikBase64 = '';
    String fileName = '';
    if (!isSpouse) {
      final screeningPengurus =
          screeningPerusahaan!.summaryScreening[index]['data'];
      slikBase64 = screeningPengurus['slik']['path'];
      fileName = screeningPengurus['name'];
    } else {
      final screeningSpousePengurus =
          screeningPerusahaan!.summaryScreening[index]['spouseData'];
      slikBase64 = screeningSpousePengurus['slik']['path'];
      fileName = screeningSpousePengurus['name'];
    }
    if (slikBase64 != '') {
      downloadSlik(slikBase64, fileName);
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
        ? _summaryDebitur?.slik?.path ?? ''
        : _summarySpouse?.slik?.path ?? '';
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
                if ((screeningPerorangan?.notes?.dukcapil ?? '').isNotEmpty ||
                    (screeningPerusahaan?.notes?.dukcapil ?? '')
                        .isNotEmpty) ...[
                  Text(
                    'Catatan Dukcapil',
                    style: titleValue,
                  ),
                  Text(
                    (codeTable == 1 || codeTable == 4)
                        ? screeningPerorangan?.notes?.dukcapil ?? '-'
                        : screeningPerusahaan?.notes?.dukcapil ?? '-',
                    style: valueStyle,
                  ),
                ],
                if ((screeningPerorangan?.notes?.slik ?? '').isNotEmpty ||
                    (screeningPerusahaan?.notes?.slik ?? '').isNotEmpty) ...[
                  Text(
                    'Catatan Slik',
                    style: titleValue,
                  ),
                  Text(
                    (codeTable == 1 || codeTable == 4)
                        ? screeningPerorangan?.notes?.slik ?? '-'
                        : screeningPerusahaan?.notes?.slik ?? '-',
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
