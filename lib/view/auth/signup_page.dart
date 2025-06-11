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
import '../widgets/image_picker.dart';
import '../widgets/text_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none, // Allows overflow
              children: [
                authVM.isLoginTabSelected
                    ? Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage(ImageString.login_pwa),
                )
                    : Image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage(ImageString.login_verification_pwa),
                ),
                Positioned(
                  bottom: -60, // Adjust this value for desired overlap
                  child: authVM.isLoginTabSelected ? ProfileImagePicker() : SizedBox.shrink(),
                )
              ],
            ),
            authVM.isLoginTabSelected ? SizedBox(
              height: AppSizes.spaceXXL,
            ):SizedBox(
              height: AppSizes.spaceL,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: AppSizes.paddingDefault,
                right: AppSizes.paddingDefault,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: !authVM.isLoginTabSelected,
                    child: Text(
                      AppString.SignIn_for_account,
                      style: AppTextStyles.headline1,
                    ),
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
                                                ? ImageString
                                                    .selected_icon_login
                                                : ImageString.icon_login,
                                            height: AppSizes.height,
                                            width: AppSizes.width,
                                          ),
                                          SizedBox(width: AppSizes.spaceS),
                                          Text(
                                            AppString.login,
                                            style: AppTextStyles.label,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: AppSizes.spaceXS),
                                      Container(
                                        height: AppSizes.underline,
                                        width: double.infinity,
                                        color:
                                            authVM.isLoginTabSelected
                                                ? AppColors.primary_main
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
                                                    .selected_icon_verification
                                                : ImageString.icon_verification,
                                            height: AppSizes.height,
                                            width: AppSizes.width,
                                          ),
                                          SizedBox(width: AppSizes.spaceS),
                                          Text(
                                            AppString.verification,
                                            style: AppTextStyles.label,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: AppSizes.spaceXS),
                                      Container(
                                        height: AppSizes.underline,
                                        width: double.infinity,
                                        color:
                                            !authVM.isLoginTabSelected
                                                ? AppColors.primary_main
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
                                    hintText: AppString.signup_hintText,
                                    labelText: AppString.signup_labelText,
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(height: AppSizes.spaceSM),
                                  CustomTextFormField(
                                    prefixIcon: Icons.phone,
                                    hintText: AppString.login_hintText,
                                    labelText: AppString.login_labelText,
                                    keyboardType: TextInputType.number,
                                  ),

                                  authVM.isLoginTabSelected ?  SizedBox(height: AppSizes.spaceL):SizedBox(height: AppSizes.spaceXXL),
                                  CustomButtonIcon(
                                    onPressed: () {},
                                    iconPath:
                                        ImageString.icon_player_track_next,
                                    text: AppString.nextStep,
                                  ),
                                  SizedBox(height: AppSizes.spaceXXL),
                                  TextWithAction(
                                    text: AppString.You_have_account,
                                    actionText: AppString.Login,
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    textStyle: AppTextStyles.buttonText,
                                    actionTextStyle: AppTextStyles.testButton,
                                  ),
                                  SizedBox(
                                    height: AppSizes.spaceXL,
                                  )
                                ],
                              )
                              : Column(
                                children: [
                                  CustomTextFormField(
                                    hintText: AppString.verificatio_hintText,
                                    labelText: AppString.verificatio_labelText,
                                    prefixIcon: Icons.phone,
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(height: AppSizes.spaceXXL),
                                  CustomButtonIcon(
                                    onPressed: () {},
                                    iconPath: ImageString.icon_login_button,
                                    text: AppString.loginButton,
                                  ),
                                  SizedBox(height: AppSizes.spaceXXL),
                                  TextWithAction(
                                    text: AppString.Did_not_recive_code,
                                    actionText: AppString.TryAgain,
                                    onPressed: () {
                                      // handle navigation or logic here
                                    },
                                    textStyle: AppTextStyles.buttonText,
                                    actionTextStyle: AppTextStyles.testButton,
                                  ),
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
