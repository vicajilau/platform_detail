## 5.1.0
* Added mocked capabilities with `PlatformDetail.forTesting()`.
* Added `getPublicIp` and `getPrivateIp` methods. [@carloscgm](https://github.com/carloscgm).
* Reorganized files hiding internal classes.
* Increased coverage on tests with mocked capabilities.

## 5.0.0
* **BREAKING CHANGE**: `currentPlatform` no longer returns a `TargetPlatform`. It now returns a new custom enum: `PlatformType`, which includes `web` support.

## 4.2.0
* Maximized Dart SDK versions support (>=2.15).
* Fixed: The platform on which the website was running was detected by checking the web operating system.
* Improved documentation.
* Added coverage.

## 4.1.0
* Example project created.
* Fixed linting issue.
* Added `deviceInfo()` method.
* Some minor improvements.

## 4.0.0
* **BREAKING CHANGE:** `deviceInfo()` has been renamed by `deviceInfoDetails()`.
* Updated dependencies.
* Documentation improved.
* Added Testing.
* Code refactoring.
* Updated Readme.

## 3.3.1
* Updated dependencies.

## 3.3.0
* Added if the mobile's device is a simulator.
* Updated dependencies.

## 3.2.1
* Renamed `productName` by `deviceInfo()`.
* Updated documentation.

## 3.2.0
* Added `productName`.
* Updated documentation.
* Upgraded documentation.

## 3.1.0

* Renamed `type` by `currentGroupPlatform`
* Added currentPlatform to get an enumeration indicating the current operating system on which it is running.
* Upgraded documentation.
* Updated dependencies.

## 3.0.1

* Renamed PlatformDetails by PlatformDetail

## 3.0.0

* Added `isDarkMode` property to detect the kind of theme is dark.
* Added `isLightMode` property to detect the kind of theme is light.
* Added `DeviceTheme` enum.
* Added theme property to detector the kind of theme (light - dark).
* Upgraded dependencies.

## 2.2.0

* Updated to Dart 3.

## 2.1.2

* Fix an issue when type parameter was accessed.

## 2.1.1

* Fix some minor issues.
* Improved readme.

## 2.1.0

* Added `PlatformGroup` enum.
* Added a static property to get the PlatformGroup into PlatformDetail class.
* Added PlatformGroup into Readme.

## 2.0.1

* Some minor improvement.
* Readme improved.

## 2.0.0

* Factory constructor removed, now everything are static variables.

## 1.1.0

* isWeb bug fixed.
* isDesktopOrWeb optimized.

## 1.0.0

* Access to the PlatformDetail class is done singleton by a factory constructor.
* Added `isDesktop` read property.
* Added `isMobile` read property.
* Added `isWeb` read property.
* Added `isDesktopOrWeb` read property.
* Added `isIOS` read property.
* Added `isAndroid` read property.
* Added `isFuchsia` read property.
* Added `isWindows` read property.
* Added `isLinux` read property.
* Added `isMacOS` read property.
