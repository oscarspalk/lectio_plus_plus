import 'package:flutter_test/flutter_test.dart';
import 'package:lectio_plus_plus/app/app.dart';
import 'package:lectio_plus_plus/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
