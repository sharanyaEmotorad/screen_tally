import 'package:flutter_test/flutter_test.dart';
import 'package:screen_usage_tally/screen_usage_tally.dart';
import 'package:screen_usage_tally/screen_usage_tally_platform_interface.dart';
import 'package:screen_usage_tally/screen_usage_tally_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScreenUsageTallyPlatform
    with MockPlatformInterfaceMixin
    implements ScreenUsageTallyPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ScreenUsageTallyPlatform initialPlatform = ScreenUsageTallyPlatform.instance;

  test('$MethodChannelScreenUsageTally is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScreenUsageTally>());
  });

  test('getPlatformVersion', () async {
    ScreenUsageTally screenUsageTallyPlugin = ScreenUsageTally();
    MockScreenUsageTallyPlatform fakePlatform = MockScreenUsageTallyPlatform();
    ScreenUsageTallyPlatform.instance = fakePlatform;

    expect(await screenUsageTallyPlugin.getPlatformVersion(), '42');
  });
}
