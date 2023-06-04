import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/models/user.dart';
import '../../application/services/local_db_service.dart';

final _localDBService = locator<LocalDBService>();
final _options = Options(
  contentType: 'application/x-www-form-urlencoded',
  followRedirects: false,
  validateStatus: (status) => true,
);

class UserAPI {
  final _dio = Dio();

  Future<Either<String, User>> loginSSO({
    required String? userId,
    required String? password,
    required String? ipAddress,
  }) async {
    try {
      final res = await _dio.post(
        Endpoint.userLoginSSO,
        data: {
          'userId': userId,
          'password': base64Url.encode(utf8.encode(password!)),
          'ipAddress': ipAddress,
        },
        options: _options,
      );
      if (res.data['data'] == null) {
        return Left(res.data['message']);
      }
      final user = User.fromJson(res.data['data'] as Map<String, dynamic>);

      return Right(user);
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return const Left(
          'Pastikan kamu menggunakan 6 digit Personal Number dan password sesuai Jagat Raya',
        );
      } else {
        return Left(DioErrorTypeParser.parseToCustomMessage(e));
      }
    }
  }

  Future<Either<String, bool>> logoutSSO({
    required String? userId,
    required String? loginTicket,
  }) async {
    try {
      final res = await _dio.post(
        Endpoint.userLogoutSSO,
        data: {
          'userId': userId,
          'loginTicket': loginTicket,
        },
        options: _options.copyWith(
          headers: {
            'Authorization': 'Bearer ${_localDBService.getUser()?.accessToken}',
            'Accept': '*/*',
          },
        ),
      );

      if (res.data['status'] != 200) {
        return Left(res.data['message'] as String);
      }

      return const Right(true);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }
}
