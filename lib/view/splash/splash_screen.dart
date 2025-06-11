import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwa_chat_app/core/constants/image_strings.dart';
import '../../view_model/splash_view_model.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override

  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Image(
              image: AssetImage(ImageString.logo)),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<SplashViewModel>(context,listen: false).startTimer(context);
    });
  }
}
