import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:platform_detail/src/network/dio_http_client.dart';
import 'package:platform_detail/src/network/network_utils.dart';
import 'package:platform_detail/src/platform_detail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PlatformDetail Tests', () {
    late MockDio mockDio;
    late DioClient dioClient;

    setUpAll(() {
      mockDio = MockDio();
      dioClient = DioClient(dio: mockDio);

      PlatformDetail.forTesting(
        mockNetworkUtils: NetworkUtils(dioClient: dioClient),
      );
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
}
