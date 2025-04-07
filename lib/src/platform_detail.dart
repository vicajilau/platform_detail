import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'network/network_utils.dart';

/// It groups in an enumerated list the type of platform on which a Flutter application can be run.
enum PlatformGroup { mobile, desktop, web }

/// Groups in an enumerated list the type of theme the device is configured with.
enum DeviceTheme { light, dark }

/// Allows you to determine platform details such as operating system or environment.
class PlatformDetail {
  /// Instance of `DeviceInfoPlugin` used to retrieve platform-specific device information.
  /// In production, it uses the default implementation.
  /// For testing, a mock can be injected via the `PlatformDetail.forTesting` factory constructor.
  static DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Instance of `DeviceInfoPlugin` used to retrieve platform-specific device information.
  /// In production, it uses the default implementation.
  /// For testing, a mock can be injected via the `PlatformDetail.forTesting` factory constructor.
  static PlatformDispatcher _platformDispatcher =
      SchedulerBinding.instance.platformDispatcher;

  /// Instance of `HttpClient` used to request Uri in IP getters.
  /// In production, it uses the default implementation.
  /// For testing, a mock can be injected via the `PlatformDetail.forTesting` factory constructor.

  /// Testing purposes!!!
  /// Allows injecting a mocked `DeviceInfoPlugin` and `PlatformDispatcher`.
  static forTesting(
    DeviceInfoPlugin mockDeviceInfo,
    PlatformDispatcher mockPlatformDispatcher,
  ) {
    _deviceInfo = mockDeviceInfo;
    _platformDispatcher = mockPlatformDispatcher;
  }

  /// Returns an enum with the group of platform related.
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

  /// Returns the current platform type (e.g., Android, iOS, etc.).
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

  /// Checks if the current platform is a desktop OS.
  /// Includes macOS, Linux, and Windows.
  static bool get isDesktop {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows;
  }

  /// This parameter checks if the current platform is iOS, Android or Fuchsia.
  static bool get isMobile {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.fuchsia;
  }

  /// Checks if the current platform is Web.
  static bool get isWeb => kIsWeb;

  /// This parameter calls the isDesktop and isMobile methods to detect if the current platform is desktop or web.
  static bool get isDesktopOrWeb => isWeb || isDesktop;

  /// Check if the platform on which the code is running is iOS.
  static bool get isIOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Check if the platform on which the code is running is Android.
  static bool get isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Check if the platform on which the code is running is Fuchsia.
  static bool get isFuchsia =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.fuchsia;

  /// Check if the platform on which the code is running is Windows.
  static bool get isWindows =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;

  /// Check if the platform on which the code is running is Linux.
  static bool get isLinux =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;

  /// Check if the platform on which the code is running is macOS.
  static bool get isMacOS =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

  /// Retrieves detailed device information based on the current platform.
  ///
  /// This method is asynchronous and returns a [BaseDeviceInfo] object containing
  /// platform-specific details about the device. Depending on the platform, it will return:
  /// Android: Android 9 (SDK 28), Xiaomi Redmi Note 7
  /// iOS: iOS 13.1, iPhone 11 Pro Max iPhone
  /// Web: Google Chrome (115.0.5790.170)
  /// Linux: Fedora 17 (Beefy Miracle)
  /// Windows: Windows 10 Home (1903)
  /// MacOS: macOS 13.5, MacBook Pro
  ///
  /// Throws:
  /// - An [Exception] if the platform is not recognized or unsupported.
  ///
  /// Returns:
  /// - A [Future<String>] with detailed information about the device.
  static Future<String> deviceInfoDetails() async {
    if (PlatformDetail.isWeb) {
      final info = await _deviceInfo.webBrowserInfo;
      return '${info.browserName.name} (${info.appVersion})';
    }

    switch (currentPlatform) {
      case TargetPlatform.android:
        final androidInfo = await _deviceInfo.androidInfo;
        return 'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt}), '
            '${androidInfo.manufacturer} ${androidInfo.model}, (simulator: ${!androidInfo.isPhysicalDevice})';
      case TargetPlatform.iOS:
        final iosInfo = await _deviceInfo.iosInfo;
        return '${iosInfo.systemName} ${iosInfo.systemVersion}, ${iosInfo.name} ${iosInfo.model}, (simulator: ${!iosInfo.isPhysicalDevice})';
      case TargetPlatform.linux:
        final linuxInfo = await _deviceInfo.linuxInfo;
        return linuxInfo.prettyName;
      case TargetPlatform.macOS:
        final macosInfo = await _deviceInfo.macOsInfo;
        return "macOS ${macosInfo.osRelease}, ${macosInfo.model}";
      case TargetPlatform.windows:
        final windowsInfo = await _deviceInfo.windowsInfo;
        return "${windowsInfo.productName}(${windowsInfo.releaseId})";
      default:
        throw Exception('Platform ($currentPlatform) not recognized.');
    }
  }

  /// Retrieves detailed device information based on the current platform.
  ///
  /// This method is asynchronous and returns a [BaseDeviceInfo] object containing
  /// platform-specific details about the device. Depending on the platform, it will return:
  /// - [WebBrowserInfo] for web platforms.
  /// - [AndroidDeviceInfo] for Android devices.
  /// - [IosDeviceInfo] for iOS devices.
  /// - [LinuxDeviceInfo] for Linux systems.
  /// - [MacOsDeviceInfo] for macOS systems.
  /// - [WindowsDeviceInfo] for Windows systems.
  ///
  /// Throws:
  /// - An [Exception] if the platform is not recognized or unsupported.
  ///
  /// Returns:
  /// - A [Future<BaseDeviceInfo>] with detailed information about the device.
  static Future<BaseDeviceInfo> deviceInfo() async {
    if (PlatformDetail.isWeb) {
      return await _deviceInfo.webBrowserInfo;
    }

    switch (currentPlatform) {
      case TargetPlatform.android:
        return await _deviceInfo.androidInfo;
      case TargetPlatform.iOS:
        return await _deviceInfo.iosInfo;
      case TargetPlatform.linux:
        return await _deviceInfo.linuxInfo;
      case TargetPlatform.macOS:
        return await _deviceInfo.macOsInfo;
      case TargetPlatform.windows:
        return await _deviceInfo.windowsInfo;
      default:
        throw Exception('Platform ($currentPlatform) not recognized.');
    }
  }

  /// Checks if the device is in Dark Mode.
  static bool get isDarkMode =>
      _platformDispatcher.platformBrightness == Brightness.dark;

  /// Checks if the device is in Light Mode.
  static bool get isLightMode =>
      _platformDispatcher.platformBrightness == Brightness.light;

  /// Returns the current theme of the device (Light or Dark).
  static DeviceTheme get theme =>
      isLightMode ? DeviceTheme.light : DeviceTheme.dark;

  /// Returns the current public IP of the device (v4 or v6).
  static Future<String?> get getPublicIp => NetworkUtils.getPublicIp;

  /// Returns the current private IP List (without loopback) of the device.
  static Future<List<String>> get getPrivateIp => NetworkUtils.getPrivateIps();
}
