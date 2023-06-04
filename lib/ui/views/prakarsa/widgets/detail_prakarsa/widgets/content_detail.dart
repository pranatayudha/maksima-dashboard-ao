import 'package:flutter/material.dart';

import '../page/dokumen_lainnya/detail/detail_dokumen_lainnya_view.dart';
import '../page/informasi_agunan/agunan_pokok/list_agunan/list_agunan_pokok_view.dart';
import '../page/informasi_agunan/agunan_tambahan/list_agunan_tambahan/list_agunan_tambahan_view.dart';
import '../page/izin_usaha/detail/detail_izin_usaha_view.dart';
import '../page/lkn/detail/detail_lkn_view.dart';
import '../page/perorangan/identitas_diri_debitur/detail/detail_identitas_diri_view.dart';
import '../page/perorangan/info_usaha/detail/detail_info_usaha_view.dart';
import '../page/perusahaan/identitas/detail/detail_identitas_perusahaan_view.dart';
import '../page/perusahaan/informasi_pengurus/list_pengurus/list_pengurus_view.dart';
import '../page/perusahaan/legalitas/detail/detail_legalitas_view.dart';
import '../page/screening/screening_view.dart';
import 'base_view.dart';

class ContentDetailPrakarsa extends StatelessWidget {
  final String selectedPage;
  final String prakarsaId;
  final int codeTable;
  final String pipelineId;
  final double width;
  final double height;
  final Function(dynamic) callBackData;
  final bool stepperStatus;
  final Function(bool) refreshStepper;
  const ContentDetailPrakarsa({
    Key? key,
    required this.selectedPage,
    required this.prakarsaId,
    required this.codeTable,
    required this.pipelineId,
    required this.callBackData,
    required this.width,
    required this.height,
    required this.stepperStatus,
    required this.refreshStepper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (selectedPage) {
      // Screening Awal
      case 'Screening Awal':
        return ScreeningView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          height: height,
        );
      // LKN
      case 'Laporan Kunjungan Nasabah':
        return DetailLKNView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          width: width,
          height: height,
        );
      // Perusahaan
      case 'Identitas Perusahaan':
        return DetailIdentitasPerusahaanView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          width: width,
          height: height,
        );
      case 'Legalitas Usaha':
        return DetailLegalitasView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          height: height,
        );
      case 'Informasi Pengurus / Pemilik':
        return ListPengurusView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          pipelineId: pipelineId,
          selectedPengurus: (data) => callBackData(data),
          height: height,
        );
      // Perorangan
      case 'Identitas Diri Debitur':
        return DetailIdentitasDiriView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          pipelineId: pipelineId,
          width: width,
          height: height,
        );
      case 'Info Usaha':
        return DetailInfoUsahaView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          pipelineId: pipelineId,
          width: width,
          height: height,
        );
      // Perusahaan dan Perorangan
      case 'Izin Usaha':
        return DetailIzinUsahaView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          height: height,
        );
      case 'Dokumen Lainnya':
        return DetailDokumenLainnyaView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          height: height,
          stepperStatus: stepperStatus,
          refreshStepper: refreshStepper,
        );
      // Agunan Pokok
      case 'Agunan Pokok':
        return ListAgunanPokokView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          pipelineId: pipelineId,
          height: height,
          selectedAgunan: (data) => callBackData(data),
        );
      // Agunan Tambahan
      case 'Agunan Tambahan':
        return ListAgunanTambahanView(
          prakarsaId: prakarsaId,
          codeTable: codeTable,
          pipelineId: pipelineId,
          height: height,
          selectedAgunan: (data) => callBackData(data),
        );
      default:
        return BaseView(
          height: height,
          child: const Center(
            child: Text('Coming Soon'),
          ),
        );
    }
  }
}
