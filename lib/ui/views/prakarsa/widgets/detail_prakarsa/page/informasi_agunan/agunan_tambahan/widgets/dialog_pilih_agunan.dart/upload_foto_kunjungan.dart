import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../shared/styles.dart';

class UploadFotoKunjungan extends StatelessWidget {
  final String label;
  final String? docUrl;
  final Function()? onTap;
  final Function()? onTapClose;
  final String? subLabel;
  const UploadFotoKunjungan({
    Key? key,
    required this.label,
    required this.docUrl,
    this.onTap,
    this.onTapClose,
    this.subLabel,
  }) : super(key: key);

  String getExtension(String url) {
    try {
      return p.extension(
        url.substring(url.lastIndexOf('/file/'), url.indexOf('?')),
      );
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (docUrl != null && (docUrl?.isNotEmpty ?? false)) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 90.0,
                color: Colors.black12,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: docUrl != null
                      ? getExtension(docUrl!) != '.pdf'
                          ? Image.network(
                              docUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, obj, track) =>
                                  const Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.black26,
                                ),
                              ),
                            )
                          : Center(
                              child: Image.asset(
                                IconConstants.pdf,
                                scale: 2,
                              ),
                            )
                      : const Center(
                          child: Icon(Icons.image, color: Colors.black26),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: tsHeading10,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  subLabel ?? '-',
                  style: tsHeading11.copyWith(
                    color: CustomColor.darkGrey,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                GestureDetector(
                  onTap: onTap != null ? () => onTap!() : null,
                  child: Text(
                    'Lihat Detail',
                    style: (docUrl != null && (docUrl?.isNotEmpty ?? false))
                        ? tsHeading11SecondaryBlue
                        : tsHeading11.copyWith(
                            color: CustomColor.darkGrey,
                            fontWeight: FontWeight.w400,
                          ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTapClose,
            child: Image.asset(IconConstants.x, height: 16),
          ),
        ],
      ),
    );
  }
}
