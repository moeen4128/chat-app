import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pwa_chat_app/core/utils/app_mode.dart';
import 'package:pwa_chat_app/main.dart';
import 'package:provider/provider.dart';
import 'package:pwa_chat_app/view_model/splash_view_model.dart';
import 'package:pwa_chat_app/view_model/auth_view_model.dart';

void main() {
  testWidgets('Splash screen shows logo image', (WidgetTester tester) async {
    isTestMode = true;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SplashViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('splashLogo')), findsOneWidget);
  });
}