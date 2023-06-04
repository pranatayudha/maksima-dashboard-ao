import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../helpers/uint8list_string_converter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @HiveType(typeId: 1, adapterName: 'UserAdapter')
  @JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
  factory User({
    @HiveField(0) required String? userId,
    @HiveField(1) required String? userName,
    @HiveField(2) required String? branchCode,
    @HiveField(3) required String? orgId,
    @HiveField(4) required String? organization,
    @HiveField(5) required String? jabatan,
    @HiveField(6) required String? loginTicket,
    @HiveField(7) required String? accessLevel,
    @JsonKey(name: 'foto', fromJson: uint8ListFromString)
    @HiveField(8)
        required Uint8List? foto,
    @HiveField(9) required String? accessToken,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
