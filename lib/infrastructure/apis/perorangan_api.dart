import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/models/detail_identitas_perorangan.dart';
import '../../application/models/info_usaha_debitur_model.dart';

class PeroranganAPI {
  final _dio = locator<Dio>();

  Future<Either<String, DetailIdentitasPerorangan>> fetchIdentitasPerorangan({
    required String prakarsaId,
    required int codeTable,
    required String pipelineId,
  }) async {
    try {
      final res = await _dio.get(
        Endpoint.urlIdentitasPerorangan,
        queryParameters: {
          'prakarsaId': prakarsaId,
          'codeTable': codeTable,
          'pipelinesId': pipelineId,
        },
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final ritelPrakarsa = DetailIdentitasPerorangan.fromJson(
        res.data['data'][0],
      );

      return Right(ritelPrakarsa);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> updateIdentitasPerorangan({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final res = await _dio.put(
        '${Endpoint.urlIdentitasPerorangan}/save',
        data: payload,
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(res.data['message']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, InfoUsahaDebiturModel>> fetchInfoUsahaDebitur({
    required String prakarsaId,
    required int codeTable,
    required String pipelineId,
  }) async {
    try {
      final res = await _dio.get(
        Endpoint.urlInfoUsahaPerorangan,
        queryParameters: {
          'prakarsaId': prakarsaId,
          'codeTable': codeTable,
          'pipelinesId': pipelineId,
        },
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final infoUsaha = InfoUsahaDebiturModel.fromJson(
        res.data['data'][1],
      );

      return Right(infoUsaha);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> updateInfoUsahaPerorangan({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final res = await _dio.put(
        '${Endpoint.urlInfoUsahaPerorangan}/save',
        data: payload,
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(res.data['message']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }
}
