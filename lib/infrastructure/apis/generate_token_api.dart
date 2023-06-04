import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/common.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/models/user.dart';
import '../../application/services/local_db_service.dart';

class GenerateTokenAPI {
  final _dio = locator<Dio>();
  final _localDBService = locator<LocalDBService>();

  Future<Either<String, bool>> generateToken({
    required User user,
  }) async {
    try {
      final payload = {
        'data': {
          'userId': user.userId,
          'userName': user.userName,
          'branchCode': user.branchCode == '9999' ? '0020' : user.branchCode,
          'orgId': user.orgId,
          'organization': user.organization,
          'job': user.jabatan,
          'loginTicket': user.loginTicket,
          'accessLevel': '10',
          'photo': user.foto.toString(),
        },
      };

      final res = await _dio.post(
        Endpoint.generateToken,
        data: payload,
      );

      final accessToken = res.data['data']['accessToken'] as String;

      _localDBService.storeToken(accessToken);

      return const Right(true);
    } on DioError catch (e) {
      if (e.response!.statusCode == 502) {
        return const Left(Common.statusCode502Message);
      } else {
        return Left(DioErrorTypeParser.parseToCustomMessage(e));
      }
    }
  }
}
