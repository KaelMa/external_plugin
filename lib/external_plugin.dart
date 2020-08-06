import 'dart:async';

import 'package:flutter/services.dart';

class ExternalPlugin {
  static const MethodChannel _channel =
      const MethodChannel('external_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
