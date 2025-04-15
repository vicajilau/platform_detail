import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_detail/src/network/custom_internet_address.dart';
import 'package:platform_detail/src/network/custom_network_interface.dart';
import 'package:platform_detail/src/network/default_network_interface_wrapper.dart';
import 'package:platform_detail/src/network/dio_http_client.dart';
import 'package:platform_detail/src/network/network_interface_wrapper.dart';
import 'package:platform_detail/src/network/network_utils.dart';
import 'package:platform_detail/src/platform_detail.dart';

class MockDio extends Mock implements Dio {}

class MockWrapper extends Mock implements NetworkInterfaceWrapper {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DefaultNetworkInterfaceWrapper', () {

    late MockDio mockDio;
    late DioClient dioClient;
    late NetworkInterfaceWrapper wrapper;

    setUpAll(() {
      mockDio = MockDio();
      dioClient = DioClient(dio: mockDio);
      wrapper = DefaultNetworkInterfaceWrapper();

      PlatformDetail.forTesting(
        mockNetworkUtils: NetworkUtils(dioClient: dioClient),
      );
    });

    test('returns a non-empty list of network interfaces (may vary by system)', () async {
      final interfaces = await wrapper.list();

      // This test assumes the system has at least one non-loopback network interface.
      expect(interfaces, isA<List<CustomNetworkInterface>>());

      // Optionally assert there's at least one interface with at least one address.
      final hasAtLeastOneIp = interfaces.any((iface) => iface.addresses.isNotEmpty);
      expect(hasAtLeastOneIp, isTrue);
    });

    test('can filter by address type: IPv4', () async {
      final interfaces = await wrapper.list(type: InternetAddressType.IPv4);

      for (final iface in interfaces) {
        for (final addr in iface.addresses) {
          expect(InternetAddress.tryParse(addr.address)?.type, equals(InternetAddressType.IPv4));
        }
      }
    });

    test('can include loopback addresses', () async {
      final interfaces = await wrapper.list(includeLoopback: true);

      final hasLoopback = interfaces.any(
            (iface) => iface.addresses.any((addr) => addr.isLoopback),
      );

      expect(hasLoopback, isTrue);
    });

    test('getPublicIp successfully returns the IP address', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: '123.456.789',
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await PlatformDetail.getPublicIp;

      expect(result, '123.456.789');
    });
  });

  test('Return private IP addresses (no loopback)', () async {
    final mockWrapper = MockWrapper();
    final utils = NetworkUtils(interfaceWrapper: mockWrapper);

    when(() => mockWrapper.list(
          includeLoopback: false,
          type: InternetAddressType.IPv4,
        )).thenAnswer((_) async => [
          CustomNetworkInterface([
            CustomInternetAddress('192.168.1.2', false),
            CustomInternetAddress('127.0.0.1', true),
          ])
        ]);

    final result = await utils.getPrivateIps();

    expect(result, ['192.168.1.2']);
  });
}
