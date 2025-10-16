import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poc/widgets/app_layout.dart';

class BatteryPercentage extends StatefulWidget {
  const BatteryPercentage({super.key});

  @override
  State<BatteryPercentage> createState() => _BatteryPercentageState();
}

class _BatteryPercentageState extends State<BatteryPercentage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  static String _batteryLevel = 'Unknown battery level.';

  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
