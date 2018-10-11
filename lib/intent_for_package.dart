import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:platform/platform.dart';

const String kChannelName = 'plugins.sadcoat.com/intent_for_package';

/// Flutter plugin for launching a main activity for a package
class IntentForPackage {
  /// Create an IntentForPackage object
  /// [package] package to open main activity
  /// [storeUrl] Play store url to fallback if package is not installed
  const IntentForPackage({
    @required this.package,
    this.storeUrl,
  })  :
    assert(package != null),
    assert(package.length > 0),
    _channel = const MethodChannel(kChannelName),
    _platform = const LocalPlatform();

  final String package;
  final String storeUrl;
  final MethodChannel _channel;
  final Platform _platform;

  /// Launch the app.
  ///
  /// This works only on Android platforms. Please guard the call so that your
  /// iOS app does not crash. Checked mode will throw an assert exception.
  Future<Null> launch() async {
    assert(_platform.isAndroid);
    await _channel.invokeMethod('launch', 
      <String, Object>{
        'package': package,
        'storeUrl': storeUrl,
      },
    );
  }

  /// Check if the package can be launched
  ///
  /// This works only on Android platforms. Please guard the call so that your
  /// iOS app does not crash. Checked mode will throw an assert exception.
  Future<bool> canLaunch() async {
    assert(_platform.isAndroid);
    return await _channel.invokeMethod('canLaunch', 
      <String, Object>{
        'package': package,
      },
    );
  }  
}
