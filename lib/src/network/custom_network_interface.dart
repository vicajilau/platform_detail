import 'custom_internet_address.dart';

/// A custom representation of a network interface.
///
/// It contains a list of [CustomInternetAddress] instances.
/// Used instead of [NetworkInterface] to simplify testing.
class CustomNetworkInterface {
  /// The list of IP addresses associated with the interface.
  final List<CustomInternetAddress> addresses;

  /// Creates a custom network interface instance.
  CustomNetworkInterface(this.addresses);
}
