import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../application/helpers/status_pengajuan_formatter.dart';
import 'detail_debitur_viewmodel.dart';

class DetailDebiturHeader extends HookViewModelWidget<DetailDebiturViewModel> {
  const DetailDebiturHeader({Key? key}) : super(key: key);

  @override
  // ignore: long-method
  Widget buildViewModelWidget(
    BuildContext context,
    DetailDebiturViewModel viewModel,
  ) {
    final header = getHeader(viewModel);

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
          child: headerContent(header: header),
        ),
      ),
    );
  }

  // ignore: always_declare_return_types
  getHeader(DetailDebiturViewModel vm) {
    if (vm.codeTable == 1 || vm.codeTable == 4) {
      if (vm.debiturPerorangan != null) {
        return vm.debiturPerorangan!.header;
      }
    } else {
      if (vm.debiturPerusahaan != null) {
        return vm.debiturPerusahaan!.header;
      }
    }
  }

  Column headerContent({required dynamic header}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: CustomColor.primaryBlue,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CustomColor.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        header.inisial!,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      header.nama!,
                      style: titleStyle20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 134.0,
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: StatusPengajuanFormatter.getLabelColor(
                  header.status!,
                ),
              ),
              child: Center(
                child: Text(
                  StatusPengajuanFormatter.convertStatus(
                    header.status!,
                  ),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: StatusPengajuanFormatter.getTextColor(
                      header.status!,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            buildStatus(
              'Nominal Pengajuan',
              RupiahFormatter.format(header.nominalPengajuan!),
            ),
            buildStatus(
              'Tgl Pengajuan',
              header.tanggalPengajuan!,
            ),
            buildStatus(
              'Jenis Kredit',
              header.jenisKredit!,
            ),
            buildStatus(
              'Bentuk Usaha',
              header.bentukUsaha!,
            ),
            buildStatus(
              'CB',
              header.communityBranch!,
            ),
            buildStatus(
              'Pemrakarsa',
              header.pemrakarsa!,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStatus(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ),
      margin: const EdgeInsets.only(
        right: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: CustomColor.lightGrey,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
