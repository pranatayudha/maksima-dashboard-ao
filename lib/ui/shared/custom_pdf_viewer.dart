// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class CustomPDFViewer extends StatefulWidget {
  final File pdfFile;

  const CustomPDFViewer(this.pdfFile, {Key? key}) : super(key: key);

  @override
  _CustomPDFViewerState createState() => _CustomPDFViewerState();
}

class _CustomPDFViewerState extends State<CustomPDFViewer> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future _loadDocument() async {
    document = await PDFDocument.fromFile(widget.pdfFile);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: Center(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : PDFViewer(document: document),
      ),
    );
  }
}
