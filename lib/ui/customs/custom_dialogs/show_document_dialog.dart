import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void showDocumnet({required BuildContext context, required String path}) {
  _showDocumnet(
    context: context,
    child: _parsePathFile(path),
  );
}

Widget _parsePathFile(String url) {
  if (url.contains('png') || url.contains('jpg') || url.contains('jpeg')) {
    return Image.network(url);
  }

  if (url.contains('pdf')) {
    return SfPdfViewer.network(url);
  }

  return Text('Invalid File Format! $url');
}

void _showDocumnet({required BuildContext context, required Widget child}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        content: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: child,
          ),
        ),
      );
    },
  );
}
