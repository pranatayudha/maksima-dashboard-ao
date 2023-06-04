import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_agunan_tambahan_tanah_bangunan_pembanding_response_model.freezed.dart';

part 'list_agunan_tambahan_tanah_bangunan_pembanding_response_model.g.dart';

@freezed
class DataAgunanTambahanTanahBangunanPembandingResponseModel
    with _$DataAgunanTambahanTanahBangunanPembandingResponseModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory DataAgunanTambahanTanahBangunanPembandingResponseModel({
    List<ListAgunanTambahanTanahBangunanPembandingResponseModel>? data,
  }) = _DataAgunanTambahanTanahBangunanPembandingResponseModel;

  factory DataAgunanTambahanTanahBangunanPembandingResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataAgunanTambahanTanahBangunanPembandingResponseModelFromJson(json);
}

@freezed
class ListAgunanTambahanTanahBangunanPembandingResponseModel
    with _$ListAgunanTambahanTanahBangunanPembandingResponseModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory ListAgunanTambahanTanahBangunanPembandingResponseModel({
    String? sumberData,
    String? linkInternet,
    String? noHp,
    int? hargaAsetPembanding,
    int? luasTanah,
    int? luasBangunan,
    int? hargaBangunanM2,
    int? asumsiHargaBangunan,
    int? asumsiHargaTanah,
    int? hargaTanahM2,
    List<PathFotoResponseModel>? pathFoto,
  }) = _ListAgunanTambahanTanahBangunanPembandingResponseModel;

  factory ListAgunanTambahanTanahBangunanPembandingResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ListAgunanTambahanTanahBangunanPembandingResponseModelFromJson(json);
}

@freezed
class PathFotoResponseModel with _$PathFotoResponseModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory PathFotoResponseModel({
    String? path,
    String? photoName,
    List<TagLocationResponseModel>? tagLocation,
  }) = _PathFotoResponseModel;

  factory PathFotoResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PathFotoResponseModelFromJson(json);
}

@freezed
class TagLocationResponseModel with _$TagLocationResponseModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory TagLocationResponseModel({
    int? latLng,
    String? name,
  }) = _TagLocationResponseModel;

  factory TagLocationResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TagLocationResponseModelFromJson(json);
}
