import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/services/local_db_service.dart';

class EmployeesAPI {
  final Dio _dio = locator<Dio>();
  final _localDBService = locator<LocalDBService>();

  Future registerEmployee() async {
    if (_localDBService.userBoxIsNotEmpty()) {
      final user = _localDBService.getUser()!;

      final formData = {
        'fullname': user.userName,
        'branchCode': user.branchCode,
        'organizationId': user.orgId,
        'organizationName': user.organization,
        'job': user.jabatan,
        'tokenType': 'apps',
        'fcmToken': '',
      };

      try {
        final res = await _dio.post(
          '${Endpoint.employeesRegister}/${user.userId}',
          data: formData,
        );

        developer.log(res.data.toString(), name: 'EmployeesAPI');
      } catch (e) {
        developer.log(e.toString(), name: 'EmployeesAPI');
      }
    }
  }
}
