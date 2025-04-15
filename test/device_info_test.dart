import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_detail/platform_detail.dart';

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockPlatformDispatcher extends Mock implements PlatformDispatcher {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DeviceInfo Tests', () {
    late MockDeviceInfoPlugin mockDeviceInfo;
    late MockPlatformDispatcher mockPlatformDispatcher;

    setUpAll(() {
      mockDeviceInfo = MockDeviceInfoPlugin();
      mockPlatformDispatcher = MockPlatformDispatcher();
      PlatformDetail.forTesting(
          mockDeviceInfo: mockDeviceInfo,
          mockPlatformDispatcher: mockPlatformDispatcher);
    });

    test('deviceInfo returns expected format for web', () async {
      PlatformDetail.forTesting(mockedWeb: true);
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

      PlatformDetail.forTesting(
          mockedWeb: true, mockDeviceInfo: mockDeviceInfo);
      final infoDetailString = await PlatformDetail.deviceInfoDetails();
      final infoDetail = await PlatformDetail.deviceInfo();

      PlatformDetail.forTesting(mockedWeb: false);
      expect(infoDetailString, 'chrome (115.0.5790.170)');
      expect(infoDetail, webInfo);
    });

    test('deviceInfo returns expected format for macOS', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      final mockMap = {
        'computerName': 'MyMac',
        'hostName': 'mymac.local',
        'arch': 'x86_64',
        'model': 'MacBookPro18,3',
        'modelName': 'MacBook Pro',
        'kernelVersion': 'Darwin 23.2.0',
        'osRelease': '23.2.0',
        'majorVersion': 14,
        'minorVersion': 2,
        'patchVersion': 0,
        'activeCPUs': 8,
        'memorySize': 17179869184,
        'cpuFrequency': 2400000000,
        'systemGUID': 'ABC123-XYZ789'
      };
      final info = MacOsDeviceInfo.fromMap(mockMap);

      when(() => mockDeviceInfo.macOsInfo).thenAnswer((_) async => info);

      PlatformDetail.forTesting(mockDeviceInfo: mockDeviceInfo);
      final infoDetailString = await PlatformDetail.deviceInfoDetails();
      final infoDetail = await PlatformDetail.deviceInfo();
      expect(infoDetailString, 'macOS 23.2.0, MacBookPro18,3');
      expect(infoDetail, info);
    });

    test('deviceInfo returns expected format for windows', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      final info = WindowsDeviceInfo(
        computerName: 'MY-PC',
        numberOfCores: 8,
        systemMemoryInMegabytes: 16384,
        userName: 'TestUser',
        majorVersion: 10,
        minorVersion: 0,
        buildNumber: 22621,
        platformId: 2,
        csdVersion: '',
        servicePackMajor: 0,
        servicePackMinor: 0,
        suitMask: 0,
        productType: 1,
        reserved: 0,
        buildLab: '22621.vb_release.191206-1406',
        buildLabEx: '22621.1.amd64fre.ni_release.210506-1631',
        digitalProductId: Uint8List.fromList([1, 2, 3, 4]),
        displayVersion: '22H2',
        editionId: 'Professional',
        installDate: DateTime(2020, 1, 1),
        productId: '00330-80000-00000-AA123',
        productName: 'Windows 11 Pro',
        registeredOwner: 'John Doe',
        releaseId: '2009',
        deviceId: 'ABCDEF123456',
      );

      when(() => mockDeviceInfo.windowsInfo).thenAnswer((_) async => info);

      PlatformDetail.forTesting(mockDeviceInfo: mockDeviceInfo);
      final infoDetailString = await PlatformDetail.deviceInfoDetails();
      final infoDetail = await PlatformDetail.deviceInfo();
      expect(infoDetailString, 'Windows 11 Pro(2009)');
      expect(infoDetail, info);
    });
  });
}
