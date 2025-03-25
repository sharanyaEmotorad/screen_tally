import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:screen_usage_tally/screen_usage_tally.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ScreenUsageTally tracks time correctly', (WidgetTester tester) async {
    final ScreenUsageTally screenUsageTally = ScreenUsageTally();
    // Start tracking
    screenUsageTally.startTracking();
    await Future.delayed(Duration(seconds: 3)); // Simulate 3 sec app usage

    // Stop tracking and get usage time
    screenUsageTally.stopTracking();
    int usageTime = await screenUsageTally.getUsageTime();

    print('Tracked Usage Time: $usageTime seconds');

    // Assert that time is greater than or equal to 3 seconds
    expect(usageTime, greaterThanOrEqualTo(3.0));
  });
}
