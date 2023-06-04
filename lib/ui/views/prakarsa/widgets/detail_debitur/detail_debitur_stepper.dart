import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../application/app/constants/page_route.dart';
import '../../../../../application/app/constants/text_style_constants.dart';
import '../../../../shared/task_item.dart';
import '../../../../shared/task_item_revisi.dart';
import '../../../../shared/thick_light_grey_divider.dart';
import 'detail_debitur_viewmodel.dart';

class DetailDebiturStepper extends HookViewModelWidget<DetailDebiturViewModel> {
  const DetailDebiturStepper({Key? key}) : super(key: key);

  @override
  // ignore: long-method
  Widget buildViewModelWidget(
    BuildContext context,
    DetailDebiturViewModel viewModel,
  ) {
    final stepper = getStepper(viewModel);

    return Padding(
      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: stepperContent(
            stepper: stepper,
            vm: viewModel,
            ctx: context,
          ),
        ),
      ),
    );
  }

  // ignore: always_declare_return_types
  getStepper(DetailDebiturViewModel vm) {
    if (vm.codeTable == 1 || vm.codeTable == 4) {
      if (vm.debiturPerorangan != null) {
        return vm.debiturPerorangan!.stepper;
      }
    } else {
      if (vm.debiturPerusahaan != null) {
        return vm.debiturPerusahaan!.stepper;
      }
    }
  }

  ListView stepperContent({
    required dynamic stepper,
    required DetailDebiturViewModel vm,
    required BuildContext ctx,
  }) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          'Status Pengajuan',
          style: titleStyle20,
        ),
        const ThickLightGreyDivider(),
        const SizedBox(
          height: 10,
        ),
        TaskItem(
          task: 'Isi Pre-Screening Nasabah',
          currentTask: stepper.preScreeningApproved!,
          statusDone: stepper.preScreeningApproved,
          isFailed: false,
        ),
        _buildPreScreeningDisetujui(vm, stepper),
        _buildStepperIsiAnalisaPinjamanNasabah(vm, stepper),
        _buildStepperHasilAnalisaPinjaman(vm, stepper),
        if ((stepper.revisi ?? []).length > 0)
          for (var i = 0; i < stepper.revisi.length; i++)
            _buildStepperRevisi(i, ctx, stepper),
        _buildStepperVerifikasiADK(stepper),
        if (stepper.approvalStep == 1)
          const TaskItem(
            task: 'Putusan Kredit',
            currentTask: 0,
            statusDone: 0,
            isFailed: false,
          ),
        if (stepper.approvalStep == 3 || stepper.approvalStep == 4) ...[
          _buildStepperVerifikasiCBL(stepper),
          _buildStepperPutusanPusat(vm, stepper),
        ],
        if (vm.codeTable == 4 || stepper.approvalStep == 2)
          _buildStepperPutusanCBL(stepper),
        _buildStepperOfferingLetter(stepper),
        _buildStepperAkadKredit(stepper),
        _buildStepperFasilitas(stepper),
      ],
    );
  }

  TaskItem _buildPreScreeningDisetujui(
    DetailDebiturViewModel vm,
    dynamic stepper,
  ) {
    return TaskItem(
      task: 'Pre-Screening Disetujui',
      description: 'Pre-Screening Perusahaan telah disetujui',
      textButtonLabel: 'Lihat Hasil Pre-Screening',
      onTextButtonLabelPressed: () =>
          vm.navigateTo(ConstantPageRoute.detailPrakarsaPage),
      currentTask: stepper.preScreeningApproved!,
      statusDone: stepper.preScreeningApproved,
      isFailed: false,
      forceVisibleTextButton: true,
      hasDescription: true,
    );
  }

  TaskItem _buildStepperIsiAnalisaPinjamanNasabah(
    DetailDebiturViewModel vm,
    dynamic stepper,
  ) {
    return TaskItem(
      task: 'Isi Analisa Pinjaman Nasabah',
      description: stepper.analisaPinjamanNasabah == 1
          ? 'Info Prakarsa telah lengkap, Mohon review kelengkapan data prakarsa dan verifikasi'
          : '',
      textButtonLabel:
          stepper.analisaPinjamanNasabah == 1 ? 'Lengkapi Dokumen' : '',
      onTextButtonLabelPressed: () =>
          vm.navigateTo(ConstantPageRoute.detailPrakarsaPage),
      currentTask: stepper.analisaPinjamanNasabah!,
      statusDone: stepper.analisaPinjamanNasabah,
      isFailed: false,
      forceVisibleTextButton:
          stepper.analisaPinjamanNasabah == 1 ? true : false,
      isResultButton: stepper.analisaPinjamanNasabah == 1 ? true : false,
      hasDescription: stepper.analisaPinjamanNasabah == 1 ? true : false,
    );
  }

  TaskItem _buildStepperFasilitas(dynamic stepper) {
    return TaskItem(
      task: 'Proses Pembuatan Fasilitas',
      currentTask: stepper.prosesPembuatanFasilitas!,
      statusDone: stepper.prosesPembuatanFasilitas,
      isFailed: stepper.prosesPembuatanFasilitas == 3 ? true : false,
      isLast: true,
    );
  }

  TaskItem _buildStepperAkadKredit(dynamic stepper) {
    return TaskItem(
      task: 'Proses Akad Kredit',
      currentTask: stepper.prosesAkadKredit!,
      statusDone: stepper.prosesAkadKredit,
      isFailed: false,
    );
  }

  TaskItem _buildStepperOfferingLetter(dynamic stepper) {
    return TaskItem(
      task: stepper.offeringDebitur == 3
          ? 'Offering Debitur Ditolak'
          : 'Offering Debitur',
      currentTask: stepper.offeringDebitur!,
      statusDone: stepper.offeringDebitur,
      isFailed: stepper.offeringDebitur == 3 ? true : false,
    );
  }

  TaskItem _buildStepperPutusanCBL(dynamic stepper) {
    return TaskItem(
      task: stepper.putusanKreditCBL!.status == 3
          ? 'Pemutus Menolak Memberikan Kredit'
          : 'Putusan Kredit oleh CBL',
      description: stepper.putusanKreditCBL!.status == 2 ||
              stepper.putusanKreditCBL!.status == 3
          ? stepper.putusanKreditCBL!.arguments ?? 'Disetujui'
          : 'Dokumen sedang dalam proses verifikasi oleh CBL. Sistem akan menginformasikan jika proses telah selesai',
      textButtonLabel: stepper.putusanKreditCBL!.status == 2
          ? 'Telah diverifikasi oleh CBL'
          : null,
      // ignore: no-empty-block
      onTextButtonLabelPressed: () {},
      currentTask: stepper.putusanKreditCBL!.status!,
      statusDone: stepper.putusanKreditCBL!.status,
      isFailed: stepper.putusanKreditCBL!.status == 3 ? true : false,
      forceVisibleTextButton:
          stepper.putusanKreditCBL!.status == 2 ? true : false,
      hasDescription: stepper.putusanKreditCBL!.status == 3 ||
              stepper.putusanKreditCBL!.status == 2
          ? true
          : false,
      colorTextButton: const Color(0xff38BAA7),
    );
  }

  TaskItem _buildStepperPutusanPusat(
    DetailDebiturViewModel vm,
    dynamic stepper,
  ) {
    return TaskItem(
      task: stepper.putusanKreditKadiv!.status == 3
          ? 'Pemutus Menolak Memberikan Kredit'
          : stepper.approvalStep! == 3
              ? 'Putusan Kredit oleh Wakadiv'
              : stepper.approvalStep! == 4
                  ? 'Putusan Kredit oleh Kadiv'
                  : 'Putusan Kredit',
      description: stepper.putusanKreditKadiv!.arguments!,
      textButtonLabel:
          stepper.putusanKreditKadiv!.status! == 2 ? 'Lihat PTK' : null,
      // onTextButtonLabelPressed: stepper.putusanKreditKadiv!.status! == 2
      //     ? vm.navigateToHasilAnalisaPinjaman
      //     : null,
      currentTask: stepper.putusanKreditKadiv!.status!,
      statusDone: stepper.putusanKreditKadiv!.status!,
      isFailed: stepper.putusanKreditKadiv!.status! == 3 ? true : false,
      forceVisibleTextButton:
          stepper.putusanKreditKadiv!.status! == 2 ? true : false,
      hasDescription: stepper.putusanKreditKadiv!.status! == 3 ||
              stepper.putusanKreditKadiv!.status! == 2
          ? true
          : false,
    );
  }

  TaskItem _buildStepperVerifikasiCBL(dynamic stepper) {
    return TaskItem(
      task: 'Verifikasi CBL',
      description: stepper.verifikasiCBL!.status! == 2
          ? stepper.verifikasiCBL!.arguments!
          : 'Dokumen sedang dalam proses verifikasi oleh CBL. Sistem akan menginformasikan jika proses telah selesai',
      textButtonLabel: stepper.verifikasiCBL!.status! == 2
          ? 'Telah diverifikasi oleh CBL'
          : null,
      // ignore: no-empty-block
      onTextButtonLabelPressed: () {},
      currentTask: stepper.verifikasiCBL!.status!,
      statusDone: stepper.verifikasiCBL!.status!,
      isFailed: false,
      forceVisibleTextButton:
          stepper.verifikasiCBL!.status! == 2 ? true : false,
      hasDescription: stepper.verifikasiCBL!.status! == 1 ||
              stepper.verifikasiCBL!.status! == 2
          ? true
          : false,
      colorTextButton: const Color(0xff38BAA7),
    );
  }

  TaskItem _buildStepperVerifikasiADK(dynamic stepper) {
    return TaskItem(
      task: 'Verifikasi OPK',
      description: stepper.verifikasiADKCabang!.status! == 2
          ? stepper.verifikasiADKCabang!.arguments!
          : 'Dokumen sedang dalam proses verifikasi oleh OPK. Sistem akan menginformasikan jika proses telah selesai',
      textButtonLabel: stepper.verifikasiADKCabang!.status! == 2
          ? 'Telah diverifikasi oleh OPK'
          : null,
      // ignore: no-empty-block
      onTextButtonLabelPressed: () {},
      currentTask: stepper.verifikasiADKCabang!.status!,
      //vm.verifikasiADKCurrentTask,
      statusDone: stepper.verifikasiADKCabang!.status!,
      isFailed: false,
      forceVisibleTextButton: stepper.verifikasiADKCabang!.status! == 1 ||
              stepper.verifikasiADKCabang!.status! == 2
          ? true
          : false,
      hasDescription: stepper.verifikasiADKCabang!.status! == 1 ||
              stepper.verifikasiADKCabang!.status! == 2
          ? true
          : false,
      colorTextButton: const Color(0xff38BAA7),
    );
  }

  Column _buildStepperRevisi(
    int i,
    BuildContext context,
    dynamic stepper,
  ) {
    return Column(
      children: [
        TaskItemRevisi(
          task: stepper.revisi[i]['checker'][0] != 'p'
              ? 'Revisi ${stepper.revisi[i]['checker'].split(' ')[0].toUpperCase()} - ${stepper.revisi[i]['checker'].split(' ')[1]}'
              : 'Revisi Pemutus ${stepper.revisi[i]['checker'].split(' ')[1]}',
          textButtonLabel: 'Lihat Catatan Revisi',
          // ignore: no-empty-block
          onTextButtonLabelPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => RevisiDetailView(
            //       ticket: stepper.revisi[i]['revisionTicket'],
            //       checker: stepper.revisi[i]['checker'][0] == 'a'
            //           ? 'adk'
            //           : stepper.revisi[i]['checker'][0] == 'c'
            //               ? 'cbl'
            //               : 'pemutus',
            //       id: prakarsaId,
            //       codeTable: codeTable,
            //     ),
            //   ),
            // );
          },
          isCurrentTask: stepper.revisi[i]['status'] == null ||
                  !stepper.revisi[i]['status']
              ? true
              : false,
          isDone: stepper.revisi[i]['status'] == null ||
                  !stepper.revisi[i]['status']
              ? false
              : true,
          isFailed: false,
          forceVisibleTextButton: true,
        ),
      ],
    );
  }

  TaskItem _buildStepperHasilAnalisaPinjaman(
    DetailDebiturViewModel vm,
    dynamic stepper,
  ) {
    return TaskItem(
      task: 'Hasil Analisa Pinjaman',
      description: stepper.hasilAnalisaPinjaman == 1
          ? 'Lengkapi Informasi Prakarsa Debitur agar sistem membuat PTK secara otomatis'
          : '',
      textButtonLabel: stepper.hasilAnalisaPinjaman == 2 &&
                  stepper.putusanKreditKadiv!.status != 2 ||
              stepper.hasilAnalisaPinjaman == 1
          ? 'Lihat Draft PTK'
          : null,
      // onTextButtonLabelPressed: stepper.hasilAnalisaPinjaman == 2 &&
      //             stepper.putusanKreditKadiv!.status != 2 ||
      //         stepper.hasilAnalisaPinjaman == 1
      //     ? vm.navigateToHasilAnalisaPinjaman
      //     : null,
      currentTask: stepper.hasilAnalisaPinjaman!,
      //vm.hasilAnalisaPinjamanCurrentTask,
      statusDone: stepper.hasilAnalisaPinjaman,
      isFailed: false,
      forceVisibleTextButton: stepper.hasilAnalisaPinjaman == 2 &&
              stepper.putusanKreditKadiv!.status != 2 ||
          stepper.hasilAnalisaPinjaman == 1,
      hasDescription: stepper.hasilAnalisaPinjaman == 1,
    );
  }
}
