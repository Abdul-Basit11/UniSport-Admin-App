import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';

import '../../../../utils/const/image_string.dart';
import '../../../../utils/helper/helper_function.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark=BHelperFunction.isDarkMode(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: BHelperFunction.screenWidth() * 0.6,
            child: OutlinedButton(

              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    ImageString.google,
                    width: 30,
                  ),
                  Text('Login with Google',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.bold, color:dark? Colors.white:Colors.black),),
                ],
              ),
            ),
          ),
          10.sH,
          SizedBox(
            height: 50,
            width: BHelperFunction.screenWidth() * 0.6,
            child: OutlinedButton(

              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    ImageString.fb,
                    width: 30,
                  ),
                  Text('Login with Facebook',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.bold,  color:dark? Colors.white:Colors.black),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
