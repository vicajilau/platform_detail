import 'package:flutter_test/flutter_test.dart';
import 'package:platform_detail/platform_detail.dart';

Future main() async {

  test('Current Platform', () {
    expect(PlatformDetail.currentPlatform, PlatformDetail.currentPlatform);
  });

}
