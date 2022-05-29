import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import '../models/enums/platform_type.dart';

class PlatformProvider with ChangeNotifier {
  update() {}

  late PlatformType _currentPlatform;
  late bool _isAndroid;

  PlatformType get currentPlatform {
    return _currentPlatform;
  }

  bool get isAndroid {
    return _isAndroid;
  }

  PlatformProvider() {
    _currentPlatform = _getCurrentPlatformType();
  }

  PlatformType _getCurrentPlatformType() {
    if (kIsWeb) {
      _isAndroid = true;
      return PlatformType.android;
    } else if (Platform.isAndroid) {
      _isAndroid = true;
      return PlatformType.android;
    } else if (Platform.isIOS) {
      _isAndroid = false;
      return PlatformType.iOS;
    } else {
      _isAndroid = true;
      return PlatformType.android;
    }
  }
}
