import Flutter
import UIKit

public class ScreenUsageTallyPlugin: NSObject, FlutterPlugin {

    private var startTime: TimeInterval? = nil
    private var totalUsageTime: TimeInterval = 0.0
    private var isTracking = false

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "screen_usage_tally", binaryMessenger: registrar.messenger())
        let instance = ScreenUsageTallyPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startTracking":
            startTime = ProcessInfo.processInfo.systemUptime  // ✅ More accurate than DispatchTime
            isTracking = true
            result(nil)

        case "stopTracking":
            if isTracking, let start = startTime {
                let elapsed = ProcessInfo.processInfo.systemUptime - start
                totalUsageTime += elapsed
                isTracking = false
            }
            result(nil)

        case "getUsageTime":
            var currentUsageTime = totalUsageTime
            if isTracking, let start = startTime {
                let elapsed = ProcessInfo.processInfo.systemUptime - start
                currentUsageTime += elapsed
            }
            result(Int(currentUsageTime.rounded())) // ✅ Returns seconds
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
