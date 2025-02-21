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

    setUp(() {
      mockDeviceInfo = MockDeviceInfoPlugin();
      mockPlatformDispatcher = MockPlatformDispatcher();
      PlatformDetail.forTesting(mockDeviceInfo, mockPlatformDispatcher);
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

    test('deviceInfo returns expected format for web', () async {
      if (PlatformDetail.isWeb) {
        final webInfo = WebBrowserInfo(
          userAgent: "Chrome",
          appVersion: '115.0.5790.170',
          appCodeName: 'Mozilla',
          appName: 'Netscape',
          deviceMemory: 8,
          language: 'en-US',
          languages: ['en-US'],
          platform: 'Win32',
          product: 'Gecko',
          productSub: '20030107',
          vendor: 'GoogleInc.',
          vendorSub: '',
          maxTouchPoints: 0,
          hardwareConcurrency: 4,
        );

        when(() => mockDeviceInfo.webBrowserInfo)
            .thenAnswer((_) async => webInfo);

        final result = await PlatformDetail.deviceInfoDetails();
        expect(result, contains('Google Chrome (115.0.5790.170)'));
      }
    });

    // Agrega pruebas similares para Android, iOS, Linux, macOS y Windows
  });
}
