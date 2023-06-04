// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<_$_User> {
  @override
  final int typeId = 1;

  @override
  _$_User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_User(
      userId: fields[0] as String?,
      userName: fields[1] as String?,
      branchCode: fields[2] as String?,
      orgId: fields[3] as String?,
      organization: fields[4] as String?,
      jabatan: fields[5] as String?,
      loginTicket: fields[6] as String?,
      accessLevel: fields[7] as String?,
      foto: fields[8] as Uint8List?,
      accessToken: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.branchCode)
      ..writeByte(3)
      ..write(obj.orgId)
      ..writeByte(4)
      ..write(obj.organization)
      ..writeByte(5)
      ..write(obj.jabatan)
      ..writeByte(6)
      ..write(obj.loginTicket)
      ..writeByte(7)
      ..write(obj.accessLevel)
      ..writeByte(8)
      ..write(obj.foto)
      ..writeByte(9)
      ..write(obj.accessToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map json) => $checkedCreate(
      r'_$_User',
      json,
      ($checkedConvert) {
        final val = _$_User(
          userId: $checkedConvert('userId', (v) => v as String?),
          userName: $checkedConvert('userName', (v) => v as String?),
          branchCode: $checkedConvert('branchCode', (v) => v as String?),
          orgId: $checkedConvert('orgId', (v) => v as String?),
          organization: $checkedConvert('organization', (v) => v as String?),
          jabatan: $checkedConvert('jabatan', (v) => v as String?),
          loginTicket: $checkedConvert('loginTicket', (v) => v as String?),
          accessLevel: $checkedConvert('accessLevel', (v) => v as String?),
          foto:
              $checkedConvert('foto', (v) => uint8ListFromString(v as String?)),
          accessToken: $checkedConvert('accessToken', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'branchCode': instance.branchCode,
      'orgId': instance.orgId,
      'organization': instance.organization,
      'jabatan': instance.jabatan,
      'loginTicket': instance.loginTicket,
      'accessLevel': instance.accessLevel,
      'foto': instance.foto,
      'accessToken': instance.accessToken,
    };
