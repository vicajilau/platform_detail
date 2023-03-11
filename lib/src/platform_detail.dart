import 'package:flutter/foundation.dart';

/// It groups in an enumerated list the type of platform on which a Flutter application can be run.
enum PlatformGroup { mobile, desktop, web }

/// Allows you to determine platform details such as operating system or environment
class PlatformDetails {
  /// This parameter returns an enum with the group of platform related
  static PlatformGroup get type {
    if (isDesktop) {
      return PlatformGroup.desktop;
    } else if (isMobile) {
      return PlatformGroup.mobile;
    } else if (isWeb) {
      return PlatformGroup.web;
    }
    throw Exception('Platform ($defaultTargetPlatform) unrecognized.');
  }

  /// This parameter checks if the current platform is macos, linux or windows. THE WEB PLATFORM IS NOT INCLUDED!
  static bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows;

  /// This parameter checks if the current platform is iOS, Android or Fuchsia.
  static bool get isMobile =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.fuchsia;

  /// This parameter checks if the current platform is web or not.
  static bool get isWeb => kIsWeb;

  /// This parameter calls the isDesktop and isMobile methods to detect if the current platform is desktop or web
  static bool get isDesktopOrWeb => isDesktop || isWeb;

  /// Check if the platform on which the code is running is iOS
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  /// Check if the platform on which the code is running is Android
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  /// Check if the platform on which the code is running is Fuchsia
  static bool get isFuchsia => defaultTargetPlatform == TargetPlatform.fuchsia;

  /// Check if the platform on which the code is running is Windows
  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  /// Check if the platform on which the code is running is Linux
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  /// Check if the platform on which the code is running is macOS
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;
}
