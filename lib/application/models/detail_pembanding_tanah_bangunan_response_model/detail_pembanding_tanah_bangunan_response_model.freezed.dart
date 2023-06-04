// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'detail_pembanding_tanah_bangunan_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DetailPembandingTanahBangunanResponseModel
    _$DetailPembandingTanahBangunanResponseModelFromJson(
        Map<String, dynamic> json) {
  return _DetailPembandingTanahBangunanResponseModel.fromJson(json);
}

/// @nodoc
mixin _$DetailPembandingTanahBangunanResponseModel {
  bool? get success => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailPembandingTanahBangunanResponseModelCopyWith<
          DetailPembandingTanahBangunanResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailPembandingTanahBangunanResponseModelCopyWith<$Res> {
  factory $DetailPembandingTanahBangunanResponseModelCopyWith(
          DetailPembandingTanahBangunanResponseModel value,
          $Res Function(DetailPembandingTanahBangunanResponseModel) then) =
      _$DetailPembandingTanahBangunanResponseModelCopyWithImpl<$Res,
          DetailPembandingTanahBangunanResponseModel>;
  @useResult
  $Res call({bool? success, String? data, String? message, int? code});
}

/// @nodoc
class _$DetailPembandingTanahBangunanResponseModelCopyWithImpl<$Res,
        $Val extends DetailPembandingTanahBangunanResponseModel>
    implements $DetailPembandingTanahBangunanResponseModelCopyWith<$Res> {
  _$DetailPembandingTanahBangunanResponseModelCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DetailPembandingTanahBangunanResponseModelCopyWith<$Res>
    implements $DetailPembandingTanahBangunanResponseModelCopyWith<$Res> {
  factory _$$_DetailPembandingTanahBangunanResponseModelCopyWith(
          _$_DetailPembandingTanahBangunanResponseModel value,
          $Res Function(_$_DetailPembandingTanahBangunanResponseModel) then) =
      __$$_DetailPembandingTanahBangunanResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? success, String? data, String? message, int? code});
}

/// @nodoc
class __$$_DetailPembandingTanahBangunanResponseModelCopyWithImpl<$Res>
    extends _$DetailPembandingTanahBangunanResponseModelCopyWithImpl<$Res,
        _$_DetailPembandingTanahBangunanResponseModel>
    implements _$$_DetailPembandingTanahBangunanResponseModelCopyWith<$Res> {
  __$$_DetailPembandingTanahBangunanResponseModelCopyWithImpl(
      _$_DetailPembandingTanahBangunanResponseModel _value,
      $Res Function(_$_DetailPembandingTanahBangunanResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(_$_DetailPembandingTanahBangunanResponseModel(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
class _$_DetailPembandingTanahBangunanResponseModel
    implements _DetailPembandingTanahBangunanResponseModel {
  const _$_DetailPembandingTanahBangunanResponseModel(
      {this.success, this.data, this.message, this.code});

  factory _$_DetailPembandingTanahBangunanResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_DetailPembandingTanahBangunanResponseModelFromJson(json);

  @override
  final bool? success;
  @override
  final String? data;
  @override
  final String? message;
  @override
  final int? code;

  @override
  String toString() {
    return 'DetailPembandingTanahBangunanResponseModel(success: $success, data: $data, message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetailPembandingTanahBangunanResponseModel &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, data, message, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetailPembandingTanahBangunanResponseModelCopyWith<
          _$_DetailPembandingTanahBangunanResponseModel>
      get copyWith =>
          __$$_DetailPembandingTanahBangunanResponseModelCopyWithImpl<
              _$_DetailPembandingTanahBangunanResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DetailPembandingTanahBangunanResponseModelToJson(
      this,
    );
  }
}

abstract class _DetailPembandingTanahBangunanResponseModel
    implements DetailPembandingTanahBangunanResponseModel {
  const factory _DetailPembandingTanahBangunanResponseModel(
      {final bool? success,
      final String? data,
      final String? message,
      final int? code}) = _$_DetailPembandingTanahBangunanResponseModel;

  factory _DetailPembandingTanahBangunanResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$_DetailPembandingTanahBangunanResponseModel.fromJson;

  @override
  bool? get success;
  @override
  String? get data;
  @override
  String? get message;
  @override
  int? get code;
  @override
  @JsonKey(ignore: true)
  _$$_DetailPembandingTanahBangunanResponseModelCopyWith<
          _$_DetailPembandingTanahBangunanResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
