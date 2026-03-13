import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_detail/platform_detail.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('VersionDetails Tests', () {
    test('versionDetails returns app package metadata', () async {
      Future<PackageInfo> mockProvider() async {
        return PackageInfo(
          appName: 'platform_detail_example',
          packageName: 'com.example.platform_detail_example',
          version: '5.4.0',
          buildNumber: '12',
          buildSignature: 'abc',
          installerStore: 'store',
        );
      }

      PlatformDetail.forTesting(mockPackageInfoProvider: mockProvider);

      final details = await PlatformDetail.versionDetails();

      expect(details.appName, 'platform_detail_example');
      expect(details.packageName, 'com.example.platform_detail_example');
      expect(details.version, '5.4.0');
      expect(details.buildNumber, '12');
    });

    test('versionDetails returns fallback values on error', () async {
      Future<PackageInfo> mockProvider() async {
        throw Exception('package info error');
      }

      PlatformDetail.forTesting(mockPackageInfoProvider: mockProvider);

      final details = await PlatformDetail.versionDetails();

      expect(details.appName, 'unknown');
      expect(details.packageName, 'unknown');
      expect(details.version, 'unknown');
      expect(details.buildNumber, 'unknown');
    });

    test('versionDetails handles field resolution independently', () async {
      var callCount = 0;

      Future<PackageInfo> mockProvider() async {
        callCount++;
        if (callCount == 2) {
          throw Exception('package name read failed');
        }

        return PackageInfo(
          appName: 'platform_detail_example',
          packageName: 'com.example.platform_detail_example',
          version: '5.4.0',
          buildNumber: '12',
          buildSignature: 'abc',
          installerStore: 'store',
        );
      }

      PlatformDetail.forTesting(mockPackageInfoProvider: mockProvider);

      final details = await PlatformDetail.versionDetails();

      expect(details.appName, 'platform_detail_example');
      expect(details.packageName, 'unknown');
      expect(details.version, '5.4.0');
      expect(details.buildNumber, '12');
    });
  });
}
