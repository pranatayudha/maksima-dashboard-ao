import 'package:dio/dio.dart';

import '../app/constants/common.dart';

class DioErrorTypeParser {
  static String parseToCustomMessage(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        return Common.dioErrorTypeConnectionTimeoutMessage;

      case DioErrorType.other:
        return Common.dioErrorTypeOtherMessage;

      case DioErrorType.response:
        String message = '';

        switch (e.response?.statusCode) {
          case 500:
            message = Common.statusCode500Message;
            break;
          default:
            message = e.response!.data['message'];
        }

        return message;

      default:
        return e.response!.data['message'];
    }
  }
}
