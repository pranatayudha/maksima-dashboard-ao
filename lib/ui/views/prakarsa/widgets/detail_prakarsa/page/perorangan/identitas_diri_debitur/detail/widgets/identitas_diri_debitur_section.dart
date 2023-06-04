import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../../../../../../../application/app/constants/common.dart';
import '../../../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../../../../application/helpers/date_string_formatter.dart';
import '../../../../../../../../../../../application/helpers/religion_string_formatter.dart';
import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../shared/base_detail_section.dart';
import '../../../../../../../../../shared/detail_prakarsa_item.dart';
import '../../../../../../../../../shared/row_item_detail.dart';
import '../../../../../../../../../shared/thick_light_grey_divider.dart';
import '../detail_identitas_diri_viewmodel.dart';

class IdentitasDiriDebiturSection
    extends HookViewModelWidget<DetailIdentitasDiriViewModel> {
  const IdentitasDiriDebiturSection({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: long-method
  Widget buildViewModelWidget(
    BuildContext context,
    DetailIdentitasDiriViewModel viewModel,
  ) {
    return BaseDetailSection(
      title: 'Info Debitur',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowItemDetail(
            listWidget: [
              const DetailPrakarsaItem(
                title: 'Jenis Kredit',
                value: 'Pinang Maksima - PTR',
              ),
              DetailPrakarsaItem(
                title: 'Bentuk Usaha',
                value: viewModel.detailIdentitasPerorangan?.typePipeline ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Nama Debitur Sesuai KTP',
                value: viewModel.detailIdentitasPerorangan?.fullName ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Nomor KTP Debitur',
                value: viewModel.detailIdentitasPerorangan?.ktpNum ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Tanggal ID Terbit',
                value: viewModel.detailIdentitasPerorangan?.dateOfIssuedKTP !=
                        null
                    ? DateStringFormatter.forDetailPrakarsaDate(
                        viewModel.detailIdentitasPerorangan?.dateOfIssuedKTP ??
                            '',
                      )
                    : '-',
              ),
              DetailPrakarsaItem(
                title: 'Agama',
                value:
                    '${viewModel.detailIdentitasPerorangan?.religion ?? ''} - ${ReligionStringFormatter.forOutput(viewModel.detailIdentitasPerorangan?.religion ?? '')}',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Pendidikan Terakhir',
                value:
                    viewModel.detailIdentitasPerorangan?.lastEducation ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Nomor NPWP',
                value: viewModel.detailIdentitasPerorangan?.npwpNum ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Tempat Lahir Debitur',
                value: viewModel.detailIdentitasPerorangan?.placeOfBirth ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal Lahir Debitur',
                value: viewModel.detailIdentitasPerorangan?.dateOfBirth?.date !=
                        null
                    ? DateStringFormatter.forDetailPrakarsaDate(
                        viewModel
                                .detailIdentitasPerorangan?.dateOfBirth?.date ??
                            '',
                      )
                    : '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Jenis Kelamin',
                value: viewModel.detailIdentitasPerorangan?.gender ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Nama Gadis Ibu Kandung Debitur',
                value: viewModel.detailIdentitasPerorangan?.motherMaiden ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Status Perkawinan',
                value:
                    viewModel.detailIdentitasPerorangan?.maritalStatus ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Jumlah Tanggungan',
                value:
                    (viewModel.detailIdentitasPerorangan?.numberOfDependents ??
                            '-')
                        .toString(),
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Nomor KK',
                value: viewModel.detailIdentitasPerorangan?.kkNum ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Tanggal KK',
                value: viewModel.detailIdentitasPerorangan?.kkDate == null
                    ? '-'
                    : DateStringFormatter.forDetailPrakarsaDate(
                        viewModel.detailIdentitasPerorangan?.kkDate ?? '',
                      ),
              ),
            ],
          ),
          if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.kawin)
            RowItemDetail(
              listWidget: [
                DetailPrakarsaItem(
                  title: 'No. Akta Nikah',
                  value:
                      viewModel.detailIdentitasPerorangan?.marriageNum ?? '-',
                ),
                DetailPrakarsaItem(
                  title: 'Tanggal Akta Nikah',
                  value: viewModel.detailIdentitasPerorangan?.marriageDate ==
                          null
                      ? '-'
                      : DateStringFormatter.forDetailPrakarsaDate(
                          viewModel.detailIdentitasPerorangan?.marriageDate ??
                              '',
                        ),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tag Location Alamat Debitur',
                  style: titleValue,
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: (viewModel.detailIdentitasPerorangan?.tagLocation
                                  ?.latLng ??
                              '')
                          .isNotEmpty
                      ? () => viewModel.previewLocation(
                            context,
                            'Tag Location Alamat Debitur',
                          )
                      : null,
                  child: Text(
                    'Lihat Lokasi',
                    style: valueStyle.copyWith(
                      decoration: TextDecoration.underline,
                      color: (viewModel.detailIdentitasPerorangan?.tagLocation
                                      ?.latLng ??
                                  '')
                              .isNotEmpty
                          ? CustomColor.lightBlue
                          : CustomColor.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DetailPrakarsaItem(
              title: 'Detail Alamat Tempat Tinggal',
              value: viewModel.detailIdentitasPerorangan?.detail ?? '-',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DetailPrakarsaItem(
              title: 'Kode Pos',
              value: viewModel.detailIdentitasPerorangan?.postalCode ?? '-',
            ),
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Provinsi',
                value: viewModel.detailIdentitasPerorangan?.province ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Kota',
                value: viewModel.detailIdentitasPerorangan?.city ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'Kecamatan',
                value: viewModel.detailIdentitasPerorangan?.district ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Kelurahan',
                value: viewModel.detailIdentitasPerorangan?.village ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'RT',
                value: viewModel.detailIdentitasPerorangan?.rt ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'RW',
                value: viewModel.detailIdentitasPerorangan?.rw ?? '-',
              ),
            ],
          ),
          RowItemDetail(
            listWidget: [
              DetailPrakarsaItem(
                title: 'No. Handphone',
                value: viewModel.detailIdentitasPerorangan?.phoneNum ?? '-',
              ),
              DetailPrakarsaItem(
                title: 'Email',
                value: viewModel.detailIdentitasPerorangan?.email ?? '-',
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 14.0),
            child: ThickLightGreyDivider(
              verticalPadding: 0.0,
            ),
          ),
          if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.kawin)
            BaseDetailSection(
              title: 'Identitas Pasangan',
              content: Column(
                children: [
                  RowItemDetail(
                    listWidget: [
                      DetailPrakarsaItem(
                        title: 'No. KTP Pasangan',
                        value:
                            viewModel.detailIdentitasPerorangan?.spouseKtpNum ??
                                '-',
                      ),
                      DetailPrakarsaItem(
                        title: 'Nama Lengkap Pasangan',
                        value: viewModel
                                .detailIdentitasPerorangan?.spouseFullname ??
                            '-',
                      ),
                    ],
                  ),
                  RowItemDetail(
                    listWidget: [
                      DetailPrakarsaItem(
                        title: 'Tempat Lahir Pasangan',
                        value: viewModel.detailIdentitasPerorangan
                                ?.spousePlaceOfBirth ??
                            '-',
                      ),
                      DetailPrakarsaItem(
                        title: 'Tanggal Lahir Pasangan',
                        value: viewModel.detailIdentitasPerorangan
                                    ?.spouseDateOfBirth?.date !=
                                null
                            ? DateStringFormatter.forDetailPrakarsaDate(
                                viewModel.detailIdentitasPerorangan
                                        ?.spouseDateOfBirth?.date ??
                                    '',
                              )
                            : '-',
                      ),
                    ],
                  ),
                ],
              ),
            )
          else if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.ceraiHidup)
            RowItemDetail(
              listWidget: [
                DetailPrakarsaItem(
                  title: 'No. Akta Cerai',
                  value: viewModel.detailIdentitasPerorangan?.divorceNum ?? '-',
                ),
                DetailPrakarsaItem(
                  title: 'Tanggal Akta Cerai',
                  value: viewModel.detailIdentitasPerorangan?.divorceDate ==
                          null
                      ? '-'
                      : DateStringFormatter.forDetailPrakarsaDate(
                          viewModel.detailIdentitasPerorangan?.divorceDate ??
                              '',
                        ),
                ),
              ],
            )
          else if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.belumKawin)
            RowItemDetail(
              listWidget: [
                DetailPrakarsaItem(
                  title: 'No. Surat Keterangan Belum Menikah',
                  value: viewModel.detailIdentitasPerorangan?.notMarriageNum ??
                      '-',
                ),
                DetailPrakarsaItem(
                  title: 'Tanggal Surat Keterangan Belum Menikah',
                  value: viewModel.detailIdentitasPerorangan?.notMarriageDate ==
                          null
                      ? '-'
                      : DateStringFormatter.forDetailPrakarsaDate(
                          viewModel
                                  .detailIdentitasPerorangan?.notMarriageDate ??
                              '',
                        ),
                ),
              ],
            )
          else if (viewModel.detailIdentitasPerorangan?.maritalStatus ==
              Common.ceraiMati)
            RowItemDetail(
              listWidget: [
                DetailPrakarsaItem(
                  title: 'No. Sertifikat Kematian',
                  value: viewModel
                          .detailIdentitasPerorangan?.deathCertificateNum ??
                      '-',
                ),
                DetailPrakarsaItem(
                  title: 'Tanggal Sertifikat Kematian',
                  value: viewModel.detailIdentitasPerorangan
                              ?.deathCertificateDate ==
                          null
                      ? '-'
                      : DateStringFormatter.forDetailPrakarsaDate(
                          viewModel.detailIdentitasPerorangan
                                  ?.deathCertificateDate ??
                              '',
                        ),
                ),
              ],
            ),
        ],
      ),
      isLast: true,
    );
  }
}
