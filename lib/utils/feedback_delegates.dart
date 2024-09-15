import 'dart:ui';

import 'package:feedback/feedback.dart';

class CustomFeedbackLocalizations implements FeedbackLocalizations {
  @override
  String get draw => "Tegn";

  @override
  String get feedbackDescriptionText => "Hvad mangler eller kunne fikses?";

  @override
  String get navigate => "Naviger";

  @override
  String get submitButtonText => "Færdig";
}

class CustomFeedbackLocalizationsDelegate
    extends GlobalFeedbackLocalizationsDelegate {
  @override
  Map<Locale, FeedbackLocalizations> get supportedLocales =>
      <Locale, FeedbackLocalizations>{
        const Locale('da'): CustomFeedbackLocalizations(),
        const Locale('en'): CustomFeedbackLocalizations()
      };
}
