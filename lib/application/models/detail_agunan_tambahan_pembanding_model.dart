import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_agunan_tambahan_pembanding_model.freezed.dart';

part 'detail_agunan_tambahan_pembanding_model.g.dart';

@freezed
class DetailAgunanTambahanPembandingModel
    with _$DetailAgunanTambahanPembandingModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory DetailAgunanTambahanPembandingModel({
    List<DataPembanding>? data,
  }) = _DetailAgunanTambahanPembandingModel;

  factory DetailAgunanTambahanPembandingModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DetailAgunanTambahanPembandingModelFromJson(json);
}

@freezed
class DataPembanding with _$DataPembanding {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory DataPembanding({
    String? id,
    String? sumberData,
    String? pathFoto,
    String? linkInternet,
    String? noHp,
    String? hargaAsetPembanding,
    String? luasAsetPembanding,
    String? hargaTanahPerM2,
  }) = _DataPembanding;

  factory DataPembanding.fromJson(Map<String, dynamic> json) =>
      _$DataPembandingFromJson(json);
}
