package com.ssharanyab.screen_usage_tally

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class ScreenUsageTallyPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private var startTime: Long = 0
  private var totalUsageTime: Long = 0

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "screen_usage_tally")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "startTracking" -> startTracking(result)
      "stopTracking" -> stopTracking(result)
      "getUsageTime" -> getUsageTime(result)
      else -> result.notImplemented()
    }
  }

  private fun startTracking(result: Result) {
    startTime = System.currentTimeMillis()
    result.success(null)
  }

  private fun stopTracking(result: Result) {
    if (startTime > 0) {
      totalUsageTime += System.currentTimeMillis() - startTime
      startTime = 0
    }
    result.success(null)
  }

  private fun getUsageTime(result: Result) {
    val currentTime = if (startTime > 0) System.currentTimeMillis() - startTime else 0
    result.success(totalUsageTime + currentTime)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
