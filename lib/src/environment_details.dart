import 'platform_type.dart';

/// Typed wrapper for lightweight runtime environment details.
class EnvironmentDetails {
  const EnvironmentDetails({
    required this.platformType,
    required this.platform,
    required this.deviceModel,
    required this.locale,
  });

  final PlatformType platformType;
  final String platform;
  final String deviceModel;
  final String locale;
}
