import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/services/local_db_service.dart';

final localDBService = locator<LocalDBService>();

class MasterAPI {
  final _dio = locator<Dio>();

  Future<Either<String, String>> getPublicFile(String url) async {
    try {
      final res = await _dio.get(
        '${Endpoint.getPublicFile}$url',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(res.data['data']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<String> getPublicFileWithoutEither(String url) async {
    try {
      final res = await _dio.get(
        '${Endpoint.getPublicFile}$url',
      );

      if (res.data['success'] != true) {
        return res.data['message'] as String;
      }

      return res.data['data'];
    } on DioError catch (e) {
      return DioErrorTypeParser.parseToCustomMessage(e);
    }
  }

  Future<Either<String, String>> uploadFile({
    required PlatformFile file,
  }) async {
    try {
      const String uploadFileUrl = '/upload';
      List<int> bytes = file.bytes!.cast();
      String type = '';
      String subType = file.extension ?? '';
      if (file.extension == 'pdf') {
        type = 'application';
      } else {
        type = 'image';
      }

      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          bytes,
          filename: file.name,
          contentType: MediaType(type, subType),
        ),
      });

      final res = await _dio.post(
        uploadFileUrl,
        data: formData,
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(res.data['data']['url'] as String);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, dynamic>> getDetailByPostalCode(
    String postalKode,
  ) async {
    try {
      final res = await _dio.get(
        '/areas/postal-code/first?postalCode=$postalKode',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(res.data['data']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  // ignore: long-parameter-list
  Future<Either<String, int>> uploadExcelAgunan({
    required PlatformFile file,
    required String prakarsaId,
    required int jenisAgunanPokok,
    int? idAgunanPokok,
    required int codeTable,
  }) async {
    try {
      List<int> bytes = file.bytes!.cast();

      final formData = FormData.fromMap({
        'pathUploadExcel': MultipartFile.fromBytes(
          bytes,
          filename: file.name,
          contentType: MediaType('file', 'xlsx'),
        ),
        'prakarsaId': prakarsaId,
        'jenisAgunanPokok': jenisAgunanPokok,
        'idAgunanPokok': idAgunanPokok,
      });

      final res = await _dio.post(
        '${Endpoint.urlAgunanPokok}upload-excel',
        data: formData,
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(int.parse(res.data['data']['idAgunanPokok'] as String));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }
}
