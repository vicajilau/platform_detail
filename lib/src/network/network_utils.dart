import 'dart:io';

import 'package:platform_detail/platform_detail.dart';
import 'package:platform_detail/src/network/dio_http_client.dart';

/// A Network util to get IP addresses.
class NetworkUtils {
  /// Returns a list of private IP addresses for the selected version (default: IPv4)
  static Future<List<String>> getPrivateIps({
    InternetAddressType version = InternetAddressType.IPv4,
  }) async {
    if (PlatformDetail.isWeb) {
      return [];
    }
    final interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: version,
    );

    final result = <String>[];

    for (final interface in interfaces) {
      for (final address in interface.addresses) {
        if (!address.isLoopback) {
          result.add(address.address);
        }
      }
    }

    return result;
  }

  /// Returns the current public IP of the device (v4 or v6).
  static Future<String?> getPublicIp() async {
    try {
      final response =
          await DioClient().getDio().get('https://api64.ipify.org');

      if (response.statusCode == 200) {
        return response.data.toString();
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
