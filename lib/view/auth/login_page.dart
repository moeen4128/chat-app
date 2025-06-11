
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/image_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_text_styles.dart';
import '../../view_model/auth_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/text_button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authVM.isLoginTabSelected
                ? Image(
              width: double.infinity,
              fit: BoxFit.cover,
              image: AssetImage(ImageString.loginPwa),
            )
                : Image(
              width: double.infinity,
              fit: BoxFit.cover,
              image: AssetImage(ImageString.loginVerificationPwa),
            ),
            SizedBox(height: AppSizes.spaceXL),
            Padding(
              padding: EdgeInsets.only(
                  left: AppSizes.paddingDefault,
                  right: AppSizes.paddingDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.loginOnYourAccount,
                    style: AppTextStyles.headline1,
                  ),
                  SizedBox(height: AppSizes.spaceL),
                  Consumer<AuthViewModel>(
                    builder: (context, authVM, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => authVM.switchTab(true),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            authVM.isLoginTabSelected
                                                ? ImageString.selectedIconLogin
                                                : ImageString.iconLogin,
                                            height: AppSizes.height,
                                            width: AppSizes.width,
                                          ),
                                          SizedBox(width: AppSizes.spaceS),
                                          Text(AppString.login,
                                              style: AppTextStyles.label),
                                        ],
                                      ),
                                      SizedBox(height: AppSizes.spaceXS),
                                      Container(
                                        height: AppSizes.underline,
                                        width: double.infinity,
                                        color: authVM.isLoginTabSelected
                                            ? AppColors.primaryMain
                                            : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => authVM.switchTab(false),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            !authVM.isLoginTabSelected
                                                ? ImageString
                                                .selectedIconVerification
                                                : ImageString.iconVerification,
                                            height: AppSizes.height,
                                            width: AppSizes.width,
                                          ),
                                          SizedBox(width: AppSizes.spaceS),
                                          Text(AppString.verification,
                                              style: AppTextStyles.label),
                                        ],
                                      ),
                                      SizedBox(height: AppSizes.spaceXS),
                                      Container(
                                        height: AppSizes.underline,
                                        width: double.infinity,
                                        color: !authVM.isLoginTabSelected
                                            ? AppColors.primaryMain
                                            : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSizes.spaceXL),
                          /// Body part
                          authVM.isLoginTabSelected
                              ? Column(
                            children: [
                              CustomTextFormField(
                                controller: phoneController,
                                prefixIcon: Icons.phone,
                                hintText: AppString.loginHintText,
                                labelText: AppString.loginLabelText,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(
                                height: AppSizes.spaceXXL,
                              ),
                              CustomButtonIcon(
                                onPressed: () {
                                  if (phoneController.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please enter phone number')),
                                    );
                                    return;
                                  }

                                  authVM.verifyPhoneNumber(
                                    '+${phoneController.text}', // Add country code
                                    onCodeSent: (verificationId) {
                                      authVM.switchTab(false);
                                    },
                                    onVerificationFailed: (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(error)),
                                      );
                                    },
                                    onVerificationCompleted:
                                        (credential) async {
                                          final navigator = Navigator.of(context);
                                          final messenger = ScaffoldMessenger.of(context);
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithCredential(
                                            credential);
                                        navigator.pushReplacementNamed('/home');
                                      } catch (e) {
                                        messenger.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Error: ${e.toString()}')),
                                        );
                                      }
                                    },
                                    onCodeAutoRetrievalTimeout:
                                        (verificationId) {
                                      // Handle timeout if needed
                                    },
                                  );
                                },
                                iconPath:
                                ImageString.iconPlayerTrackNext,
                                text: AppString.nextStep,
                              ),
                              SizedBox(
                                height: AppSizes.spaceXXL,
                              ),
                              TextWithAction(
                                text: AppString.dontHaveAccount,
                                actionText: AppString.signIn,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                textStyle: AppTextStyles.buttonText,
                                actionTextStyle: AppTextStyles.testButton,
                              )
                            ],
                          )
                              : Column(
                            children: [
                              CustomTextFormField(
                                controller: smsCodeController,
                                hintText: AppString.verificationHintText,
                                labelText: AppString.verificationLabelText,
                                prefixIcon: Icons.phone,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(
                                height: AppSizes.spaceXXL,
                              ),
                              CustomButtonIcon(
                                onPressed: () {
                                  if (smsCodeController.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content:
                                          Text('Please enter OTP')),
                                    );
                                    return;
                                  }

                                  authVM.signInWithPhoneNumber(
                                    smsCodeController.text,
                                    onSuccess: (user) {
                                      // Navigate to home screen
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    },
                                    onError: (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(error)),
                                      );
                                    },
                                  );
                                },
                                iconPath: ImageString.iconLoginButton,
                                text: AppString.loginButton,
                              ),
                              SizedBox(
                                height: AppSizes.spaceXXL,
                              ),
                              TextWithAction(
                                text: AppString.didNotReceiveCode,
                                actionText: AppString.tryAgain,
                                onPressed: () {
                                  if (authVM.phoneNumber != null) {
                                    authVM.verifyPhoneNumber(
                                      authVM.phoneNumber!,
                                      onCodeSent: (verificationId) {},
                                      onVerificationFailed: (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                      },
                                      onVerificationCompleted:
                                          (credential) async {
                                            final navigator = Navigator.of(context);
                                            final messenger = ScaffoldMessenger.of(context);
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithCredential(
                                              credential);
                                          navigator.pushReplacementNamed('/home');
                                        } catch (e) {
                                          messenger.showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Error: ${e.toString()}')),
                                          );
                                        }
                                      },
                                      onCodeAutoRetrievalTimeout:
                                          (verificationId) {
                                            // TODO: Handle timeout if necessary
                                      },
                                    );
                                  }
                                },
                                textStyle: AppTextStyles.buttonText,
                                actionTextStyle: AppTextStyles.testButton,
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}