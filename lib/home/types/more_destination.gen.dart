// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'more_destination.dart';

class _$MoreDestinationImpl extends MoreDestination {
  _$MoreDestinationImpl() : super.ctor();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MoreDestination && runtimeType == other.runtimeType;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'MoreDestination{<optimized out>}';
    assert(() {
      toStringOutput = 'MoreDestination@<$hexIdentity>{}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => MoreDestination;
}

abstract interface class _MoreDestinationCopyWithProxy {
  MoreDestination call();
}

class _MoreDestinationCopyWithProxyImpl
    implements _MoreDestinationCopyWithProxy {
  _MoreDestinationCopyWithProxyImpl(this._value);

  final MoreDestination _value;

  @pragma('vm:prefer-inline')
  @override
  MoreDestination call() {
    return _$MoreDestinationImpl();
  }
}

sealed class $MoreDestinationCopyWithProxyChain<$Result> {
  factory $MoreDestinationCopyWithProxyChain(final MoreDestination value,
          final $Result Function(MoreDestination update) chain) =
      _MoreDestinationCopyWithProxyChainImpl<$Result>;

  $Result call();
}

class _MoreDestinationCopyWithProxyChainImpl<$Result>
    implements $MoreDestinationCopyWithProxyChain<$Result> {
  _MoreDestinationCopyWithProxyChainImpl(this._value, this._chain);

  final MoreDestination _value;
  final $Result Function(MoreDestination update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result call() {
    return _chain(_$MoreDestinationImpl());
  }
}

extension $MoreDestinationExtension on MoreDestination {
  _MoreDestinationCopyWithProxy get copyWith =>
      _MoreDestinationCopyWithProxyImpl(this);
}
