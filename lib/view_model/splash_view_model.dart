import 'package:flutter/cupertino.dart';

class SplashViewModel extends ChangeNotifier{
  Future<void> startTimer(BuildContext context) async{
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, '/login');
  }
}