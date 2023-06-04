import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../application/app/constants/custom_color.dart';
import 'styles.dart';

class RitelCustomPDFViewer extends StatelessWidget {
  final String pdfFile;

  const RitelCustomPDFViewer(this.pdfFile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryBlue,
        foregroundColor: Colors.white,
        title: const Text(
          'PDF Viewer',
          style: tsHeading6White,
        ),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        pdfFile,
      ),
    );
  }
}
