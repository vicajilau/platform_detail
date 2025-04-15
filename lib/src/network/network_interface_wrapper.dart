import 'dart:io';

import 'custom_network_interface.dart';

/// An abstraction that allows listing network interfaces in a testable way.
///
/// Implementations can return real or mocked data, which makes
/// it useful for writing unit tests.
abstract class NetworkInterfaceWrapper {
  /// Returns a list of custom network interfaces.
  ///
  /// - [includeLoopback]: whether to include loopback interfaces.
  /// - [type]: the type of address to filter (e.g., IPv4 or IPv6).
  Future<List<CustomNetworkInterface>> list({
    bool includeLoopback = false,
    InternetAddressType type = InternetAddressType.any,
  });
}
