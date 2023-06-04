import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/models/prescreening_perorangan.dart';
import '../../application/models/prescreening_perusahaan.dart';

class ScreeningAPI {
  final _dio = locator<Dio>();

  Future<Either<String, PrescreeningPerorangan>> fetchPerorangan({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.fetchScreening}$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(PrescreeningPerorangan.fromJson(res.data['data']));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, PrescreeningPerusahaan>> fetchPerusahaan({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.fetchScreening}$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(PrescreeningPerusahaan.fromJson(res.data['data']));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }
}
