import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/models/detail_debitur_perorangan.dart';
import '../../application/models/detail_debitur_perusahaan.dart';
import '../../application/models/detail_prakarsa_perorangan.dart';
import '../../application/models/detail_prakarsa_perusahaan.dart';
import '../../application/models/prakarsa_list_model.dart';
import '../../application/models/search_parameters_model.dart';

class PrakarsaAPI {
  final _dio = locator<Dio>();

  Future<Either<String, DataPrakarsaListModel>> fetchPrakarsa({
    required SearchParametersModel key,
  }) async {
    try {
      final String url =
          '${Endpoint.fetchPrakarsa}page=${key.page}&limit=${key.limit}&name=${key.name}&status=${key.status}&loanType=${key.loanTypeId}';

      final res = await _dio.get(
        url,
      );

      if (res.data['success'] != true) {
        return const Left('Data tidak ditemukan');
      }

      final ritelPrakarsa = DataPrakarsaListModel.fromJson(res.data);

      return Right(ritelPrakarsa);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, DetailDebiturPerorangan>> fetchDetailDebiturPerorangan({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.fetchDetailDebitur}$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(DetailDebiturPerorangan.fromJson(res.data['data']));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, DetailDebiturPerusahaan>> fetchDetailDebiturPerusahaan({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.fetchDetailDebitur}$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(DetailDebiturPerusahaan.fromJson(res.data['data']));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, DetailPrakarsaPerorangan>>
      fetchDetailPrakarsaPerorangan({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.fetchDetailPrakarsa}$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(DetailPrakarsaPerorangan.fromJson(res.data['data']));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, DetailPrakarsaPerusahaan>>
      fetchDetailPrakarsaPerusahaan({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.fetchDetailPrakarsa}$prakarsaId',
      );

      log('${Endpoint.fetchDetailPrakarsa}$prakarsaId ${jsonEncode(res.data)}');

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      return Right(DetailPrakarsaPerusahaan.fromJson(res.data['data']));
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }
}
