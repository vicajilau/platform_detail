import 'dart:io';

import 'custom_internet_address.dart';
import 'custom_network_interface.dart';
import 'network_interface_wrapper.dart';

/// The default implementation of [NetworkInterfaceWrapper] using the real system interfaces.
///
/// Converts [NetworkInterface] and [InternetAddress] from the Dart SDK
/// into test-friendly [CustomNetworkInterface] and [CustomInternetAddress] objects.
class DefaultNetworkInterfaceWrapper implements NetworkInterfaceWrapper {
  @override
  Future<List<CustomNetworkInterface>> list({
    bool includeLoopback = false,
    InternetAddressType type = InternetAddressType.any,
  }) async {
    // Retrieve the real network interfaces from the system.
    final realInterfaces = await NetworkInterface.list(
      includeLoopback: includeLoopback,
      type: type,
    );

    // Convert them to mockable custom classes.
    return realInterfaces
        .map((i) => CustomNetworkInterface(
              i.addresses
                  .map((a) => CustomInternetAddress(a.address, a.isLoopback))
                  .toList(),
            ))
        .toList();
  }
}
