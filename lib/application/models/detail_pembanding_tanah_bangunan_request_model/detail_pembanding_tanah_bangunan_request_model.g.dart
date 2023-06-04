// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_pembanding_tanah_bangunan_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailPembandingTanahBangunanRequestModel
    _$$_DetailPembandingTanahBangunanRequestModelFromJson(Map json) =>
        $checkedCreate(
          r'_$_DetailPembandingTanahBangunanRequestModel',
          json,
          ($checkedConvert) {
            final val = _$_DetailPembandingTanahBangunanRequestModel(
              isDraft: $checkedConvert('isDraft', (v) => v as bool?),
              prakarsaId: $checkedConvert('prakarsaId', (v) => v as String?),
              agunanTambahanTanahBangunanId: $checkedConvert(
                  'agunanTambahanTanahBangunanId', (v) => v as String?),
              pembanding: $checkedConvert(
                  'pembanding',
                  (v) => (v as List<dynamic>?)
                      ?.map((e) => PembandingResponseModel.fromJson(
                          Map<String, dynamic>.from(e as Map)))
                      .toList()),
            );
            return val;
          },
        );

Map<String, dynamic> _$$_DetailPembandingTanahBangunanRequestModelToJson(
        _$_DetailPembandingTanahBangunanRequestModel instance) =>
    <String, dynamic>{
      'isDraft': instance.isDraft,
      'prakarsaId': instance.prakarsaId,
      'agunanTambahanTanahBangunanId': instance.agunanTambahanTanahBangunanId,
      'pembanding': instance.pembanding?.map((e) => e.toJson()).toList(),
    };

_$_PembandingResponseModel _$$_PembandingResponseModelFromJson(Map json) =>
    $checkedCreate(
      r'_$_PembandingResponseModel',
      json,
      ($checkedConvert) {
        final val = _$_PembandingResponseModel(
          sumberData: $checkedConvert('sumberData', (v) => v as String?),
          pathDokumenPembanding:
              $checkedConvert('pathDokumenPembanding', (v) => v as String?),
          linkInternet: $checkedConvert('linkInternet', (v) => v as String?),
          noHp: $checkedConvert('noHp', (v) => v as String?),
          hargaAsetPembanding:
              $checkedConvert('hargaAsetPembanding', (v) => v as int?),
          luasTanah: $checkedConvert('luasTanah', (v) => v as int?),
          luasBangunan: $checkedConvert('luasBangunan', (v) => v as int?),
          hargaBangunanM2: $checkedConvert('hargaBangunanM2', (v) => v as int?),
          pathFoto: $checkedConvert(
              'pathFoto',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => PathFotoResponseModel.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_PembandingResponseModelToJson(
        _$_PembandingResponseModel instance) =>
    <String, dynamic>{
      'sumberData': instance.sumberData,
      'pathDokumenPembanding': instance.pathDokumenPembanding,
      'linkInternet': instance.linkInternet,
      'noHp': instance.noHp,
      'hargaAsetPembanding': instance.hargaAsetPembanding,
      'luasTanah': instance.luasTanah,
      'luasBangunan': instance.luasBangunan,
      'hargaBangunanM2': instance.hargaBangunanM2,
      'pathFoto': instance.pathFoto?.map((e) => e.toJson()).toList(),
    };

_$_PathFotoResponseModel _$$_PathFotoResponseModelFromJson(Map json) =>
    $checkedCreate(
      r'_$_PathFotoResponseModel',
      json,
      ($checkedConvert) {
        final val = _$_PathFotoResponseModel(
          path: $checkedConvert('path', (v) => v as String?),
          photoName: $checkedConvert('photoName', (v) => v as String?),
          tagLocation: $checkedConvert(
              'tagLocation',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => TagLocationResponseModel.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_PathFotoResponseModelToJson(
        _$_PathFotoResponseModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'photoName': instance.photoName,
      'tagLocation': instance.tagLocation?.map((e) => e.toJson()).toList(),
    };

_$_TagLocationResponseModel _$$_TagLocationResponseModelFromJson(Map json) =>
    $checkedCreate(
      r'_$_TagLocationResponseModel',
      json,
      ($checkedConvert) {
        final val = _$_TagLocationResponseModel(
          latLng: $checkedConvert('latLng', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TagLocationResponseModelToJson(
        _$_TagLocationResponseModel instance) =>
    <String, dynamic>{
      'latLng': instance.latLng,
      'name': instance.name,
    };
