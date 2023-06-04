import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../../../../../../../../application/app/constants/custom_color.dart';
import '../../../../../../../../../application/app/constants/icon_constants.dart';
import '../../../../../../../../../application/app/constants/text_style_constants.dart';
import '../../../../../../../../shared/styles.dart';

class UploadDocumentAgunan extends StatelessWidget {
  final String label;
  final String? docUrl;
  final Function()? onTap;
  final Function()? onTapLihat;
  final bool isEditable;
  final bool isLoading;
  final String? subLabel;
  const UploadDocumentAgunan({
    Key? key,
    required this.label,
    required this.docUrl,
    this.onTap,
    this.onTapLihat,
    required this.isLoading,
    this.isEditable = true,
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
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Row(
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
                      ? getExtension(docUrl!) == '.pdf'
                          ? Center(
                              child: Image.asset(
                                IconConstants.pdf,
                                scale: 2,
                              ),
                            )
                          : getExtension(docUrl!) == '.xlsx' ||
                                  getExtension(docUrl!) == '.xls'
                              ? Center(
                                  child: Image.asset(
                                    IconConstants.xls,
                                    scale: 2,
                                  ),
                                )
                              : Image.network(
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
                      : const Center(
                          child: Icon(Icons.image, color: Colors.black26),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
          ],
          isLoading
              ? Expanded(
                  child: Row(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Uploading...'),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: tsHeading10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      GestureDetector(
                        onTap: (docUrl != null && (docUrl?.isNotEmpty ?? false))
                            ? onTapLihat
                            : null,
                        child: Text(
                          (docUrl != null && (docUrl?.isNotEmpty ?? false))
                              ? 'Lihat'
                              : subLabel ??
                                  'Format file .xls atau .xlsx (max 25 MB)',
                          style:
                              (docUrl != null && (docUrl?.isNotEmpty ?? false))
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
          if (!isEditable)
            const SizedBox()
          else if (docUrl != null && (docUrl?.isNotEmpty ?? false))
            InkWell(
              onTap: onTap,
              child: Image.asset(IconConstants.x, height: 16),
            )
          else
            InkWell(
              onTap: onTap,
              child: Container(
                width: 120,
                height: 32,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  border: Border.all(color: CustomColor.primaryBlue),
                ),
                child: Center(
                  child: Text(
                    'Upload',
                    style: valueStatusStyle.copyWith(
                      color: CustomColor.primaryBlue,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
