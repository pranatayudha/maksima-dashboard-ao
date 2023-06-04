// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_agunan_tambahan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailAgunanTambahanModel _$$_DetailAgunanTambahanModelFromJson(Map json) =>
    $checkedCreate(
      r'_$_DetailAgunanTambahanModel',
      json,
      ($checkedConvert) {
        final val = _$_DetailAgunanTambahanModel(
          id: $checkedConvert('id', (v) => v as String?),
          prakarsaId: $checkedConvert('prakarsaId', (v) => v as String?),
          jenisPengikatan:
              $checkedConvert('jenisPengikatan', (v) => v as String?),
          luasTanah: $checkedConvert('luasTanah', (v) => v as String?),
          addressesId: $checkedConvert('addressesId', (v) => v as String?),
          nOP: $checkedConvert('nOP', (v) => v as String?),
          jenisSertifikat:
              $checkedConvert('jenisSertifikat', (v) => v as String?),
          numSertifikat: $checkedConvert('numSertifikat', (v) => v as String?),
          namaPemilik: $checkedConvert('namaPemilik', (v) => v as String?),
          jatuhTempo: $checkedConvert('jatuhTempo', (v) => v as String?),
          pathBuktiBayarPBBTerakhir: $checkedConvert(
              'pathBuktiBayarPBBTerakhir',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          pathDataPembanding: $checkedConvert('pathDataPembanding',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          pathFotoAgunanTambahan: $checkedConvert(
              'pathFotoAgunanTambahan',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => PathFotoAgunanTambahan.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
          delFlag: $checkedConvert('delFlag', (v) => v as bool?),
          createdAt: $checkedConvert('createdAt', (v) => v as String?),
          createdBy: $checkedConvert('createdBy', (v) => v as String?),
          updatedAt: $checkedConvert('updatedAt', (v) => v as String?),
          updatedBy: $checkedConvert('updatedBy', (v) => v as String?),
          noAgunanCbs: $checkedConvert('noAgunanCbs', (v) => v as int?),
          coverNoteNum: $checkedConvert('coverNoteNum', (v) => v as int?),
          dateOfCoverNote: $checkedConvert('dateOfCoverNote', (v) => v as int?),
          agunanNum: $checkedConvert('agunanNum', (v) => v as int?),
          tanggalPengikatanAgunan:
              $checkedConvert('tanggalPengikatanAgunan', (v) => v as String?),
          jenisAgunanTambahan:
              $checkedConvert('jenisAgunanTambahan', (v) => v as String?),
          jenisPenilaian:
              $checkedConvert('jenisPenilaian', (v) => v as String?),
          statusKepemilikan:
              $checkedConvert('statusKepemilikan', (v) => v as String?),
          permukaanTanah:
              $checkedConvert('permukaanTanah', (v) => v as String?),
          bentukTanah: $checkedConvert('bentukTanah', (v) => v as String?),
          batasBarat: $checkedConvert('batasBarat', (v) => v as String?),
          batasUtara: $checkedConvert('batasUtara', (v) => v as String?),
          batasTimur: $checkedConvert('batasTimur', (v) => v as String?),
          batasSelatan: $checkedConvert('batasSelatan', (v) => v as String?),
          alamatSesuaiSertifikat:
              $checkedConvert('alamatSesuaiSertifikat', (v) => v as String?),
          nJOP: $checkedConvert('nJOP', (v) => v as String?),
          nJOPm2: $checkedConvert('nJOPm2', (v) => v as String?),
          pathSertifikatKepemilikan:
              $checkedConvert('pathSertifikatKepemilikan', (v) => v as String?),
          namaKjpp: $checkedConvert('namaKjpp', (v) => v as String?),
          nomorPenilaian:
              $checkedConvert('nomorPenilaian', (v) => v as String?),
          tanggalLaporan:
              $checkedConvert('tanggalLaporan', (v) => v as String?),
          tanggalPenilaian:
              $checkedConvert('tanggalPenilaian', (v) => v as String?),
          pathDokumenKjpp:
              $checkedConvert('pathDokumenKjpp', (v) => v as String?),
          nomorPersetujuanIzinPrinsip: $checkedConvert(
              'nomorPersetujuanIzinPrinsip', (v) => v as String?),
          tanggalPersetujuanIzinPrinsip: $checkedConvert(
              'tanggalPersetujuanIzinPrinsip', (v) => v as String?),
          pathDokumenPersetujuan:
              $checkedConvert('pathDokumenPersetujuan', (v) => v as String?),
          stepperUmumTambahanTanah:
              $checkedConvert('stepperUmumTambahanTanah', (v) => v as int?),
          tagLocation: $checkedConvert(
              'tagLocation',
              (v) => v == null
                  ? null
                  : TagLocation.fromJson(Map<String, dynamic>.from(v as Map))),
          detail: $checkedConvert('detail', (v) => v as String?),
          postalCode: $checkedConvert('postalCode', (v) => v as String?),
          province: $checkedConvert('province', (v) => v as String?),
          city: $checkedConvert('city', (v) => v as String?),
          district: $checkedConvert('district', (v) => v as String?),
          village: $checkedConvert('village', (v) => v as String?),
          rt: $checkedConvert('rt', (v) => v as String?),
          rw: $checkedConvert('rw', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_DetailAgunanTambahanModelToJson(
        _$_DetailAgunanTambahanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prakarsaId': instance.prakarsaId,
      'jenisPengikatan': instance.jenisPengikatan,
      'luasTanah': instance.luasTanah,
      'addressesId': instance.addressesId,
      'nOP': instance.nOP,
      'jenisSertifikat': instance.jenisSertifikat,
      'numSertifikat': instance.numSertifikat,
      'namaPemilik': instance.namaPemilik,
      'jatuhTempo': instance.jatuhTempo,
      'pathBuktiBayarPBBTerakhir': instance.pathBuktiBayarPBBTerakhir,
      'pathDataPembanding': instance.pathDataPembanding,
      'pathFotoAgunanTambahan':
          instance.pathFotoAgunanTambahan?.map((e) => e.toJson()).toList(),
      'delFlag': instance.delFlag,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
      'noAgunanCbs': instance.noAgunanCbs,
      'coverNoteNum': instance.coverNoteNum,
      'dateOfCoverNote': instance.dateOfCoverNote,
      'agunanNum': instance.agunanNum,
      'tanggalPengikatanAgunan': instance.tanggalPengikatanAgunan,
      'jenisAgunanTambahan': instance.jenisAgunanTambahan,
      'jenisPenilaian': instance.jenisPenilaian,
      'statusKepemilikan': instance.statusKepemilikan,
      'permukaanTanah': instance.permukaanTanah,
      'bentukTanah': instance.bentukTanah,
      'batasBarat': instance.batasBarat,
      'batasUtara': instance.batasUtara,
      'batasTimur': instance.batasTimur,
      'batasSelatan': instance.batasSelatan,
      'alamatSesuaiSertifikat': instance.alamatSesuaiSertifikat,
      'nJOP': instance.nJOP,
      'nJOPm2': instance.nJOPm2,
      'pathSertifikatKepemilikan': instance.pathSertifikatKepemilikan,
      'namaKjpp': instance.namaKjpp,
      'nomorPenilaian': instance.nomorPenilaian,
      'tanggalLaporan': instance.tanggalLaporan,
      'tanggalPenilaian': instance.tanggalPenilaian,
      'pathDokumenKjpp': instance.pathDokumenKjpp,
      'nomorPersetujuanIzinPrinsip': instance.nomorPersetujuanIzinPrinsip,
      'tanggalPersetujuanIzinPrinsip': instance.tanggalPersetujuanIzinPrinsip,
      'pathDokumenPersetujuan': instance.pathDokumenPersetujuan,
      'stepperUmumTambahanTanah': instance.stepperUmumTambahanTanah,
      'tagLocation': instance.tagLocation?.toJson(),
      'detail': instance.detail,
      'postalCode': instance.postalCode,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'village': instance.village,
      'rt': instance.rt,
      'rw': instance.rw,
    };

_$_TagLocation _$$_TagLocationFromJson(Map<String, dynamic> json) =>
    _$_TagLocation(
      latLng: json['lat_lng'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_TagLocationToJson(_$_TagLocation instance) =>
    <String, dynamic>{
      'lat_lng': instance.latLng,
      'name': instance.name,
    };

_$_PathFotoAgunanTambahan _$$_PathFotoAgunanTambahanFromJson(
        Map<String, dynamic> json) =>
    _$_PathFotoAgunanTambahan(
      path: json['path'] as String?,
      photoName: json['photo_name'] as String?,
      tagLocation: json['tag_location'] == null
          ? null
          : TagLocation.fromJson(json['tag_location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PathFotoAgunanTambahanToJson(
        _$_PathFotoAgunanTambahan instance) =>
    <String, dynamic>{
      'path': instance.path,
      'photo_name': instance.photoName,
      'tag_location': instance.tagLocation?.toJson(),
    };
