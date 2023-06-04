import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../application/app/constants/custom_color.dart';
import 'styles.dart';

class DetilPencairanBox extends StatelessWidget {
  final double nominalPencairan;
  final double cadanganBunga;
  final String tglJatuhTempo;
  final String jmlHariPinjaman;

  const DetilPencairanBox({
    Key? key,
    required this.nominalPencairan,
    required this.cadanganBunga,
    required this.tglJatuhTempo,
    required this.jmlHariPinjaman,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF6F6F8),
        border: Border.all(color: const Color(0xffE5E5E5)),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          _buildItem('Nominal Pencairan', 1, nominalPencairan),
          _buildDivider(),
          _buildItem('Cadangan Bunga', 1, cadanganBunga),
          _buildDivider(),
          _buildItem('Tgl. Jatuh Tempo Cadangan Bunga', 2, tglJatuhTempo),
          _buildDivider(),
          _buildItem('Jumlah Hari Pinjaman', 2, jmlHariPinjaman),
        ],
      ),
    );
  }

  Padding _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
      ),
      child: Divider(thickness: 1),
    );
  }

  Column _buildItem(
    String title,
    int type,
    dynamic value,
  ) {
    final formatter = NumberFormat('#,###', 'id_ID');

    return Column(
      children: [
        Text(title, style: tsHeading12),
        const SizedBox(height: 8.0),
        (type == 1)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Rp.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: CustomColor.primaryBlack40,
                    ),
                  ),
                  Text(
                    formatter.format(value),
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: CustomColor.primaryBlack40,
                    ),
                  ),
                ],
              )
            : Text(
                value,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: CustomColor.primaryBlack40,
                ),
              ),
      ],
    );
  }
}
