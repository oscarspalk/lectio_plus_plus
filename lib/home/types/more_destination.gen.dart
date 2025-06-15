// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'more_destination.dart';

class _$MoreDestinationImpl extends MoreDestination {
  _$MoreDestinationImpl({
    required this.route,
    required this.icon,
    required this.label,
  }) : super.ctor();

  @override
  final PageRouteInfo route;

  @override
  final IconData icon;

  @override
  final String label;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MoreDestination &&
            runtimeType == other.runtimeType &&
            route == other.route &&
            icon == other.icon &&
            label == other.label;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      route,
      icon,
      label,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'MoreDestination{<optimized out>}';
    assert(() {
      toStringOutput =
          'MoreDestination@<$hexIdentity>{route: $route, icon: $icon, label: $label}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => MoreDestination;
}

abstract interface class _MoreDestinationCopyWithProxy {
  MoreDestination route(PageRouteInfo newValue);

  MoreDestination icon(IconData newValue);

  MoreDestination label(String newValue);

  MoreDestination call({
    final PageRouteInfo? route,
    final IconData? icon,
    final String? label,
  });
}

class _MoreDestinationCopyWithProxyImpl
    implements _MoreDestinationCopyWithProxy {
  _MoreDestinationCopyWithProxyImpl(this._value);

  final MoreDestination _value;

  @pragma('vm:prefer-inline')
  @override
  MoreDestination route(PageRouteInfo newValue) => this(route: newValue);

  @pragma('vm:prefer-inline')
  @override
  MoreDestination icon(IconData newValue) => this(icon: newValue);

  @pragma('vm:prefer-inline')
  @override
  MoreDestination label(String newValue) => this(label: newValue);

  @pragma('vm:prefer-inline')
  @override
  MoreDestination call({
    final PageRouteInfo? route,
    final IconData? icon,
    final String? label,
  }) {
    return _$MoreDestinationImpl(
      route: route ?? _value.route,
      icon: icon ?? _value.icon,
      label: label ?? _value.label,
    );
  }
}

sealed class $MoreDestinationCopyWithProxyChain<$Result> {
  factory $MoreDestinationCopyWithProxyChain(final MoreDestination value,
          final $Result Function(MoreDestination update) chain) =
      _MoreDestinationCopyWithProxyChainImpl<$Result>;

  $Result route(PageRouteInfo newValue);

  $Result icon(IconData newValue);

  $Result label(String newValue);

  $Result call({
    final PageRouteInfo? route,
    final IconData? icon,
    final String? label,
  });
}

class _MoreDestinationCopyWithProxyChainImpl<$Result>
    implements $MoreDestinationCopyWithProxyChain<$Result> {
  _MoreDestinationCopyWithProxyChainImpl(this._value, this._chain);

  final MoreDestination _value;
  final $Result Function(MoreDestination update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result route(PageRouteInfo newValue) => this(route: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result icon(IconData newValue) => this(icon: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result label(String newValue) => this(label: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final PageRouteInfo? route,
    final IconData? icon,
    final String? label,
  }) {
    return _chain(_$MoreDestinationImpl(
      route: route ?? _value.route,
      icon: icon ?? _value.icon,
      label: label ?? _value.label,
    ));
  }
}

extension $MoreDestinationExtension on MoreDestination {
  _MoreDestinationCopyWithProxy get copyWith =>
      _MoreDestinationCopyWithProxyImpl(this);
}
