import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_free_state.freezed.dart';

@freezed
class AdFreeState with _$AdFreeState {
  factory AdFreeState({required bool hasAdFree, required String? price}) =
      _AdFreeState;
}
