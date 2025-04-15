import 'dart:io';

/// A custom representation of an IP address.
///
/// This class mimics [InternetAddress] but is fully mockable,
/// making it suitable for unit testing.
class CustomInternetAddress {
  /// The IP address as a string (e.g., "192.168.1.1").
  final String address;

  /// Whether the address is a loopback address (e.g., "127.0.0.1").
  final bool isLoopback;

  /// Creates a custom IP address instance.
  CustomInternetAddress(this.address, this.isLoopback);
}
