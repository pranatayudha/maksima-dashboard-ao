import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/app/constants/custom_color.dart';
import '../../../application/app/constants/icon_constants.dart';
import '../../../application/services/media_service.dart';
import '../../shared/custom_button.dart';

class TakePhotoFileDialog extends StatefulWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const TakePhotoFileDialog({
    this.request,
    this.completer,
    Key? key,
  }) : super(key: key);

  @override
  TakePhotoFileDialogState createState() => TakePhotoFileDialogState();
}

class TakePhotoFileDialogState extends State<TakePhotoFileDialog> {
  final MaksimaMediaService _mediaService = locator<MaksimaMediaService>();
  String? imageErrorText;
  File? imageFile;

  bool _isImageValid() {
    if (imageFile == null) {
      imageErrorText = 'Anda Belum Memilih Foto';

      // ignore: no-empty-block
      setState(() {});

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          imageErrorText = null;
        });
      });
    }
    // ignore: newline-before-return
    return imageFile != null;
  }

  void _changePhoto() {
    if (_isImageValid()) {
      widget.completer!(
        DialogResponse(
          confirmed: true,
          data: (p.extension(imageFile!.path) == '.jpg' ||
                  p.extension(imageFile!.path) == '.png' ||
                  p.extension(imageFile!.path) == '.jpeg')
              ? [imageFile, 'image']
              : [imageFile, 'pdf'],
        ),
      );
    }
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile = await _mediaService.getImage(
      fromGallery: source == ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => imageFile = File(pickedFile.path));
    }
  }

  Future _pickFile() async {
    final pickedFile = await _mediaService.getFile();
    if (pickedFile != null) {
      setState(() => imageFile = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildImageSourceSelector(),
          if (imageFile != null)
            if (p.extension(imageFile!.path) == '.jpg' ||
                p.extension(imageFile!.path) == '.png' ||
                p.extension(imageFile!.path) == '.jpeg')
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Material(
                  elevation: 10.0,
                  clipBehavior: Clip.antiAlias,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.file(imageFile!, fit: BoxFit.cover),
                    ),
                  ),
                ),
              )
            else
              Material(
                elevation: 10.0,
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      IconConstants.file,
                      color: CustomColor.primaryBlue,
                      scale: 1.5,
                    ),
                  ),
                ),
              ),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildImageSourceSelector() {
    return Stack(
      children: [
        Container(
          height: 120.0,
          color: CustomColor.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: Icon(
                      Icons.image_outlined,
                      size: 48.0,
                      color:
                          imageErrorText == null ? Colors.white : Colors.yellow,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    height: 45.0,
                    width: 1.0,
                    color: Colors.white30,
                  ),
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.camera),
                    child: Icon(
                      Icons.camera,
                      size: 45.0,
                      color:
                          imageErrorText == null ? Colors.white : Colors.yellow,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    height: 45.0,
                    width: 1.0,
                    color: Colors.white30,
                  ),
                  GestureDetector(
                    onTap: () => _pickFile(),
                    child: Image.asset(
                      IconConstants.file,
                      color:
                          imageErrorText == null ? Colors.white : Colors.yellow,
                      scale: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                imageErrorText ?? 'Pilih Sumber File',
                style: TextStyle(
                  color: imageErrorText == null ? Colors.white : Colors.yellow,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => widget.completer!(DialogResponse()),
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomButton(
        label: 'PILIH FILE INI',
        color: imageFile != null ? CustomColor.primaryColor : Colors.grey,
        radius: 8.0,
        onPressed: _changePhoto,
        isBusy: false,
      ),
    );
  }
}
