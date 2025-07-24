import 'package:flutter/material.dart';
import 'package:m1/core/services/device_info_service.dart';
import 'package:m1/core/services/service_locator.dart';

class DeviceInfoWidget extends StatelessWidget {
  const DeviceInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceInfo = getIt<DeviceInfoService>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Device: \\${deviceInfo.deviceModel ?? "Unknown"}'),
        Text('OS Version: \\${deviceInfo.osVersion ?? "Unknown"}'),
      ],
    );
  }
} 