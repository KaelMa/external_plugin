import 'dart:async';

import 'package:flutter/services.dart';

class ExternalPlugin {
  static const MethodChannel _channel = const MethodChannel('external_plugin');

  int textureId;

  bool get isInitialized => textureId != null;

  /// 初始化textureId
  Future<int> initialize(int width, int height) async {
    textureId = await _channel.invokeMethod('create', {
      'width': width,
      'height': height,
    });
    return textureId;
  }

  /// dispose
  Future<Null> dispose() => _channel.invokeMethod('dispose', {'textureId': textureId});

}
