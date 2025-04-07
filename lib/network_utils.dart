import 'dart:io';

class NetworkUtils {
  /// Returns a list of private IP addresses for the selected version (default: IPv4)
  static Future<List<String>> getPrivateIps({InternetAddressType version = InternetAddressType.IPv4}) async {
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
}
