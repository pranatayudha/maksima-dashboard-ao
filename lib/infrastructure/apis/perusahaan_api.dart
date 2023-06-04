import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../application/app/app.locator.dart';
import '../../application/app/constants/common.dart';
import '../../application/app/constants/endpoint.dart';
import '../../application/helpers/dio_error_type_parser.dart';
import '../../application/models/detail_dokumen_lainnya.dart';
import '../../application/models/detail_identitas_perusahaan.dart';
import '../../application/models/detail_izin_usaha.dart';
import '../../application/models/detail_legalitas.dart';
import '../../application/models/informasi_pengurus_model.dart';

class PerusahaanAPI {
  final _dio = locator<Dio>();

  // Identitas Perusahaan
  Future<Either<String, DetailIdentitasPerusahaan>> fetchIdentitasPerusahaan({
    required String prakarsaId,
    required String prakarsaType,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlIdentitasPerusahaan}$prakarsaType/$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final detailIdentitas = DetailIdentitasPerusahaan.fromJson(
        res.data['data'] as Map<String, dynamic>,
      );

      return Right(detailIdentitas);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> saveIdentitasPerusahaan({
    required String prakarsaType,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final res = await _dio.put(
        '${Endpoint.urlIdentitasPerusahaan}$prakarsaType/save',
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

  // Legalitas
  Future<Either<String, DetailLegalitas>> fetchLegalitas({
    required String prakarsaId,
    required String prakarsaType,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlLegalitasUsaha}$prakarsaType/$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final detailLegalitas = DetailLegalitas.fromJson(
        res.data['data'] as Map<String, dynamic>,
      );

      return Right(detailLegalitas);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> saveLegalitasUsaha({
    required String prakarsaType,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final res = await _dio.put(
        '${Endpoint.urlLegalitasUsaha}$prakarsaType/update',
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

  // Izin Usaha
  Future<Either<String, List<DetailIzinUsaha>>> fetchIzinUsaha({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlIzinUsaha}$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final detailIzinUsaha = List<DetailIzinUsaha>.from(
        res.data['data'].map(
          (i) => DetailIzinUsaha.fromJson(i as Map<String, dynamic>),
        ) as Iterable<dynamic>,
      );

      return Right(detailIzinUsaha);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> saveIzinUsaha({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final res = await _dio.post(
        '${Endpoint.urlIzinUsaha}save',
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

  // Dokumen Lainnya
  Future<Either<String, List<DetailDokumenLainnya>>> fetchDokumenLainnya({
    required String prakarsaId,
  }) async {
    try {
      final res = await _dio.get(
        '${Endpoint.urlDokumenLainnya}$prakarsaId',
      );

      if (res.data['success'] != true) {
        return Left(res.data['message'] as String);
      }

      final detailIzinUsaha = List<DetailDokumenLainnya>.from(
        res.data['data'].map(
          (i) => DetailDokumenLainnya.fromJson(i as Map<String, dynamic>),
        ) as Iterable<dynamic>,
      );

      return Right(detailIzinUsaha);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  Future<Either<String, String>> saveDokumenLainnya({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final res = await _dio.post(
        '${Endpoint.urlDokumenLainnya}update',
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

  Future<Either<String, String>> saveEmptyDokumenLainnya({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final res = await _dio.post(
        '${Endpoint.urlDokumenLainnya}save',
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

  //Informasi Pengurus
  Future<Either<String, List<InformasiPengurusModel>>>
      fetchByIdInformasiPengurus({
    required String prakarsaId,
    required String pipelineId,
    required int codeTable,
  }) async {
    try {
      final String url = Endpoint.fetchInfoPengurus;

      final res = await _dio.get(
        url,
        queryParameters: {
          'prakarsaId': prakarsaId,
          'codeTable': codeTable,
          'pipelinesId': pipelineId,
        },
      );

      if (!res.data['success']) {
        return Left(res.data['message']);
      }

      final informasiPengurusData = res.data['data'][1] as List<dynamic>;

      final informasiPengurusList = informasiPengurusData
          .map((e) => InformasiPengurusModel.fromJson(e))
          .toList();

      return Right(informasiPengurusList);
    } on DioError catch (e) {
      return Left(DioErrorTypeParser.parseToCustomMessage(e));
    }
  }

  //Update Informasi Pengurus
  Future<Either<String, String>> updateInformasiPengurus({
    required Map<String, dynamic> payload,
    required int codeTable,
  }) async {
    try {
      final String url =
          '${Endpoint.updateInfoPengurus}${codeTable == Common.CodeTable.CV ? '-cv/update' : '-pt/update'}';

      final res = await _dio.put(
        url,
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
