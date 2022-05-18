import 'package:flutter/foundation.dart';

/// Allows you to determine platform details such as operating system or environment
class PlatformDetails {
  static final PlatformDetails _singleton = PlatformDetails._internal();

  factory PlatformDetails() {
    return _singleton;
  }

  PlatformDetails._internal();

  /// This parameter checks if the current platform is macos, linux or windows. THE WEB PLATFORM IS NOT INCLUDED!
  bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows;

  /// This parameter checks if the current platform is iOS, Android or Fuchsia.
  bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.fuchsia;

  /// This parameter checks if the current platform is web or not.
  bool get isWeb =>
      defaultTargetPlatform != TargetPlatform.macOS &&
      defaultTargetPlatform != TargetPlatform.linux &&
      defaultTargetPlatform != TargetPlatform.windows &&
      defaultTargetPlatform != TargetPlatform.iOS &&
      defaultTargetPlatform != TargetPlatform.android &&
      defaultTargetPlatform != TargetPlatform.fuchsia;

  /// This parameter calls the isDesktop and isMobile methods to detect if the current platform is desktop or web
  bool get isDesktopOrWeb => isDesktop || !isMobile;

  /// Check if the platform on which the code is running is iOS
  bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  /// Check if the platform on which the code is running is Android
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  /// Check if the platform on which the code is running is Fuchsia
  bool get isFuchsia => defaultTargetPlatform == TargetPlatform.fuchsia;

  /// Check if the platform on which the code is running is Windows
  bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  /// Check if the platform on which the code is running is Linux
  bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  /// Check if the platform on which the code is running is macOS
  bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
}
