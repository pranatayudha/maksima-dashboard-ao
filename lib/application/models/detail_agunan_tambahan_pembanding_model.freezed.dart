// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'detail_agunan_tambahan_pembanding_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DetailAgunanTambahanPembandingModel
    _$DetailAgunanTambahanPembandingModelFromJson(Map<String, dynamic> json) {
  return _DetailAgunanTambahanPembandingModel.fromJson(json);
}

/// @nodoc
mixin _$DetailAgunanTambahanPembandingModel {
  List<DataPembanding>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailAgunanTambahanPembandingModelCopyWith<
          DetailAgunanTambahanPembandingModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailAgunanTambahanPembandingModelCopyWith<$Res> {
  factory $DetailAgunanTambahanPembandingModelCopyWith(
          DetailAgunanTambahanPembandingModel value,
          $Res Function(DetailAgunanTambahanPembandingModel) then) =
      _$DetailAgunanTambahanPembandingModelCopyWithImpl<$Res,
          DetailAgunanTambahanPembandingModel>;
  @useResult
  $Res call({List<DataPembanding>? data});
}

/// @nodoc
class _$DetailAgunanTambahanPembandingModelCopyWithImpl<$Res,
        $Val extends DetailAgunanTambahanPembandingModel>
    implements $DetailAgunanTambahanPembandingModelCopyWith<$Res> {
  _$DetailAgunanTambahanPembandingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DataPembanding>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DetailAgunanTambahanPembandingModelCopyWith<$Res>
    implements $DetailAgunanTambahanPembandingModelCopyWith<$Res> {
  factory _$$_DetailAgunanTambahanPembandingModelCopyWith(
          _$_DetailAgunanTambahanPembandingModel value,
          $Res Function(_$_DetailAgunanTambahanPembandingModel) then) =
      __$$_DetailAgunanTambahanPembandingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DataPembanding>? data});
}

/// @nodoc
class __$$_DetailAgunanTambahanPembandingModelCopyWithImpl<$Res>
    extends _$DetailAgunanTambahanPembandingModelCopyWithImpl<$Res,
        _$_DetailAgunanTambahanPembandingModel>
    implements _$$_DetailAgunanTambahanPembandingModelCopyWith<$Res> {
  __$$_DetailAgunanTambahanPembandingModelCopyWithImpl(
      _$_DetailAgunanTambahanPembandingModel _value,
      $Res Function(_$_DetailAgunanTambahanPembandingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_DetailAgunanTambahanPembandingModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DataPembanding>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
class _$_DetailAgunanTambahanPembandingModel
    implements _DetailAgunanTambahanPembandingModel {
  const _$_DetailAgunanTambahanPembandingModel(
      {final List<DataPembanding>? data})
      : _data = data;

  factory _$_DetailAgunanTambahanPembandingModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_DetailAgunanTambahanPembandingModelFromJson(json);

  final List<DataPembanding>? _data;
  @override
  List<DataPembanding>? get data {
    final value = _data;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DetailAgunanTambahanPembandingModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetailAgunanTambahanPembandingModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetailAgunanTambahanPembandingModelCopyWith<
          _$_DetailAgunanTambahanPembandingModel>
      get copyWith => __$$_DetailAgunanTambahanPembandingModelCopyWithImpl<
          _$_DetailAgunanTambahanPembandingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DetailAgunanTambahanPembandingModelToJson(
      this,
    );
  }
}

abstract class _DetailAgunanTambahanPembandingModel
    implements DetailAgunanTambahanPembandingModel {
  const factory _DetailAgunanTambahanPembandingModel(
          {final List<DataPembanding>? data}) =
      _$_DetailAgunanTambahanPembandingModel;

  factory _DetailAgunanTambahanPembandingModel.fromJson(
          Map<String, dynamic> json) =
      _$_DetailAgunanTambahanPembandingModel.fromJson;

  @override
  List<DataPembanding>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_DetailAgunanTambahanPembandingModelCopyWith<
          _$_DetailAgunanTambahanPembandingModel>
      get copyWith => throw _privateConstructorUsedError;
}

DataPembanding _$DataPembandingFromJson(Map<String, dynamic> json) {
  return _DataPembanding.fromJson(json);
}

/// @nodoc
mixin _$DataPembanding {
  String? get id => throw _privateConstructorUsedError;
  String? get sumberData => throw _privateConstructorUsedError;
  String? get pathFoto => throw _privateConstructorUsedError;
  String? get linkInternet => throw _privateConstructorUsedError;
  String? get noHp => throw _privateConstructorUsedError;
  String? get hargaAsetPembanding => throw _privateConstructorUsedError;
  String? get luasAsetPembanding => throw _privateConstructorUsedError;
  String? get hargaTanahPerM2 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataPembandingCopyWith<DataPembanding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataPembandingCopyWith<$Res> {
  factory $DataPembandingCopyWith(
          DataPembanding value, $Res Function(DataPembanding) then) =
      _$DataPembandingCopyWithImpl<$Res, DataPembanding>;
  @useResult
  $Res call(
      {String? id,
      String? sumberData,
      String? pathFoto,
      String? linkInternet,
      String? noHp,
      String? hargaAsetPembanding,
      String? luasAsetPembanding,
      String? hargaTanahPerM2});
}

/// @nodoc
class _$DataPembandingCopyWithImpl<$Res, $Val extends DataPembanding>
    implements $DataPembandingCopyWith<$Res> {
  _$DataPembandingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sumberData = freezed,
    Object? pathFoto = freezed,
    Object? linkInternet = freezed,
    Object? noHp = freezed,
    Object? hargaAsetPembanding = freezed,
    Object? luasAsetPembanding = freezed,
    Object? hargaTanahPerM2 = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sumberData: freezed == sumberData
          ? _value.sumberData
          : sumberData // ignore: cast_nullable_to_non_nullable
              as String?,
      pathFoto: freezed == pathFoto
          ? _value.pathFoto
          : pathFoto // ignore: cast_nullable_to_non_nullable
              as String?,
      linkInternet: freezed == linkInternet
          ? _value.linkInternet
          : linkInternet // ignore: cast_nullable_to_non_nullable
              as String?,
      noHp: freezed == noHp
          ? _value.noHp
          : noHp // ignore: cast_nullable_to_non_nullable
              as String?,
      hargaAsetPembanding: freezed == hargaAsetPembanding
          ? _value.hargaAsetPembanding
          : hargaAsetPembanding // ignore: cast_nullable_to_non_nullable
              as String?,
      luasAsetPembanding: freezed == luasAsetPembanding
          ? _value.luasAsetPembanding
          : luasAsetPembanding // ignore: cast_nullable_to_non_nullable
              as String?,
      hargaTanahPerM2: freezed == hargaTanahPerM2
          ? _value.hargaTanahPerM2
          : hargaTanahPerM2 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataPembandingCopyWith<$Res>
    implements $DataPembandingCopyWith<$Res> {
  factory _$$_DataPembandingCopyWith(
          _$_DataPembanding value, $Res Function(_$_DataPembanding) then) =
      __$$_DataPembandingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? sumberData,
      String? pathFoto,
      String? linkInternet,
      String? noHp,
      String? hargaAsetPembanding,
      String? luasAsetPembanding,
      String? hargaTanahPerM2});
}

/// @nodoc
class __$$_DataPembandingCopyWithImpl<$Res>
    extends _$DataPembandingCopyWithImpl<$Res, _$_DataPembanding>
    implements _$$_DataPembandingCopyWith<$Res> {
  __$$_DataPembandingCopyWithImpl(
      _$_DataPembanding _value, $Res Function(_$_DataPembanding) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sumberData = freezed,
    Object? pathFoto = freezed,
    Object? linkInternet = freezed,
    Object? noHp = freezed,
    Object? hargaAsetPembanding = freezed,
    Object? luasAsetPembanding = freezed,
    Object? hargaTanahPerM2 = freezed,
  }) {
    return _then(_$_DataPembanding(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      sumberData: freezed == sumberData
          ? _value.sumberData
          : sumberData // ignore: cast_nullable_to_non_nullable
              as String?,
      pathFoto: freezed == pathFoto
          ? _value.pathFoto
          : pathFoto // ignore: cast_nullable_to_non_nullable
              as String?,
      linkInternet: freezed == linkInternet
          ? _value.linkInternet
          : linkInternet // ignore: cast_nullable_to_non_nullable
              as String?,
      noHp: freezed == noHp
          ? _value.noHp
          : noHp // ignore: cast_nullable_to_non_nullable
              as String?,
      hargaAsetPembanding: freezed == hargaAsetPembanding
          ? _value.hargaAsetPembanding
          : hargaAsetPembanding // ignore: cast_nullable_to_non_nullable
              as String?,
      luasAsetPembanding: freezed == luasAsetPembanding
          ? _value.luasAsetPembanding
          : luasAsetPembanding // ignore: cast_nullable_to_non_nullable
              as String?,
      hargaTanahPerM2: freezed == hargaTanahPerM2
          ? _value.hargaTanahPerM2
          : hargaTanahPerM2 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(checked: true, anyMap: true, explicitToJson: true)
class _$_DataPembanding implements _DataPembanding {
  const _$_DataPembanding(
      {this.id,
      this.sumberData,
      this.pathFoto,
      this.linkInternet,
      this.noHp,
      this.hargaAsetPembanding,
      this.luasAsetPembanding,
      this.hargaTanahPerM2});

  factory _$_DataPembanding.fromJson(Map<String, dynamic> json) =>
      _$$_DataPembandingFromJson(json);

  @override
  final String? id;
  @override
  final String? sumberData;
  @override
  final String? pathFoto;
  @override
  final String? linkInternet;
  @override
  final String? noHp;
  @override
  final String? hargaAsetPembanding;
  @override
  final String? luasAsetPembanding;
  @override
  final String? hargaTanahPerM2;

  @override
  String toString() {
    return 'DataPembanding(id: $id, sumberData: $sumberData, pathFoto: $pathFoto, linkInternet: $linkInternet, noHp: $noHp, hargaAsetPembanding: $hargaAsetPembanding, luasAsetPembanding: $luasAsetPembanding, hargaTanahPerM2: $hargaTanahPerM2)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataPembanding &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sumberData, sumberData) ||
                other.sumberData == sumberData) &&
            (identical(other.pathFoto, pathFoto) ||
                other.pathFoto == pathFoto) &&
            (identical(other.linkInternet, linkInternet) ||
                other.linkInternet == linkInternet) &&
            (identical(other.noHp, noHp) || other.noHp == noHp) &&
            (identical(other.hargaAsetPembanding, hargaAsetPembanding) ||
                other.hargaAsetPembanding == hargaAsetPembanding) &&
            (identical(other.luasAsetPembanding, luasAsetPembanding) ||
                other.luasAsetPembanding == luasAsetPembanding) &&
            (identical(other.hargaTanahPerM2, hargaTanahPerM2) ||
                other.hargaTanahPerM2 == hargaTanahPerM2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sumberData,
      pathFoto,
      linkInternet,
      noHp,
      hargaAsetPembanding,
      luasAsetPembanding,
      hargaTanahPerM2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataPembandingCopyWith<_$_DataPembanding> get copyWith =>
      __$$_DataPembandingCopyWithImpl<_$_DataPembanding>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataPembandingToJson(
      this,
    );
  }
}

abstract class _DataPembanding implements DataPembanding {
  const factory _DataPembanding(
      {final String? id,
      final String? sumberData,
      final String? pathFoto,
      final String? linkInternet,
      final String? noHp,
      final String? hargaAsetPembanding,
      final String? luasAsetPembanding,
      final String? hargaTanahPerM2}) = _$_DataPembanding;

  factory _DataPembanding.fromJson(Map<String, dynamic> json) =
      _$_DataPembanding.fromJson;

  @override
  String? get id;
  @override
  String? get sumberData;
  @override
  String? get pathFoto;
  @override
  String? get linkInternet;
  @override
  String? get noHp;
  @override
  String? get hargaAsetPembanding;
  @override
  String? get luasAsetPembanding;
  @override
  String? get hargaTanahPerM2;
  @override
  @JsonKey(ignore: true)
  _$$_DataPembandingCopyWith<_$_DataPembanding> get copyWith =>
      throw _privateConstructorUsedError;
}
