import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screen_usage_tally_platform_interface.dart';

/// An implementation of [ScreenUsageTallyPlatform] that uses method channels.
class MethodChannelScreenUsageTally extends ScreenUsageTallyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('screen_usage_tally');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
