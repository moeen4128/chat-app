import 'package:flutter/cupertino.dart';

import '../core/utils/app_mode.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> startTimer(BuildContext context) async {
    if (isTestMode) return;
    await Future.delayed(Duration(seconds: 5));
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}