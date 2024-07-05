// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_free_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdFreeState {
  bool get hasAdFree => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdFreeStateCopyWith<AdFreeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdFreeStateCopyWith<$Res> {
  factory $AdFreeStateCopyWith(
          AdFreeState value, $Res Function(AdFreeState) then) =
      _$AdFreeStateCopyWithImpl<$Res, AdFreeState>;
  @useResult
  $Res call({bool hasAdFree, String? price});
}

/// @nodoc
class _$AdFreeStateCopyWithImpl<$Res, $Val extends AdFreeState>
    implements $AdFreeStateCopyWith<$Res> {
  _$AdFreeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasAdFree = null,
    Object? price = freezed,
  }) {
    return _then(_value.copyWith(
      hasAdFree: null == hasAdFree
          ? _value.hasAdFree
          : hasAdFree // ignore: cast_nullable_to_non_nullable
              as bool,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdFreeStateImplCopyWith<$Res>
    implements $AdFreeStateCopyWith<$Res> {
  factory _$$AdFreeStateImplCopyWith(
          _$AdFreeStateImpl value, $Res Function(_$AdFreeStateImpl) then) =
      __$$AdFreeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasAdFree, String? price});
}

/// @nodoc
class __$$AdFreeStateImplCopyWithImpl<$Res>
    extends _$AdFreeStateCopyWithImpl<$Res, _$AdFreeStateImpl>
    implements _$$AdFreeStateImplCopyWith<$Res> {
  __$$AdFreeStateImplCopyWithImpl(
      _$AdFreeStateImpl _value, $Res Function(_$AdFreeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasAdFree = null,
    Object? price = freezed,
  }) {
    return _then(_$AdFreeStateImpl(
      hasAdFree: null == hasAdFree
          ? _value.hasAdFree
          : hasAdFree // ignore: cast_nullable_to_non_nullable
              as bool,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AdFreeStateImpl implements _AdFreeState {
  _$AdFreeStateImpl({required this.hasAdFree, required this.price});

  @override
  final bool hasAdFree;
  @override
  final String? price;

  @override
  String toString() {
    return 'AdFreeState(hasAdFree: $hasAdFree, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdFreeStateImpl &&
            (identical(other.hasAdFree, hasAdFree) ||
                other.hasAdFree == hasAdFree) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasAdFree, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdFreeStateImplCopyWith<_$AdFreeStateImpl> get copyWith =>
      __$$AdFreeStateImplCopyWithImpl<_$AdFreeStateImpl>(this, _$identity);
}

abstract class _AdFreeState implements AdFreeState {
  factory _AdFreeState(
      {required final bool hasAdFree,
      required final String? price}) = _$AdFreeStateImpl;

  @override
  bool get hasAdFree;
  @override
  String? get price;
  @override
  @JsonKey(ignore: true)
  _$$AdFreeStateImplCopyWith<_$AdFreeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
