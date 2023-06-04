// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File> urlToFile(String imageUrl) async {
  var rng = Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath${rng.nextInt(100)}.png');
  http.Response response = await http.get(Uri.parse(imageUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}

Future<File> urlToFilePdf(String fileUrl, String name) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('${tempPath}_${name.split('/').last}.pdf');
  http.Response response = await http.get(Uri.parse(fileUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}

Future<File> urlToFileExcelRiwayatProjek(String fileUrl) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('${tempPath}_Template-Riwayat-Projek.xlsx');
  http.Response response = await http.get(Uri.parse(fileUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}

Future<File> urlToFileExcel(String fileUrl) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('${tempPath}_${fileUrl.split('/').last}.xlsx');
  http.Response response = await http.get(Uri.parse(fileUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}

Future<File> urlToFileExcelPopulate(String fileUrl) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('${tempPath}_mutasi_transaksi.xlsx');
  http.Response response = await http.get(Uri.parse(fileUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}

Future<File> urlToFileExcelMutasiTransaksi(String fileUrl) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('${tempPath}_Template-mutasi-transaksi.xlsx');
  http.Response response = await http.get(Uri.parse(fileUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}

Future<File> urlToFileExcelMutasiTransaksiDetail(String fileUrl) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('${tempPath}_file_mutasi_transaksi.xlsx');
  http.Response response = await http.get(Uri.parse(fileUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}
