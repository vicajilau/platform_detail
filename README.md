<p align="center">
  <a href="https://pub.dev/packages/platform_detail">
    <img src="https://raw.githubusercontent.com/vicajilau/platform_detail/main/.github/assets/platform_detail.png" height="200" alt="Platform Detail Logo">
  </a>
  <h1 align="center">Platform Detail</h1>
</p>

<p align="center">
  <a href="https://pub.dev/packages/platform_detail">
    <img src="https://img.shields.io/pub/v/platform_detail?label=pub.dev&labelColor=333940&logo=dart" alt="Pub Version">
  </a>
  <a href="https://github.com/vicajilau/platform_detail/actions/workflows/dart_analyze_unit_test.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/vicajilau/platform_detail/dart_analyze_unit_test.yml?branch=main&label=CI&labelColor=333940&logo=github" alt="CI Status">
  </a>
  <a href="https://github.com/vicajilau/platform_detail/actions/workflows/publish_pub_dev.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/vicajilau/platform_detail/publish_pub_dev.yml?branch=main&label=CD&labelColor=333940&logo=github" alt="CD Status">
  </a>
  <a href="https://codecov.io/gh/vicajilau/pdf_combiner">
    <img src="https://img.shields.io/codecov/c/github/vicajilau/pdf_combiner?logo=codecov&logoColor=fff&labelColor=333940" alt="Code Coverage">
  </a>
</p>

A lightweight Flutter package that provides an easy and optimized way to retrieve details about the platform it’s running on. 
It supports multiple platforms, including mobile, desktop, and web.

## Using

The easiest way to use this library is to call the [PlatformDetail][] class as follows. 
Multiple instances are not being created since thanks to a factory constructor it always 
returns an internal singleton.

### Detecting by type of platform
If you just need to know if it's mobile, desktop, web, or even desktop/web. You will love:

```dart
import 'package:platform_detail/platform_detail.dart';

void main() {
  if (PlatformDetail.isMobile) {
    print('The current platform is Mobile');
  }

  if (PlatformDetail.isDesktopOrWeb) {
    print('The current platform is Desktop or Web');
  }

  if (PlatformDetail.isDesktop) {
    print('The current platform is Desktop');
  }

  if (PlatformDetail.isWeb) {
    print('The current platform is web');
  }
}
```

In addition, you can also use the enum in the [PlatformGroup][] to which it belongs. That is, if it is web, mobile or desktop:

```dart
void main() {
  switch (PlatformDetails.currentGroupPlatform) {
    case PlatformGroup.mobile:
      print('The current group platform is mobile');
      break;
    case PlatformGroup.web:
      print('The current group platform is web');
      break;
    case PlatformGroup.desktop:
      print('The current group platform is desktop');
      break;
  }
}
```

### Detecting by single platform
If instead you want to ask individually for each platform supported by Flutter:

```dart
void main() {
  if (PlatformDetail.isIOS) {
    print('The current platform is iOS');
  }

  if (PlatformDetail.isAndroid) {
    print('The current platform is Android');
  }

  if (PlatformDetail.isFuchsia) {
    print('The current platform is Fuchsia');
  }

  if (PlatformDetail.isWindows) {
    print('The current platform is Windows');
  }

  if (PlatformDetail.isLinux) {
    print('The current platform is Linux');
  }

  if (PlatformDetail.isMacOS) {
    print('The current platform is macOS');
  }
}
```


### Get a device description
If you need more detailed information about the device and operating system it is running on.
```dart
void main() async {
  final descriptionDevice = await PlatformDetail.deviceInfo();
}
```
Or maybe you need an information string about the device info:
```dart
void main() async {
  final descriptionDevice = await PlatformDetail.deviceInfoDetails();
}
```
This will return something like this:
- Android: Android 9 (SDK 28), Xiaomi Redmi Note 7
- iOS: iOS 13.1, iPhone 11 Pro Max iPhone
- Web: Google Chrome (115.0.5790.170)
- Linux: Fedora 17 (Beefy Miracle)
- Windows: Windows 10 Home (1903)
- MacOS: macOS 13.5, MacBook Pro

### Light/Dark Mode
You can detect too if the device is configured in light or dark mode:

```dart
void main() {
  if (PlatformDetail.isLightMode) {
    print('The current platform is configured with light mode');
  }

  if (PlatformDetail.isDarkMode) {
    print('The current platform is configured with dark mode');
  }
}
```

Also, you can use the [DeviceTheme][] enum for this:

```dart
void main() {
  if (PlatformDetail.theme == DeviceTheme.light) {
    print('The current device is configured in light mode');
  }

  if (PlatformDetail.theme == DeviceTheme.dark) {
    print('The current device is configured in dark mode');
  }
}
```

[PlatformDetail]: https://github.com/vicajilau/platform_detail/blob/master/lib/src/platform_detail.dart
[PlatformGroup]: https://github.com/vicajilau/platform_detail/blob/master/lib/src/platform_detail.dart
[DeviceTheme]: https://github.com/vicajilau/platform_detail/blob/master/lib/src/platform_detail.dart