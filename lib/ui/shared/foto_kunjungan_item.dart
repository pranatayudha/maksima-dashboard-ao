import 'package:flutter/material.dart';

import '../../application/app/constants/custom_color.dart';
import '../../application/models/foto_kunjungan_model.dart';
import 'styles.dart';

class FotoKunjunganItem extends StatelessWidget {
  final FotoKunjunganModel data;
  final Function(FotoKunjunganModel) onTap;
  const FotoKunjunganItem({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 90.0,
              color: Colors.black12,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: data.imageUrl != null
                    ? Image.network(data.imageUrl!, fit: BoxFit.cover)
                    : const AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Center(
                          child: Icon(Icons.image, color: Colors.black26),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.date ?? '',
                  style: tsHeading10,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  data.address ?? '',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: CustomColor.primaryBlack.withOpacity(0.5),
                  ),
                ),
                GestureDetector(
                  onTap: () => onTap(data),
                  child: const Text(
                    'Lihat Detail',
                    style: tsHeading11SecondaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
