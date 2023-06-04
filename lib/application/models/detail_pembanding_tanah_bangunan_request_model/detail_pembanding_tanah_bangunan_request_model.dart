import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_pembanding_tanah_bangunan_request_model.freezed.dart';

part 'detail_pembanding_tanah_bangunan_request_model.g.dart';

@freezed
class DetailPembandingTanahBangunanRequestModel
    with _$DetailPembandingTanahBangunanRequestModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory DetailPembandingTanahBangunanRequestModel({
    bool? isDraft,
    String? prakarsaId,
    String? agunanTambahanTanahBangunanId,
    List<PembandingResponseModel>? pembanding,
  }) = _DetailPembandingTanahBangunanRequestModel;

  factory DetailPembandingTanahBangunanRequestModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DetailPembandingTanahBangunanRequestModelFromJson(json);
}

@freezed
class PembandingResponseModel with _$PembandingResponseModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory PembandingResponseModel({
  String? sumberData,
  String? pathDokumenPembanding,
  String? linkInternet,
  String? noHp,
  int? hargaAsetPembanding,
  int? luasTanah,
  int? luasBangunan,
  int? hargaBangunanM2,

  List<PathFotoResponseModel>? pathFoto,
  }) = _PembandingResponseModel;

  factory PembandingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PembandingResponseModelFromJson(json);
}

@freezed
class PathFotoResponseModel with _$PathFotoResponseModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory PathFotoResponseModel({
  String? path,
  String? photoName,

  List<TagLocationResponseModel>? tagLocation,
  }) = _PathFotoResponseModel;

  factory PathFotoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PathFotoResponseModelFromJson(json);
}

@freezed
class TagLocationResponseModel with _$TagLocationResponseModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory TagLocationResponseModel({
  String? latLng,
  String? name,
  }) = _TagLocationResponseModel;

  factory TagLocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TagLocationResponseModelFromJson(json);
}
