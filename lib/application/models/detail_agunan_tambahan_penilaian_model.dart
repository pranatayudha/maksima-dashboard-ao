import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_agunan_tambahan_penilaian_model.freezed.dart';

part 'detail_agunan_tambahan_penilaian_model.g.dart';

@freezed
class DetailAgunanTambahanPenilaianModel
    with _$DetailAgunanTambahanPenilaianModel {
  @JsonSerializable(anyMap: true, explicitToJson: true, checked: true)
  const factory DetailAgunanTambahanPenilaianModel({
    String? metodePendekatan,
    String? judgementHargaAset,
    @JsonKey(name: 'NPW') String? npw,
    String? coverageRatioNPW,
    @JsonKey(name: 'NL') String? nl,
    String? coverageRatioNL,
    @JsonKey(name: 'PNPW') String? pnpw,
    String? coverageRatioPNPW,
    @JsonKey(name: 'PNL') String? pnl,
    String? coverageRatioPNL,
    String? nilaiPengikatan,
    String? coverageRatioNilaiPengikatan,
    String? thingsBanksNeedToKnow,
    String? analisaAgunanTambahan,
    String? opiniKJPP,
  }) = _DetailAgunanTambahanPenilaianModel;

  factory DetailAgunanTambahanPenilaianModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DetailAgunanTambahanPenilaianModelFromJson(json);
}
