import 'package:flutter/material.dart';

import '../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../../application/helpers/rupiah_formatter.dart';
import '../../../../../../../../../../application/models/informasi_pengurus_model.dart';
import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../../../../../../../../../shared/thick_light_grey_divider.dart';

class PengurusCVBody extends StatelessWidget {
  final InformasiPengurusModel data;
  const PengurusCVBody({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              title: 'Status Perkawinan',
              value: data.maritalStatus ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Nomor KK',
              value: data.kkNum ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Tanggal KK',
              value: data.kkDate != null
                  ? DateStringFormatter.forDetailPrakarsaDate(
                      data.kkDate ?? '',
                    )
                  : '-',
            ),
          ],
        ),
        if (data.maritalStatus == Common.kawin)
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. Akta Nikah',
                value: data.marriageNum ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal Akta Nikah',
                value: data.marriageDate == null
                    ? '-'
                    : DateStringFormatter.forDetailPrakarsaDate(
                        data.marriageDate,
                      ),
              ),
            ],
          ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'No. Handphone',
              value: data.phoneNum ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Email',
              value: data.email ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Alamat KTP',
              value: data.detail ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Kode Pos',
              value: data.postalCode ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Provinsi',
              value: data.province ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Kota',
              value: data.city ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Kecamatan',
              value: data.district ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'Kelurahan',
              value: data.village ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'RT',
              value: data.rt ?? '-',
            ),
            DetailPrakarsaItem(
              title: 'RW',
              value: data.rw ?? '-',
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Nominal Saham',
              value: data.shareNominal == null
                  ? '-'
                  : RupiahFormatter.format(data.shareNominal),
            ),
            DetailPrakarsaItem(
              title: 'Lembar Saham',
              value: (data.shares ?? '-').toString(),
            ),
          ],
        ),
        RowItemDetail(
          listWidget: [
            DetailPrakarsaItem(
              title: 'Presentase Saham',
              value: data.sharePercentage == null
                  ? '-'
                  : '${double.parse(data.sharePercentage).toString()} %',
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 14.0),
          child: ThickLightGreyDivider(
            verticalPadding: 0.0,
          ),
        ),
        if (data.maritalStatus == Common.kawin)
          BaseDetailSection(
            title: 'Identitas Pasangan',
            content: Column(
              children: [
                RowItemDetail(
                  listWidget: [
                    DetailPrakarsaItem(
                      title: 'No. KTP Pasangan',
                      value: data.spouseKtpNum ?? '-',
                    ),
                    DetailPrakarsaItem(
                      title: 'Nama Lengkap Pasangan',
                      value: data.spouseFullname ?? '-',
                    ),
                  ],
                ),
                RowItemDetail(
                  listWidget: [
                    DetailPrakarsaItem(
                      title: 'Tempat Lahir Pasangan',
                      value: data.spousePlaceOfBirth ?? '-',
                    ),
                    DetailPrakarsaItem(
                      title: 'Tanggal Lahir Pasangan',
                      value: data.spouseDateOfBirth != null
                          ? DateStringFormatter.forDetailPrakarsaDate(
                              data.spouseDateOfBirth ?? '',
                            )
                          : '-',
                    ),
                  ],
                ),
              ],
            ),
          )
        else if (data.maritalStatus == Common.ceraiHidup)
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. Akta Cerai',
                value: data.divorceNum ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal Akta Nikah',
                value: data.divorceDate == null
                    ? '-'
                    : DateStringFormatter.forDetailPrakarsaDate(
                        data.divorceDate,
                      ),
              ),
            ],
          )
        else if (data.maritalStatus == Common.belumKawin)
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. Surat Keterangan Belum Menikah',
                value: data.notMarriageNum ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal Surat Keterangan Belum Menikah',
                value: data.notMarriageDate == null
                    ? '-'
                    : DateStringFormatter.forDetailPrakarsaDate(
                        data.notMarriageDate,
                      ),
              ),
            ],
          )
        else if (data.maritalStatus == Common.ceraiMati)
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. Certifikat Kematian',
                value: data.deathCertificateNum ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal Sertifikat Kematian',
                value: data.deathCertificateDate == null
                    ? '-'
                    : DateStringFormatter.forDetailPrakarsaDate(
                        data.deathCertificateDate ?? '',
                      ),
              ),
            ],
          ),
      ],
    );
  }
}
