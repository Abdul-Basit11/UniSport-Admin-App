import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controller/login_controller.dart';
import '../../../utils/const/image_string.dart';
import '../../../utils/const/sizes.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_screen_title.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../login_screen/login_screen.dart';

class ForgotPasswrodScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
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
                title: 'Forgot Password .',
              ),
              10.sH,
              Text(
                'Please enter your address to request a password reuest .',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              40.sH,
              CustomTextField(
                controller: email,
                hintText: 'Email',
                prefixIcon: Iconsax.direct_right,
                textInputType: TextInputType.emailAddress,
                isPrefixIcon: true,
              ),
              30.sH,
              CustomButton(
                  title: 'Send Email',
                  onPressed: () {
                    loginController.sendEmailResetPassword(
                      email.text.toString(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
