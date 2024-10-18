import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:unisport_admin_app/utils/widgets/custom_loaders.dart';

import '../../../controller/login_controller.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/const/image_string.dart';
import '../../../utils/helper/helper_function.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_screen_title.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../home/dashboard_view/dashboard_screen.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../signup_screen/signup_screen.dart';
import 'widget/socialmedia_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    return Obx(
      () => CustomLoader(
        isLoading: loginController.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              child: Form(
                key: loginController.loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSizes.spaceBtwSection,
                    ),
                    Center(
                      child: Image.asset(
                        ImageString.splashLogo,
                        height: 150,
                      ),
                    ),
                    10.sH,
                    CustomScreenTitle(
                      title: 'Login to your Account .',
                    ),
                    10.sH,
                    Text(
                      'Welcome Back !',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    40.sH,
                    CustomTextField(
                      validator: (va) {
                        if (va.isEmpty) {
                          return 'Email is required';
                        }
                        if (!va.contains('@')) {
                          return 'Email is not in format';
                        }
                      },
                      controller: loginController.email,
                      hintText: 'Email',
                      prefixIcon: Iconsax.direct_right,
                      textInputType: TextInputType.emailAddress,
                      isPrefixIcon: true,
                    ),
                    CustomTextField(
                        validator: (va) {
                          if (va.isEmpty) {
                            return 'Password is empty';
                          }
                          if (va.length < 6) {
                            return 'Strong Password Is required';
                          }
                        },
                        controller: loginController.password,
                        obsecureText: true,
                        hintText: 'Password',
                        prefixIcon: Iconsax.password_check,
                        isPrefixIcon: true,
                        isPasswordField: true),
                    30.sH,
                    CustomButton(
                        title: 'SignIn',
                        onPressed: () {
                          if (loginController.loginKey.currentState!.validate()) {
                            loginController.login();
                          }
                        }),
                    10.sH,
                    Center(
                        child: TextButton(
                            onPressed: () {
                              Get.to(() => ForgotPasswrodScreen());
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.kPrimary),
                            ))),
                    10.sH,
                    Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: 'If you are new ,\t', style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: 'Create Account',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => BHelperFunction.navigate(context, SignUpScreen()),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimary)),
                      ])),
                    ),
                    20.sH,
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        8.sW,
                        const Text(
                          'OR',
                        ),
                        8.sW,
                        const Expanded(child: Divider()),
                      ],
                    ),
                    20.sH,
                    const SocialMediaButton(),
                    40.sH,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
