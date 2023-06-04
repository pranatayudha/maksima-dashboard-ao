// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_agunan_tambahan_pembanding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailAgunanTambahanPembandingModel
    _$$_DetailAgunanTambahanPembandingModelFromJson(Map json) => $checkedCreate(
          r'_$_DetailAgunanTambahanPembandingModel',
          json,
          ($checkedConvert) {
            final val = _$_DetailAgunanTambahanPembandingModel(
              data: $checkedConvert(
                  'data',
                  (v) => (v as List<dynamic>?)
                      ?.map((e) => DataPembanding.fromJson(
                          Map<String, dynamic>.from(e as Map)))
                      .toList()),
            );
            return val;
          },
        );

Map<String, dynamic> _$$_DetailAgunanTambahanPembandingModelToJson(
        _$_DetailAgunanTambahanPembandingModel instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

_$_DataPembanding _$$_DataPembandingFromJson(Map json) => $checkedCreate(
      r'_$_DataPembanding',
      json,
      ($checkedConvert) {
        final val = _$_DataPembanding(
          id: $checkedConvert('id', (v) => v as String?),
          sumberData: $checkedConvert('sumberData', (v) => v as String?),
          pathFoto: $checkedConvert('pathFoto', (v) => v as String?),
          linkInternet: $checkedConvert('linkInternet', (v) => v as String?),
          noHp: $checkedConvert('noHp', (v) => v as String?),
          hargaAsetPembanding:
              $checkedConvert('hargaAsetPembanding', (v) => v as String?),
          luasAsetPembanding:
              $checkedConvert('luasAsetPembanding', (v) => v as String?),
          hargaTanahPerM2:
              $checkedConvert('hargaTanahPerM2', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_DataPembandingToJson(_$_DataPembanding instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sumberData': instance.sumberData,
      'pathFoto': instance.pathFoto,
      'linkInternet': instance.linkInternet,
      'noHp': instance.noHp,
      'hargaAsetPembanding': instance.hargaAsetPembanding,
      'luasAsetPembanding': instance.luasAsetPembanding,
      'hargaTanahPerM2': instance.hargaTanahPerM2,
    };
