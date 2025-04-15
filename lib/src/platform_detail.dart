import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:platform_detail/src/target_platform_extension.dart';

import '../platform_detail.dart';
import 'network/network_utils.dart';

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

  static NetworkUtils _networkUtils = NetworkUtils();
  static bool _mockedWeb = false;

  /// Testing purposes!!!
  /// Allows injecting a mocked `DeviceInfoPlugin`, `PlatformDispatcher`, and `NetworkUtils`.
  static void forTesting({
    DeviceInfoPlugin? mockDeviceInfo,
    PlatformDispatcher? mockPlatformDispatcher,
    NetworkUtils? mockNetworkUtils,
    mockedWeb = false,
  }) {
    _deviceInfo = mockDeviceInfo ?? _deviceInfo;
    _platformDispatcher = mockPlatformDispatcher ?? _platformDispatcher;
    _networkUtils = mockNetworkUtils ?? _networkUtils;
    _mockedWeb = mockedWeb;
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

  /// Returns the current platform type, including support for web.
  static PlatformType get currentPlatform {
    if (_mockedWeb || kIsWeb) return PlatformType.web;
    return defaultTargetPlatform.toPlatformType();
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
  static bool get isWeb => _mockedWeb || kIsWeb;

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
    switch (currentPlatform) {
      case PlatformType.android:
        final androidInfo = await _deviceInfo.androidInfo;
        return 'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt}), '
            '${androidInfo.manufacturer} ${androidInfo.model}, (simulator: ${!androidInfo.isPhysicalDevice})';
      case PlatformType.fuchsia:
        final genericDeviceInfo = await _deviceInfo.deviceInfo;
        return 'Fuchsia $genericDeviceInfo';
      case PlatformType.iOS:
        final iosInfo = await _deviceInfo.iosInfo;
        return '${iosInfo.systemName} ${iosInfo.systemVersion}, ${iosInfo.name} ${iosInfo.model}, (simulator: ${!iosInfo.isPhysicalDevice})';
      case PlatformType.linux:
        final linuxInfo = await _deviceInfo.linuxInfo;
        return linuxInfo.prettyName;
      case PlatformType.macOS:
        final macosInfo = await _deviceInfo.macOsInfo;
        return "macOS ${macosInfo.osRelease}, ${macosInfo.model}";
      case PlatformType.windows:
        final windowsInfo = await _deviceInfo.windowsInfo;
        return "${windowsInfo.productName}(${windowsInfo.releaseId})";
      case PlatformType.web:
        final info = await _deviceInfo.webBrowserInfo;
        return '${info.browserName.name} (${info.appVersion})';
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
  /// - [BaseDeviceInfo] for Fuchsia systems.
  ///
  /// Throws:
  /// - An [Exception] if the platform is not recognized or unsupported.
  ///
  /// Returns:
  /// - A [Future<BaseDeviceInfo>] with detailed information about the device.
  static Future<BaseDeviceInfo> deviceInfo() async {
    switch (currentPlatform) {
      case PlatformType.android:
        return await _deviceInfo.androidInfo;
      case PlatformType.iOS:
        return await _deviceInfo.iosInfo;
      case PlatformType.linux:
        return await _deviceInfo.linuxInfo;
      case PlatformType.macOS:
        return await _deviceInfo.macOsInfo;
      case PlatformType.windows:
        return await _deviceInfo.windowsInfo;
      case PlatformType.web:
        return await _deviceInfo.webBrowserInfo;
      case PlatformType.fuchsia:
        return await _deviceInfo.deviceInfo;
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
  static Future<String?> get getPublicIp => _networkUtils.getPublicIp();

  /// Returns the current private IP List (without loopback) of the device.
  static Future<List<String>> get getPrivateIp => _networkUtils.getPrivateIps();
}
