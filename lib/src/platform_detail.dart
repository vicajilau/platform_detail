import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// It groups in an enumerated list the type of platform on which a Flutter application can be run.
enum PlatformGroup { mobile, desktop, web }

/// Groups in an enumerated list the type of theme the device is configured with.
enum DeviceTheme { light, dark }

/// Allows you to determine platform details such as operating system or environment.
class PlatformDetail {
  /// This parameter returns an enum with the group of platform related.
  static PlatformGroup get currentGroupPlatform {
    if (isWeb) {
      return PlatformGroup.web;
    } else if (isDesktop) {
      return PlatformGroup.desktop;
    } else if (isMobile) {
      return PlatformGroup.mobile;
    }
    throw Exception('Platform ($defaultTargetPlatform) unrecognized.');
  }

  /// This parameter returns the current platform.
  static TargetPlatform get currentPlatform {
    return defaultTargetPlatform;
  }

  /// This parameter returns an enum with the group of platform related.
  static PlatformGroup get type {
    if (isWeb) {
      return PlatformGroup.web;
    } else if (isDesktop) {
      return PlatformGroup.desktop;
    } else if (isMobile) {
      return PlatformGroup.mobile;
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

  /// This parameter calls the isDesktop and isMobile methods to detect if the current platform is desktop or web.
  static bool get isDesktopOrWeb => isDesktop || isWeb;

  /// Check if the platform on which the code is running is iOS.
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  /// Check if the platform on which the code is running is Android.
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  /// Check if the platform on which the code is running is Fuchsia.
  static bool get isFuchsia => defaultTargetPlatform == TargetPlatform.fuchsia;

  /// Check if the platform on which the code is running is Windows.
  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  /// Check if the platform on which the code is running is Linux.
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  /// Check if the platform on which the code is running is macOS.
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  /// This parameter returns the industrial name and OS version of the current device.
  /// EXAMPLES:
  /// Android: Android 9 (SDK 28), Xiaomi Redmi Note 7
  /// iOS: iOS 13.1, iPhone 11 Pro Max iPhone
  /// Web: Google Chrome (115.0.5790.170)
  /// Linux: Fedora 17 (Beefy Miracle)
  /// Windows: Windows 10 Home (1903)
  /// MacOS: macOS 13.5, MacBook Pro
  static Future<String> deviceInfo() async {
    if (PlatformDetail.isWeb) {
      final info = await DeviceInfoPlugin().webBrowserInfo;
      return '${info.browserName.name} (${info.appVersion})';
    }

    switch (PlatformDetail.currentPlatform) {
      case TargetPlatform.android:
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final release = androidInfo.version.release;
        final sdkInt = androidInfo.version.sdkInt;
        final manufacturer = androidInfo.manufacturer;
        final model = androidInfo.model;
        final simulator = !androidInfo.isPhysicalDevice;
        return 'Android $release (SDK $sdkInt), $manufacturer $model, (simulator: $simulator)';
      case TargetPlatform.fuchsia:
        final fuchsiaInfo = await DeviceInfoPlugin().androidInfo;
        final release = fuchsiaInfo.version.release;
        final sdkInt = fuchsiaInfo.version.sdkInt;
        final manufacturer = fuchsiaInfo.manufacturer;
        final model = fuchsiaInfo.model;
        final simulator = !fuchsiaInfo.isPhysicalDevice;
        return 'Fuchsia $release (SDK $sdkInt), $manufacturer $model, (simulator: $simulator)';
      case TargetPlatform.iOS:
        var iosInfo = await DeviceInfoPlugin().iosInfo;
        var systemName = iosInfo.systemName;
        var version = iosInfo.systemVersion;
        var name = iosInfo.name;
        var model = iosInfo.model;
        var simulator = !iosInfo.isPhysicalDevice;
        return '$systemName $version, $name $model, (simulator: $simulator)';
      case TargetPlatform.linux:
        final info = await DeviceInfoPlugin().linuxInfo;
        return info.prettyName;
      case TargetPlatform.macOS:
        final info = await DeviceInfoPlugin().macOsInfo;
        return "macOS ${info.osRelease}, ${info.model}";
      case TargetPlatform.windows:
        final info = await DeviceInfoPlugin().windowsInfo;
        return "${info.productName}(${info.releaseId})";
    }
  }

  /// Check if the device has enabled Dark Mode.
  static bool get isDarkMode {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  /// Check if the device has Light Mode.
  static bool get isLightMode {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.light;
  }

  /// Returns the type of theme applied to the device.
  static DeviceTheme get theme =>
      isLightMode ? DeviceTheme.light : DeviceTheme.dark;
}
