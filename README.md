A library for getting platform details.

[![pub package](https://img.shields.io/pub/v/http.svg)](https://pub.dev/packages/platform_detail)
![CI Status](https://img.shields.io/github/workflow/status/vicajilau/platform_detail/flutter_workflow)

This lightweight package allows in a very simple and optimized way to obtain details about the platform on which it is running. It's multi-platform, and supports mobile, desktop,
and the browser.

## Using

The easiest way to use this library is to call the [PlatformDetail][] class as follows. 
Multiple instances are not being created since thanks to a factory constructor it always 
returns an internal singleton.

### Detecting by type of platform
If you just need to know if it's mobile, desktop, web, or even desktop/web. You will love:

```dart
import 'package:platform_detail/platform_detail.dart';

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
```

In addition, you can also use the enum in the [PlatformGroup][] to which it belongs. That is, if it is web, mobile or desktop:

```dart
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
```

### Detecting by single platform
If instead you want to ask individually for each platform supported by Flutter:

```dart
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
```


### Get a device description
If you need more detailed information about the device and operating system it is running on. In web you will get information from the browser:
```dart
final descriptionDevice = await PlatformDetail.deviceInfoDetails();
```

### Light/Dark Mode
You can detect too if the device is configured in light or dark mode:

```dart
if (PlatformDetail.isLightMode) {
  print('The current platform is configured with light mode');
}

if (PlatformDetail.isDarkMode) {
print('The current platform is configured with dark mode');
}
```

Also, you can use the [DeviceTheme][] enum for this:

```dart
if (PlatformDetail.theme == DeviceTheme.light) {
  print('The current device is configured in light mode');
}

if (PlatformDetail.theme == DeviceTheme.dark) {
print('The current device is configured in dark mode');
}
```

[PlatformDetail]: https://github.com/vicajilau/platform_detail/blob/master/lib/src/platform_detail.dart
[PlatformGroup]: https://github.com/vicajilau/platform_detail/blob/master/lib/src/platform_detail.dart
[DeviceTheme]: https://github.com/vicajilau/platform_detail/blob/master/lib/src/platform_detail.dart