import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:stacked_services/stacked_services.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/icon_constants.dart';
import '../../application/enums/dialog_type.dart';
import '../../application/services/url_launcher_service.dart';
import 'styles.dart';

class FotoItem extends StatelessWidget {
  final String label;
  final String? imageUrl;
  final GestureTapCallback? onTap;

  const FotoItem(
    this.label,
    this.imageUrl, {
    Key? key,
    this.onTap,
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
                            errorBuilder: (context, obj, track) => const Center(
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
                GestureDetector(
                  onTap: onTap ?? _onTabDefault(),
                  child: Text(
                    imageUrl != null ? 'Lihat' : '',
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

  void Function()? _onTabDefault(){
    return (imageUrl != null && (imageUrl?.isNotEmpty ?? false))
          ? getExtension(imageUrl!) != '.pdf'
              ? () => _expandImage(imageUrl!)
              : () => locator<URLLauncherService>().browse(
                    imageUrl!,
                  )
          : null;
  }
}
