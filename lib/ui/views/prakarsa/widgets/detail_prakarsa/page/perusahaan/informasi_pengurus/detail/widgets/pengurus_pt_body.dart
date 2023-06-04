import 'package:flutter/material.dart';

import '../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../application/models/informasi_pengurus_model.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../../../../../../../../../shared/thick_light_grey_divider.dart';

class PengurusPTBody extends StatelessWidget {
  final InformasiPengurusModel data;
  const PengurusPTBody({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Nama Pengurus Sesuai KTP',
              value: data.fullName ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Posisi Pengurus',
              value: data.jobDescription ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Nomor KTP Pengurus',
              value: data.ktpNum ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Nomor NPWP',
              value: data.npwpNum ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Jenis Kelamin',
              value: data.gender ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Tempat Lahir',
              value: data.placeOfBirth ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Tanggal Lahir',
              value: data.dateOfBirth != null
                  ? DateStringFormatter.forDetailPrakarsaDate(
                      data.dateOfBirth ?? '',
                    )
                  : '-',
            ),
            DetailPrakarsaItem(
              title: 'No. Handphone',
              value: data.phoneNum ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Email',
              value: data.email ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Alamat KTP',
              value: data.detail ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Kode Pos',
              value: data.postalCode ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Provinsi',
              value: data.province ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Kota',
              value: data.city ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Kecamatan',
              value: data.district ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Kelurahan',
              value: data.village ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'RT',
              value: data.rt ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'RW',
              value: data.rw ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Nominal Saham',
              value: data.shareNominal == null
                  ? '-'
                  : RupiahFormatter.format(data.shareNominal),
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Lembar Saham',
              value: (data.shares ?? '-').toString(),
            ),
            DetailPrakarsaItem(
              title: 'Presentase Saham',
              value: data.sharePercentage == null
                  ? '-'
                  : '${double.parse(data.sharePercentage).toString()} %',
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 14, top: 8),
          child: ThickLightGreyDivider(
            verticalPadding: 0.0,
          ),
        ),
      ],
    );
  }
}
