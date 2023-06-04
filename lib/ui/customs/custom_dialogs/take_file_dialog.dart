// ignore_for_file: library_private_types_in_public_api, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../application/app/app.locator.dart';
import '../../../application/app/constants/custom_color.dart';
import '../../../application/services/media_service.dart';
import '../../shared/custom_button.dart';

class TakeFileDialog extends StatefulWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;

  const TakeFileDialog({
    this.request,
    this.completer,
    Key? key,
  }) : super(key: key);

  @override
  _TakeFileDialogState createState() => _TakeFileDialogState();
}

class _TakeFileDialogState extends State<TakeFileDialog> {
  final MaksimaMediaService _mediaService = locator<MaksimaMediaService>();
  String? _fileErrorText;
  File? _file;

  bool _isImageValid() {
    if (_file == null) {
      _fileErrorText = 'Anda Belum Memilih File';

      // ignore: no-empty-block
      setState(() {});

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _fileErrorText = null;
        });
      });
    }
    // ignore: newline-before-return
    return _file != null;
  }

  void _changePhoto() {
    if (_isImageValid()) {
      widget.completer!(
        DialogResponse(
          confirmed: true,
          data: _file,
        ),
      );
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
          if (_file != null)
            GestureDetector(
              onTap: () => {},
              child: Material(
                elevation: 10.0,
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.file(_file!, fit: BoxFit.cover),
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
          width: MediaQuery.of(context).size.width,
          color: CustomColor.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => {},
                child: Icon(
                  Icons.camera,
                  size: 45.0,
                  color: _fileErrorText == null ? Colors.white : Colors.yellow,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                _fileErrorText ?? 'Pilih Sumber File',
                style: TextStyle(
                  color: _fileErrorText == null ? Colors.white : Colors.yellow,
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
        color: _file != null ? CustomColor.primaryColor : Colors.grey,
        radius: 8.0,
        onPressed: _changePhoto,
        isBusy: false,
      ),
    );
  }
}
