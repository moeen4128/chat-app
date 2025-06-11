import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwa_chat_app/view/auth/login_page.dart';
import 'package:pwa_chat_app/view/auth/signup_page.dart';
import 'package:pwa_chat_app/view/home.dart';
import 'package:pwa_chat_app/view/splash/splash_screen.dart';
import 'package:pwa_chat_app/view_model/auth_view_model.dart';
import 'package:pwa_chat_app/view_model/splash_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.setSettings(
    appVerificationDisabledForTesting: true,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SplashViewModel(),),
      ChangeNotifierProvider(create: (context) => AuthViewModel(),)
    ],child: const MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      routes: {
        '/splash':(context)=>const SplashScreen(),
        '/home':(context)=>const HomePage(),
        '/login':(context)=> LoginPage(),
        '/signup':(context)=>const SignupPage(),
      },
    );
  }
}

