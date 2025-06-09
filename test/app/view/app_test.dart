import 'package:flutter_test/flutter_test.dart';
import 'package:lectio_plus_plus/lpp.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(SelectGymPage), findsOneWidget);
    });
  });
}
