import 'dart:io';

import 'package:platform_detail/platform_detail.dart';
import 'package:platform_detail/src/network/dio_http_client.dart';

import 'default_network_interface_wrapper.dart';
import 'network_interface_wrapper.dart';

/// A Network util to get IP addresses.
class NetworkUtils {
  final DioClient _dioClient;
  final NetworkInterfaceWrapper _interfaceWrapper;

  NetworkUtils({
    DioClient? dioClient,
    NetworkInterfaceWrapper? interfaceWrapper,
  })  : _dioClient = dioClient ?? DioClient(),
        _interfaceWrapper =
            interfaceWrapper ?? DefaultNetworkInterfaceWrapper();

  /// Returns a list of private IP addresses for the selected version (default: IPv4)
  Future<List<String>> getPrivateIps({
    InternetAddressType version = InternetAddressType.IPv4,
  }) async {
    if (PlatformDetail.isWeb) {
      return [];
    }

    final interfaces = await _interfaceWrapper.list(
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
  Future<String?> getPublicIp() async {
    try {
      final response = await _dioClient.getDio().get('https://api64.ipify.org');

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
