import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_detail/platform_detail.dart';

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockPlatformDispatcher extends Mock implements PlatformDispatcher {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('PlatformDetail Tests', () {
    late MockDeviceInfoPlugin mockDeviceInfo;
    late MockPlatformDispatcher mockPlatformDispatcher;

    setUpAll(() {
      mockDeviceInfo = MockDeviceInfoPlugin();
      mockPlatformDispatcher = MockPlatformDispatcher();
      PlatformDetail.forTesting(
          mockDeviceInfo: mockDeviceInfo,
          mockPlatformDispatcher: mockPlatformDispatcher);
    });

    test('isWeb returns true when kIsWeb is true', () {
      expect(PlatformDetail.isWeb, equals(kIsWeb));
    });

    test('isDesktop returns true for macOS, linux, and windows', () {
      for (var platform in TargetPlatform.values) {
        debugDefaultTargetPlatformOverride = platform;

        if (platform == TargetPlatform.macOS ||
            platform == TargetPlatform.linux ||
            platform == TargetPlatform.windows) {
          expect(PlatformDetail.isDesktop, isTrue);
        } else {
          expect(PlatformDetail.isDesktop, isFalse);
        }
      }
    });

    test('isMobile returns true for iOS, Android, and Fuchsia', () {
      for (var platform in TargetPlatform.values) {
        debugDefaultTargetPlatformOverride = platform;

        if (platform == TargetPlatform.iOS ||
            platform == TargetPlatform.android ||
            platform == TargetPlatform.fuchsia) {
          expect(PlatformDetail.isMobile, isTrue);
        } else {
          expect(PlatformDetail.isMobile, isFalse);
        }
      }
    });

    test('theme returns correct DeviceTheme based on brightness', () {
      when(() => mockPlatformDispatcher.platformBrightness)
          .thenReturn(Brightness.dark);

      expect(PlatformDetail.theme, equals(DeviceTheme.dark));

      when(() => mockPlatformDispatcher.platformBrightness)
          .thenReturn(Brightness.light);

      expect(PlatformDetail.theme, equals(DeviceTheme.light));
    });

    test('isLightMode returns true when brightness is dark', () {
      when(() => mockPlatformDispatcher.platformBrightness)
          .thenReturn(Brightness.light);
      expect(PlatformDetail.theme, equals(DeviceTheme.light));
    });

    test('isDarkMode returns true when brightness is dark', () {
      when(() => mockPlatformDispatcher.platformBrightness)
          .thenReturn(Brightness.dark);
      expect(PlatformDetail.isDarkMode, isTrue);
    });

    test('isLightMode returns true when brightness is light', () {
      when(() => mockPlatformDispatcher.platformBrightness)
          .thenReturn(Brightness.light);
      expect(PlatformDetail.isLightMode, isTrue);
    });

    test('currentPlatform returns the correct platform', () {
      for (var platform in TargetPlatform.values) {
        debugDefaultTargetPlatformOverride = platform;
        expect(PlatformDetail.currentPlatform.name, equals(platform.name));
      }
    });

    test('currentGroupPlatform returns correct PlatformGroup', () {
      for (var platform in TargetPlatform.values) {
        debugDefaultTargetPlatformOverride = platform;

        if (PlatformDetail.isWeb) {
          expect(
              PlatformDetail.currentGroupPlatform, equals(PlatformGroup.web));
        } else if (PlatformDetail.isDesktop) {
          expect(PlatformDetail.currentGroupPlatform,
              equals(PlatformGroup.desktop));
        } else if (PlatformDetail.isMobile) {
          expect(PlatformDetail.currentGroupPlatform,
              equals(PlatformGroup.mobile));
        }
      }
    });

    test('isWindows returns true only when platform is Windows', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      expect(PlatformDetail.isWindows, isTrue);

      for (var platform in TargetPlatform.values) {
        if (platform != TargetPlatform.windows) {
          debugDefaultTargetPlatformOverride = platform;
          expect(PlatformDetail.isWindows, isFalse);
        }
      }
    });

    test('isMacOS returns true only when platform is macOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(PlatformDetail.isMacOS, isTrue);

      for (var platform in TargetPlatform.values) {
        if (platform != TargetPlatform.macOS) {
          debugDefaultTargetPlatformOverride = platform;
          expect(PlatformDetail.isMacOS, isFalse);
        }
      }
    });

    test('isLinux returns true only when platform is Linux', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      expect(PlatformDetail.isLinux, isTrue);

      for (var platform in TargetPlatform.values) {
        if (platform != TargetPlatform.linux) {
          debugDefaultTargetPlatformOverride = platform;
          expect(PlatformDetail.isLinux, isFalse);
        }
      }
    });

    test('isAndroid returns true only when platform is Android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      expect(PlatformDetail.isAndroid, isTrue);

      for (var platform in TargetPlatform.values) {
        if (platform != TargetPlatform.android) {
          debugDefaultTargetPlatformOverride = platform;
          expect(PlatformDetail.isAndroid, isFalse);
        }
      }
    });

    test('isIOS returns true only when platform is iOS', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      expect(PlatformDetail.isIOS, isTrue);

      for (var platform in TargetPlatform.values) {
        if (platform != TargetPlatform.iOS) {
          debugDefaultTargetPlatformOverride = platform;
          expect(PlatformDetail.isIOS, isFalse);
        }
      }
    });

    test('isFuchsia returns true only when platform is Fuchsia', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
      expect(PlatformDetail.isFuchsia, isTrue);

      for (var platform in TargetPlatform.values) {
        if (platform != TargetPlatform.fuchsia) {
          debugDefaultTargetPlatformOverride = platform;
          expect(PlatformDetail.isFuchsia, isFalse);
        }
      }
    });

    test('type returns correct PlatformGroup', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(PlatformDetail.type, PlatformGroup.desktop);
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      expect(PlatformDetail.type, PlatformGroup.mobile);
      PlatformDetail.forTesting(mockedWeb: true);
      expect(PlatformDetail.type, PlatformGroup.web);
      PlatformDetail.forTesting(mockedWeb: false);
    });

    test('isDesktopOrWeb returns true when platform is desktop or web', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(PlatformDetail.isDesktopOrWeb, isTrue);
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      expect(PlatformDetail.isDesktopOrWeb, isTrue);
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      expect(PlatformDetail.isDesktopOrWeb, isTrue);
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      PlatformDetail.forTesting(mockedWeb: true);
      expect(PlatformDetail.isDesktopOrWeb, isTrue);
      PlatformDetail.forTesting(mockedWeb: false);
    });

    test('isDesktopOrWeb returns false when platform is mobile', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      expect(PlatformDetail.isDesktopOrWeb, isFalse);
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      expect(PlatformDetail.isDesktopOrWeb, isFalse);
    });
  });
}
