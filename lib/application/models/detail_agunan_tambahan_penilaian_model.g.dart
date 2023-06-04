// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_agunan_tambahan_penilaian_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailAgunanTambahanPenilaianModel
    _$$_DetailAgunanTambahanPenilaianModelFromJson(Map json) => $checkedCreate(
          r'_$_DetailAgunanTambahanPenilaianModel',
          json,
          ($checkedConvert) {
            final val = _$_DetailAgunanTambahanPenilaianModel(
              metodePendekatan:
                  $checkedConvert('metodePendekatan', (v) => v as String?),
              judgementHargaAset:
                  $checkedConvert('judgementHargaAset', (v) => v as String?),
              npw: $checkedConvert('NPW', (v) => v as String?),
              coverageRatioNPW:
                  $checkedConvert('coverageRatioNPW', (v) => v as String?),
              nl: $checkedConvert('NL', (v) => v as String?),
              coverageRatioNL:
                  $checkedConvert('coverageRatioNL', (v) => v as String?),
              pnpw: $checkedConvert('PNPW', (v) => v as String?),
              coverageRatioPNPW:
                  $checkedConvert('coverageRatioPNPW', (v) => v as String?),
              pnl: $checkedConvert('PNL', (v) => v as String?),
              coverageRatioPNL:
                  $checkedConvert('coverageRatioPNL', (v) => v as String?),
              nilaiPengikatan:
                  $checkedConvert('nilaiPengikatan', (v) => v as String?),
              coverageRatioNilaiPengikatan: $checkedConvert(
                  'coverageRatioNilaiPengikatan', (v) => v as String?),
              thingsBanksNeedToKnow:
                  $checkedConvert('thingsBanksNeedToKnow', (v) => v as String?),
              analisaAgunanTambahan:
                  $checkedConvert('analisaAgunanTambahan', (v) => v as String?),
              opiniKJPP: $checkedConvert('opiniKJPP', (v) => v as String?),
            );
            return val;
          },
          fieldKeyMap: const {
            'npw': 'NPW',
            'nl': 'NL',
            'pnpw': 'PNPW',
            'pnl': 'PNL'
          },
        );

Map<String, dynamic> _$$_DetailAgunanTambahanPenilaianModelToJson(
        _$_DetailAgunanTambahanPenilaianModel instance) =>
    <String, dynamic>{
      'metodePendekatan': instance.metodePendekatan,
      'judgementHargaAset': instance.judgementHargaAset,
      'NPW': instance.npw,
      'coverageRatioNPW': instance.coverageRatioNPW,
      'NL': instance.nl,
      'coverageRatioNL': instance.coverageRatioNL,
      'PNPW': instance.pnpw,
      'coverageRatioPNPW': instance.coverageRatioPNPW,
      'PNL': instance.pnl,
      'coverageRatioPNL': instance.coverageRatioPNL,
      'nilaiPengikatan': instance.nilaiPengikatan,
      'coverageRatioNilaiPengikatan': instance.coverageRatioNilaiPengikatan,
      'thingsBanksNeedToKnow': instance.thingsBanksNeedToKnow,
      'analisaAgunanTambahan': instance.analisaAgunanTambahan,
      'opiniKJPP': instance.opiniKJPP,
    };
