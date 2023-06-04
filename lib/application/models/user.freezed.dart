// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @HiveField(0)
  String? get userId => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get userName => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get branchCode => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get orgId => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get organization => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get jabatan => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get loginTicket => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get accessLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'foto', fromJson: uint8ListFromString)
  @HiveField(8)
  Uint8List? get foto => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get accessToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@HiveField(0)
          String? userId,
      @HiveField(1)
          String? userName,
      @HiveField(2)
          String? branchCode,
      @HiveField(3)
          String? orgId,
      @HiveField(4)
          String? organization,
      @HiveField(5)
          String? jabatan,
      @HiveField(6)
          String? loginTicket,
      @HiveField(7)
          String? accessLevel,
      @JsonKey(name: 'foto', fromJson: uint8ListFromString)
      @HiveField(8)
          Uint8List? foto,
      @HiveField(9)
          String? accessToken});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? userName = freezed,
    Object? branchCode = freezed,
    Object? orgId = freezed,
    Object? organization = freezed,
    Object? jabatan = freezed,
    Object? loginTicket = freezed,
    Object? accessLevel = freezed,
    Object? foto = freezed,
    Object? accessToken = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      branchCode: freezed == branchCode
          ? _value.branchCode
          : branchCode // ignore: cast_nullable_to_non_nullable
              as String?,
      orgId: freezed == orgId
          ? _value.orgId
          : orgId // ignore: cast_nullable_to_non_nullable
              as String?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String?,
      jabatan: freezed == jabatan
          ? _value.jabatan
          : jabatan // ignore: cast_nullable_to_non_nullable
              as String?,
      loginTicket: freezed == loginTicket
          ? _value.loginTicket
          : loginTicket // ignore: cast_nullable_to_non_nullable
              as String?,
      accessLevel: freezed == accessLevel
          ? _value.accessLevel
          : accessLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      foto: freezed == foto
          ? _value.foto
          : foto // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0)
          String? userId,
      @HiveField(1)
          String? userName,
      @HiveField(2)
          String? branchCode,
      @HiveField(3)
          String? orgId,
      @HiveField(4)
          String? organization,
      @HiveField(5)
          String? jabatan,
      @HiveField(6)
          String? loginTicket,
      @HiveField(7)
          String? accessLevel,
      @JsonKey(name: 'foto', fromJson: uint8ListFromString)
      @HiveField(8)
          Uint8List? foto,
      @HiveField(9)
          String? accessToken});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? userName = freezed,
    Object? branchCode = freezed,
    Object? orgId = freezed,
    Object? organization = freezed,
    Object? jabatan = freezed,
    Object? loginTicket = freezed,
    Object? accessLevel = freezed,
    Object? foto = freezed,
    Object? accessToken = freezed,
  }) {
    return _then(_$_User(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      branchCode: freezed == branchCode
          ? _value.branchCode
          : branchCode // ignore: cast_nullable_to_non_nullable
              as String?,
      orgId: freezed == orgId
          ? _value.orgId
          : orgId // ignore: cast_nullable_to_non_nullable
              as String?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String?,
      jabatan: freezed == jabatan
          ? _value.jabatan
          : jabatan // ignore: cast_nullable_to_non_nullable
              as String?,
      loginTicket: freezed == loginTicket
          ? _value.loginTicket
          : loginTicket // ignore: cast_nullable_to_non_nullable
              as String?,
      accessLevel: freezed == accessLevel
          ? _value.accessLevel
          : accessLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      foto: freezed == foto
          ? _value.foto
          : foto // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 1, adapterName: 'UserAdapter')
@JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
class _$_User implements _User {
  _$_User(
      {@HiveField(0)
          required this.userId,
      @HiveField(1)
          required this.userName,
      @HiveField(2)
          required this.branchCode,
      @HiveField(3)
          required this.orgId,
      @HiveField(4)
          required this.organization,
      @HiveField(5)
          required this.jabatan,
      @HiveField(6)
          required this.loginTicket,
      @HiveField(7)
          required this.accessLevel,
      @JsonKey(name: 'foto', fromJson: uint8ListFromString)
      @HiveField(8)
          required this.foto,
      @HiveField(9)
          required this.accessToken});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  @HiveField(0)
  final String? userId;
  @override
  @HiveField(1)
  final String? userName;
  @override
  @HiveField(2)
  final String? branchCode;
  @override
  @HiveField(3)
  final String? orgId;
  @override
  @HiveField(4)
  final String? organization;
  @override
  @HiveField(5)
  final String? jabatan;
  @override
  @HiveField(6)
  final String? loginTicket;
  @override
  @HiveField(7)
  final String? accessLevel;
  @override
  @JsonKey(name: 'foto', fromJson: uint8ListFromString)
  @HiveField(8)
  final Uint8List? foto;
  @override
  @HiveField(9)
  final String? accessToken;

  @override
  String toString() {
    return 'User(userId: $userId, userName: $userName, branchCode: $branchCode, orgId: $orgId, organization: $organization, jabatan: $jabatan, loginTicket: $loginTicket, accessLevel: $accessLevel, foto: $foto, accessToken: $accessToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.branchCode, branchCode) ||
                other.branchCode == branchCode) &&
            (identical(other.orgId, orgId) || other.orgId == orgId) &&
            (identical(other.organization, organization) ||
                other.organization == organization) &&
            (identical(other.jabatan, jabatan) || other.jabatan == jabatan) &&
            (identical(other.loginTicket, loginTicket) ||
                other.loginTicket == loginTicket) &&
            (identical(other.accessLevel, accessLevel) ||
                other.accessLevel == accessLevel) &&
            const DeepCollectionEquality().equals(other.foto, foto) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      userName,
      branchCode,
      orgId,
      organization,
      jabatan,
      loginTicket,
      accessLevel,
      const DeepCollectionEquality().hash(foto),
      accessToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {@HiveField(0)
          required final String? userId,
      @HiveField(1)
          required final String? userName,
      @HiveField(2)
          required final String? branchCode,
      @HiveField(3)
          required final String? orgId,
      @HiveField(4)
          required final String? organization,
      @HiveField(5)
          required final String? jabatan,
      @HiveField(6)
          required final String? loginTicket,
      @HiveField(7)
          required final String? accessLevel,
      @JsonKey(name: 'foto', fromJson: uint8ListFromString)
      @HiveField(8)
          required final Uint8List? foto,
      @HiveField(9)
          required final String? accessToken}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @HiveField(0)
  String? get userId;
  @override
  @HiveField(1)
  String? get userName;
  @override
  @HiveField(2)
  String? get branchCode;
  @override
  @HiveField(3)
  String? get orgId;
  @override
  @HiveField(4)
  String? get organization;
  @override
  @HiveField(5)
  String? get jabatan;
  @override
  @HiveField(6)
  String? get loginTicket;
  @override
  @HiveField(7)
  String? get accessLevel;
  @override
  @JsonKey(name: 'foto', fromJson: uint8ListFromString)
  @HiveField(8)
  Uint8List? get foto;
  @override
  @HiveField(9)
  String? get accessToken;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
