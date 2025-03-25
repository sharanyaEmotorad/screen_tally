import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ScreenUsageTally with WidgetsBindingObserver {
  static const MethodChannel _channel = MethodChannel('screen_usage_tally');

  ScreenUsageTally._internal();
  static final ScreenUsageTally _instance = ScreenUsageTally._internal();
  factory ScreenUsageTally() => _instance;

  void startTracking() {
    WidgetsBinding.instance.addObserver(this);
    _channel.invokeMethod('startTracking');
  }

  void stopTracking() {
    WidgetsBinding.instance.removeObserver(this);
    _channel.invokeMethod('stopTracking');
  }

  Future<int> getUsageTime() async {
    return await _channel.invokeMethod<int>('getUsageTime') ?? 0;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _channel.invokeMethod('stopTracking');
    } else if (state == AppLifecycleState.resumed) {
      _channel.invokeMethod('startTracking');
    }
  }
}
