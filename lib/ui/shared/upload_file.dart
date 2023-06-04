import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:stacked_services/stacked_services.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/custom_color.dart';
import '../../application/app/constants/icon_constants.dart';
import '../../application/app/constants/text_style_constants.dart';
import '../../application/enums/dialog_type.dart';
import '../../application/services/url_launcher_service.dart';
import 'styles.dart';

class UploadFile extends StatelessWidget {
  final String label;
  final String? imageUrl;
  final Function() onTap;
  final bool isEditable;
  final bool isLoading;
  const UploadFile({
    Key? key,
    required this.label,
    required this.imageUrl,
    required this.onTap,
    required this.isLoading,
    this.isEditable = true,
  }) : super(key: key);

  Future _expandImage(String? foto) async {
    await locator<DialogService>().showCustomDialog(
      variant: DialogType.maksimaImageFileExpand,
      data: {'imageUrl': foto},
      barrierDismissible: true,
    );
  }

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
          if (imageUrl != null && (imageUrl?.isNotEmpty ?? false)) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 90.0,
                color: Colors.black12,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: imageUrl != null
                      ? getExtension(imageUrl!) != '.pdf'
                          ? Image.network(
                              imageUrl!,
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
          isLoading
              ? Row(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Uploading...'),
                  ],
                )
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: tsHeading10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      GestureDetector(
                        onTap: (imageUrl != null &&
                                (imageUrl?.isNotEmpty ?? false))
                            ? getExtension(imageUrl!) != '.pdf'
                                ? () => _expandImage(imageUrl!)
                                : () => locator<URLLauncherService>().browse(
                                      imageUrl!,
                                    )
                            : null,
                        child: Text(
                          (imageUrl != null && (imageUrl?.isNotEmpty ?? false))
                              ? 'Lihat'
                              : 'Format file PNG, JPG atau PDF (max 25 MB)',
                          style: (imageUrl != null &&
                                  (imageUrl?.isNotEmpty ?? false))
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
          else if (imageUrl != null && (imageUrl?.isNotEmpty ?? false))
            InkWell(
              onTap: onTap,
              child: Image.asset(IconConstants.x, height: 16),
            )
          else
            InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: CustomColor.lighterBlue,
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
