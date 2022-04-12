import 'package:flutter/foundation.dart' as foundation;

List<foundation.TargetPlatform> webList = [
  foundation.TargetPlatform.linux,
  foundation.TargetPlatform.macOS,
  foundation.TargetPlatform.windows
];

bool get isIos {
  return foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
}

bool get isAndroid {
  return foundation.defaultTargetPlatform == foundation.TargetPlatform.android;
}
