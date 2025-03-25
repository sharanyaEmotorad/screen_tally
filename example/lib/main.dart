import 'dart:io';

import 'package:flutter/material.dart';
import 'package:screen_usage_tally/screen_usage_tally.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Usage Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScreenUsageTally _tracker = ScreenUsageTally();

  @override
  void initState() {
    super.initState();
    _tracker.startTracking();
  }

  @override
  void dispose() {
    _tracker.stopTracking();
    super.dispose();
  }

  void _showUsageTime() async {
    int usageTimeMs = await _tracker.getUsageTime();
    double usageTimeSec = Platform.isAndroid ? usageTimeMs / 1000 : usageTimeMs.toDouble(); // Already in seconds

    if (!mounted) return; // Prevents calling dialog if widget is disposed

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("App Usage Time"),
        content: Text("You have used the app for ${usageTimeSec.toStringAsFixed(2)} seconds."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Usage Tracker")),
      body: Center(
        child: ElevatedButton(
          onPressed: _showUsageTime,
          child: const Text("Show Usage Time"),
        ),
      ),
    );
  }
}
