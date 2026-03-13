// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform_detail/platform_detail.dart';
import 'package:platform_detail/src/network/network_utils.dart';

import 'package:example/main.dart';

class FakeNetworkUtils extends NetworkUtils {
  @override
  Future<List<String>> getPrivateIps({
    InternetAddressType version = InternetAddressType.IPv4,
  }) async =>
      <String>[];

  @override
  Future<String?> getPublicIp() async => null;
}

void main() {
  testWidgets('Example app renders platform detail screen',
      (WidgetTester tester) async {
    PlatformDetail.forTesting(mockNetworkUtils: FakeNetworkUtils());

    await tester.pumpWidget(const MyApp());

    expect(find.textContaining('Flutter Demo Home Page'), findsOneWidget);

    // Let FutureBuilders progress and accept either loading or resolved states.
    await tester.pump();
    await tester.pump();

    final hasLoadingState =
        find.byType(CircularProgressIndicator).evaluate().isNotEmpty;

    final hasDeviceInfoState = hasLoadingState ||
        find.textContaining('Device Info:').evaluate().isNotEmpty ||
        find
            .textContaining('Error getting device info:')
            .evaluate()
            .isNotEmpty ||
        find.text('No data available').evaluate().isNotEmpty;

    final hasPrivateIpState = hasLoadingState ||
        find.textContaining('Private IP:').evaluate().isNotEmpty ||
        find
            .textContaining('Error getting private IP:')
            .evaluate()
            .isNotEmpty ||
        find.text('No private IP available').evaluate().isNotEmpty ||
        find.text('Private IP: Unavailable').evaluate().isNotEmpty;

    final hasPublicIpState = hasLoadingState ||
        find.textContaining('Public IP:').evaluate().isNotEmpty ||
        find.textContaining('Error getting public IP:').evaluate().isNotEmpty ||
        find.text('No public IP available').evaluate().isNotEmpty;

    expect(hasDeviceInfoState, isTrue);
    expect(hasPrivateIpState, isTrue);
    expect(hasPublicIpState, isTrue);
  });
}
