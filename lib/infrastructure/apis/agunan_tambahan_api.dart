import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/models/detail_agunan_tambahan_model.dart';
import '../../application/models/detail_agunan_tambahan_pembanding_model.dart';
import '../../application/models/detail_agunan_tambahan_penilaian_model.dart';
import '../../application/models/detail_penilaian_model.dart';
import '../../application/models/item_data_pembanding_model.dart';
import '../../application/models/list_agunan_tambahan_model.dart';
import '../../application/models/stepper_tab_agunan_model.dart';
import '../../application/models/list_agunan_tambahan_tanah_bangunan_pembanding_response_model/list_agunan_tambahan_tanah_bangunan_pembanding_response_model.dart';

class AgunanTambahanAPI {
  final _dio = locator<Dio>();

  Future<Either<String, List<ListAgunanTambahanModel>>> fetchAgunanTambahan({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlAgunanTambahan}/list/$prakarsaId',
      );

      if (res.data['success'] != true || res.data['data'].isEmpty) {
        return Left(res.data['message']);
      }

      final temp = List<ListAgunanTambahanModel>.from(
        res.data['data'].map(
          (e) => ListAgunanTambahanModel.fromJson(e as Map<String, dynamic>),
        ),
      );

      return Right(temp);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> addAgunanTambahan({
    required String jenisAgunan,
    dynamic payload,
  }) async {
    try {
      final res = await _dio.post(
        '${Endpoint.urlAgunanTambahan}/$jenisAgunan/add',
        data: payload,
      );

      if (res.data['success'] != true || res.data['data'].isEmpty) {
        return Left(res.data['message']);
      }

      return Right(res.data['data']['id']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> updateAgunanTambahan({
    required String jenisAgunan,
    dynamic payload,
  }) async {
    try {
      final res = await _dio.put(
        '${Endpoint.urlAgunanTambahan}/$jenisAgunan/update',
        data: payload,
      );

      if (res.data['success'] != true || res.data['data'].isEmpty) {
        return Left(res.data['message']);
      }

      return Right(res.data['data']['id']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, DetailAgunanTambahanModel?>>
      fetchAgunanTambahanTanahDetail({
    String? codeTable,
    required int id,
    required String prakarsaId,
  }) async {
    try {
      // print('${Endpoint.urlAgunanTambahan}/detail ${{
      //   'id': id,
      //   'prakarsaId': prakarsaId,
      //   'codeTable': 'tanah',
      // }}');

      final res = await _dio.get(
        '${Endpoint.urlAgunanTambahan}/detail',
        queryParameters: {
          'id': id,
          'prakarsaId': prakarsaId,
          'codeTable': codeTable ?? 'tanah',
        },
      );

      // print('${Endpoint.urlAgunanTambahan}/detail ${jsonEncode(res.data)}');

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final temp = DetailAgunanTambahanModel.fromJson(res.data['data']);

      return Right(temp);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, StepperTabAgunanModel>> fetchStepperAgunanTanah({
    String? jenisAgunan,
    required int id,
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlAgunanTambahan}/${jenisAgunan ?? 'tanah'}/stepper',
        queryParameters: {
          'id': id,
          'prakarsaId': prakarsaId,
        },
      );

      if (res.data['success'] != true) {
        throw res.data['message'] as String;
      }

      return Right(StepperTabAgunanModel.fromJson(res.data));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, List<ItemDataPembandingModel>>> fetchDataPembanding({
    required int id,
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlAgunanTambahan}/tanah/pembanding?prakarsaId=$prakarsaId&id=$id',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message']);
      }

      final temp = List<ItemDataPembandingModel>.from(
        res.data['data'].map(
          (e) => ItemDataPembandingModel.fromJson(e as Map<String, dynamic>),
        ),
      );

      return Right(temp);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, bool>> postDataPembanding({
    dynamic payload,
  }) async {
    try {
      final res = await _dio.post(
        '${Endpoint.urlAgunanTambahan}/tanah/pembanding',
        data: payload,
      );

      if (res.data['success'] != true) {
        return Left(res.data['message']);
      }

      return Right(res.data['success']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, DetailPenilaianModel>> fetchDetailPenilaian({
    required int id,
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlAgunanTambahan}/tanah/penilaian?prakarsaId=$prakarsaId&id=$id',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message']);
      }

      return Right(DetailPenilaianModel.fromJson(res.data['data']));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, bool>> postDataPenilaian({
    dynamic payload,
  }) async {
    try {
      final res = await _dio.post(
        '${Endpoint.urlAgunanTambahan}/tanah/penilaian',
        data: payload,
      );

      if (res.data['success'] != true) {
        return Left(res.data['message']);
      }

      return Right(res.data['success']);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, DetailAgunanTambahanPembandingModel?>>
      fetchAgunanTambahanTanahDataPembanding({
    required int id,
    required String prakarsaId,
  }) async {
    try {
      // print('${Endpoint.urlAgunanTambahan}/tanah/pembanding ${{
      //   'id': id,
      //   'prakarsaId': prakarsaId,
      // }}');

      final res = await _dio.get(
        '${Endpoint.urlAgunanTambahan}/tanah/pembanding',
        queryParameters: {
          'id': id,
          'prakarsaId': prakarsaId,
        },
      );

      // print(
      //   '${Endpoint.urlAgunanTambahan}/tanah/pembanding ${jsonEncode(res.data)}',
      // );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final DetailAgunanTambahanPembandingModel temp =
          DetailAgunanTambahanPembandingModel.fromJson(res.data);

      // print('MODEL ${temp.toString()}');

      return Right(temp);
    } on DioError catch (e) {
      final errorMessage = DioErrorTypeParser.parseToCustomMessage(e);

      return Left(errorMessage);
    }
  }

  Future<Either<String, DetailAgunanTambahanPenilaianModel?>>
      fetchAgunanTambahanTanahPenilaian({
    required int id,
    required String prakarsaId,
  }) async {
    try {
      // print('${Endpoint.urlAgunanTambahan}/tanah/penilaian ${{
      //   'id': id,
      //   'prakarsaId': prakarsaId,
      // }}');

      final res = await _dio.get(
        '${Endpoint.urlAgunanTambahan}/tanah/penilaian',
        queryParameters: {
          'id': id,
          'prakarsaId': prakarsaId,
        },
      );

      // print(
      //   '${Endpoint.urlAgunanTambahan}/tanah/penilaian ${jsonEncode(res.data)}',
      // );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final DetailAgunanTambahanPenilaianModel temp =
          DetailAgunanTambahanPenilaianModel.fromJson(res.data['data']);

      // print('MODEL ${temp.toString()}');

      return Right(temp);
    } on DioError catch (e) {
      final errorMessage = DioErrorTypeParser.parseToCustomMessage(e);

      return Left(errorMessage);
    }
  }

  Future<Either<String, bool>> deleteAgunanTambahan({
    required int id,
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.delete(
        '${Endpoint.urlAgunanTambahan}/delete',
        queryParameters: {
          'id': id,
          'prakarsaId': prakarsaId,
          'codeTable': 'tanah',
        },
      );

      if (res.data['success'] != true) {
        throw res.data['message'] as String;
      }

      final isSuccess = res.data['success'] as bool;

      return Right(isSuccess);
    } on DioError catch (e) {
      final msg = DioErrorTypeParser.parseToCustomMessage(e);

      return Left(msg);
    }
  }

  Future<Either<String, DataAgunanTambahanTanahBangunanPembandingResponseModel>>
      fetchListAgunanTambahanTanahBangunanDataPembanding({
    required String prakarsaId,
    required int id,
  }) async {
    try {
      final res = await _dio.get(
        Endpoint.urlListAgunanTambahanTanahBangunan,
        queryParameters: {
          'prakarsaId': prakarsaId,
          'id': id,
        },
      );

      if (res.data['success'] != true) {
        throw res.data['message'] as String;
      }

      return Right(
        DataAgunanTambahanTanahBangunanPembandingResponseModel.fromJson(
          res.data,
        ),
      );
    } on DioError catch (e) {
      final msg = DioErrorTypeParser.parseToCustomMessage(e);

      return Left(msg);
    }
  }
}
