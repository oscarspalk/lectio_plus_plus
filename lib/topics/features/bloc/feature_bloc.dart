import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FeatureStates { ny, inProgress, done, removed }

extension ExtendedFeatureStates on FeatureStates {
  String getCode() {
    switch (this) {
      case FeatureStates.done:
        return "done";
      case FeatureStates.inProgress:
        return "in-progress";
      case FeatureStates.ny:
        return "new";
      case FeatureStates.removed:
        return "removed";
    }
  }
}

class Feature {
  FeatureStates status;
  
}

const String serverUrl =
    kDebugMode ? "http://localhost:5173/" : "https://spalk.io/";

class FeatureState {
  Map<FeatureStates, List<
}

class FeatureCubit extends Cubit {
  FeatureCubit(super.initialState);


}
