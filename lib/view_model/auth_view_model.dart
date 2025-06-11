// import 'package:flutter/material.dart';
//
// class AuthViewModel extends ChangeNotifier {
//   bool _isLoginTabSelected = true;
//
//   bool get isLoginTabSelected => _isLoginTabSelected;
//
//   void switchTab(bool isLogin) {
//     _isLoginTabSelected = isLogin;
//     notifyListeners();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoginTabSelected = true;
  bool _isLoading = false;
  String? _verificationId;
  String? _phoneNumber;

  bool get isLoginTabSelected => _isLoginTabSelected;
  bool get isLoading => _isLoading;
  String? get verificationId => _verificationId;
  String? get phoneNumber => _phoneNumber;

  void switchTab(bool isLogin) {
    _isLoginTabSelected = isLogin;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, {
        required Function(String) onCodeSent,
        required Function(String) onVerificationFailed,
        required Function(PhoneAuthCredential) onVerificationCompleted,
        required Function(String) onCodeAutoRetrievalTimeout,
      }) async {
    _isLoading = true;
    _phoneNumber = phoneNumber;
    notifyListeners();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: (FirebaseAuthException e) {
        _isLoading = false;
        notifyListeners();
        onVerificationFailed(e.message ?? 'Verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        _isLoading = false;
        notifyListeners();
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  Future<void> signInWithPhoneNumber(
      String smsCode, {
        required Function(User) onSuccess,
        required Function(String) onError,
      }) async {
    if (_verificationId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      _isLoading = false;
      notifyListeners();
      onSuccess(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      onError(e.message ?? 'Sign in failed');
    }
  }
}