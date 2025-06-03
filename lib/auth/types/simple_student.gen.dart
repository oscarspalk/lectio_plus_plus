// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'simple_student.dart';

class _$SimpleStudentImpl extends SimpleStudent {
  _$SimpleStudentImpl({
    required this.studentId,
    required this.gymId,
  }) : super.ctor();

  @override
  final String studentId;

  @override
  final int gymId;

  factory _$SimpleStudentImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$SimpleStudentImpl(
      studentId: json['studentId'] as String,
      gymId: (json['gymId'] as num).toInt(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'studentId': studentId,
      'gymId': gymId,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SimpleStudent &&
            runtimeType == other.runtimeType &&
            studentId == other.studentId &&
            gymId == other.gymId;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      studentId,
      gymId,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'SimpleStudent{<optimized out>}';
    assert(() {
      toStringOutput =
          'SimpleStudent@<$hexIdentity>{studentId: $studentId, gymId: $gymId}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => SimpleStudent;
}

abstract interface class _SimpleStudentCopyWithProxy {
  SimpleStudent studentId(String newValue);

  SimpleStudent gymId(int newValue);

  SimpleStudent call({
    final String? studentId,
    final int? gymId,
  });
}

class _SimpleStudentCopyWithProxyImpl implements _SimpleStudentCopyWithProxy {
  _SimpleStudentCopyWithProxyImpl(this._value);

  final SimpleStudent _value;

  @pragma('vm:prefer-inline')
  @override
  SimpleStudent studentId(String newValue) => this(studentId: newValue);

  @pragma('vm:prefer-inline')
  @override
  SimpleStudent gymId(int newValue) => this(gymId: newValue);

  @pragma('vm:prefer-inline')
  @override
  SimpleStudent call({
    final String? studentId,
    final int? gymId,
  }) {
    return _$SimpleStudentImpl(
      studentId: studentId ?? _value.studentId,
      gymId: gymId ?? _value.gymId,
    );
  }
}

sealed class $SimpleStudentCopyWithProxyChain<$Result> {
  factory $SimpleStudentCopyWithProxyChain(final SimpleStudent value,
          final $Result Function(SimpleStudent update) chain) =
      _SimpleStudentCopyWithProxyChainImpl<$Result>;

  $Result studentId(String newValue);

  $Result gymId(int newValue);

  $Result call({
    final String? studentId,
    final int? gymId,
  });
}

class _SimpleStudentCopyWithProxyChainImpl<$Result>
    implements $SimpleStudentCopyWithProxyChain<$Result> {
  _SimpleStudentCopyWithProxyChainImpl(this._value, this._chain);

  final SimpleStudent _value;
  final $Result Function(SimpleStudent update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result studentId(String newValue) => this(studentId: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result gymId(int newValue) => this(gymId: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? studentId,
    final int? gymId,
  }) {
    return _chain(_$SimpleStudentImpl(
      studentId: studentId ?? _value.studentId,
      gymId: gymId ?? _value.gymId,
    ));
  }
}

extension $SimpleStudentExtension on SimpleStudent {
  _SimpleStudentCopyWithProxy get copyWith =>
      _SimpleStudentCopyWithProxyImpl(this);
}
