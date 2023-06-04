import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/models/detail_lkn.dart';

class LKNAPI {
  final _dio = locator<Dio>();

  Future<Either<String, DetailLKN>> fetch({
    required String prakarsaType,
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlLkn}$prakarsaType/$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final detailLKN = DetailLKN.fromJson(res.data['data'][0]);

      return Right(detailLKN);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> update({
    required String prakarsaType,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final res = await _dio.put(
        '${Endpoint.urlLkn}$prakarsaType/update',
        data: payload,
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(res.data['data']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }
}
