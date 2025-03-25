import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screen_usage_tally_method_channel.dart';

abstract class ScreenUsageTallyPlatform extends PlatformInterface {
  /// Constructs a ScreenUsageTallyPlatform.
  ScreenUsageTallyPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScreenUsageTallyPlatform _instance = MethodChannelScreenUsageTally();

  /// The default instance of [ScreenUsageTallyPlatform] to use.
  ///
  /// Defaults to [MethodChannelScreenUsageTally].
  static ScreenUsageTallyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScreenUsageTallyPlatform] when
  /// they register themselves.
  static set instance(ScreenUsageTallyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    print('platformVersion() has not been implemented.');
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
