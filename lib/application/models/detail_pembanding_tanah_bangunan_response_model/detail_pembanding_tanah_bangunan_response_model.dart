import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_pembanding_tanah_bangunan_response_model.freezed.dart';

part 'detail_pembanding_tanah_bangunan_response_model.g.dart';

@freezed
class DetailPembandingTanahBangunanResponseModel
    with _$DetailPembandingTanahBangunanResponseModel {
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  const factory DetailPembandingTanahBangunanResponseModel({
    bool? success,
    String? data,
    String? message,
    int? code,
  }) = _DetailPembandingTanahBangunanResponseModel;

  factory DetailPembandingTanahBangunanResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DetailPembandingTanahBangunanResponseModelFromJson(json);
}
