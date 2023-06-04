import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/helpers/get_file_name.dart';
import '../../application/models/calculation_agunan_model.dart';
import '../../application/models/detail_agunan_pokok_model.dart';
import '../../application/models/list_agunan_pokok_model.dart';

class AgunanPokokAPI {
  final _dio = locator<Dio>();

  Future<Either<String, List<ListAgunanModel>>> fetchAgunanPokok({
    required String prakarsaId,
    required int codeTable,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlAgunanPokok}list/$prakarsaId',
      );

      if (res.data['success'] != true) {
        throw res.data['message'] as String;
      }

      final temp = List<ListAgunanModel>.from(
        res.data['data'].map(
          (e) => ListAgunanModel.fromJson(e as Map<String, dynamic>),
        ),
      );

      return Right(temp);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, DetailAgunanPokokModel>> fetchAgunanPokokDetail({
    required int id,
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlAgunanPokok}detail',
        queryParameters: {
          'id': id,
          'prakarsaId': prakarsaId,
        },
      );

      if (res.data['success'] != true) {
        throw res.data['message'] as String;
      }

      final temp = DetailAgunanPokokModel.fromJson(res.data['data']);

      return Right(temp);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  // ignore: long-parameter-list
  Future<Either<String, int>> uploadExcelAgunan({
    required File file,
    required String prakarsaId,
    required int jenisAgunanPokok,
    int? idAgunanPokok,
    required int codeTable,
  }) async {
    try {
      final formData = FormData.fromMap({
        'pathUploadExcel': await MultipartFile.fromFile(
          file.path,
          filename: getFilename(file),
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

  Future<Either<String, CalculationAgunanModel>> getCalculationAgunan({
    required String prakarsaId,
    required int jenisAgunanPokok,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlDsbAgunanPokok}get-calculate/$prakarsaId?jenisAgunanPokok=$jenisAgunanPokok',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message']);
      }

      final temp = CalculationAgunanModel.fromJson(res.data['data']);

      return Right(temp);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, bool>> deleteAgunanPokok({
    required int id,
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.delete(
        '${Endpoint.urlAgunanPokok}delete?id=$id&prakarsaId=$prakarsaId',
      );

      if (res.data['success'] != true) {
        throw res.data['message'] as String;
      }

      final isSuccess = res.data['success'] as bool;

      return Right(isSuccess);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, bool>> saveAgunanPokok(
    Map<String, dynamic> data,
    int codeTable,
  ) async {
    try {
      final res = await _dio.put(
        '${Endpoint.urlAgunanPokok}save?codeTable=$codeTable',
        data: jsonEncode(data),
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final isSuccess = res.data['success'] as bool;

      return Right(isSuccess);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, bool>> deleteExcelAgunanPokok(
    Map<String, dynamic> data,
    int codeTable,
  ) async {
    try {
      final res = await _dio.put(
        '${Endpoint.urlAgunanPokok}delete-document',
        data: jsonEncode(data),
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final isSuccess = res.data['success'] as bool;

      return Right(isSuccess);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }
}
