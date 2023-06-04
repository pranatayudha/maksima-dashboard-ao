// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_pembanding_tanah_bangunan_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailPembandingTanahBangunanResponseModel
    _$$_DetailPembandingTanahBangunanResponseModelFromJson(Map json) =>
        $checkedCreate(
          r'_$_DetailPembandingTanahBangunanResponseModel',
          json,
          ($checkedConvert) {
            final val = _$_DetailPembandingTanahBangunanResponseModel(
              success: $checkedConvert('success', (v) => v as bool?),
              data: $checkedConvert('data', (v) => v as String?),
              message: $checkedConvert('message', (v) => v as String?),
              code: $checkedConvert('code', (v) => v as int?),
            );
            return val;
          },
        );

Map<String, dynamic> _$$_DetailPembandingTanahBangunanResponseModelToJson(
        _$_DetailPembandingTanahBangunanResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
      'code': instance.code,
    };
