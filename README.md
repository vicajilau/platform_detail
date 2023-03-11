A library for getting platform details.

[![pub package](https://img.shields.io/pub/v/http.svg)](https://pub.dev/packages/platform_detail)

This lightweight package allows in a very simple and optimized way to obtain details about the platform on which it is running. It's multi-platform, and supports mobile, desktop,
and the browser.

## Using

The easiest way to use this library is to call the [PlatformDetail][] class as follows. 
Multiple instances are not being created since thanks to a factory constructor it always 
returns an internal singleton:

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

In addition, you can also find out which [PlatformGroup][] it belongs to. That is, if it is web, mobile or desktop:

```dart
if (PlatformDetail.type == PlatfromGroup.mobile) {
  print('The current group platform is mobile');
}

if (PlatformDetail.type == PlatfromGroup.web) {
print('The current group platform is web');
}

if (PlatformDetail.type == PlatfromGroup.desktop) {
print('The current group platform is desktop');
}

```

[PlatformDetail]: https://github.com/vicajilau/platform_detail/blob/master/lib/src/platform_detail.dart
[PlatformGroup]: https://github.com/vicajilau/platform_detail/blob/master/lib/src/platform_detail.dart
