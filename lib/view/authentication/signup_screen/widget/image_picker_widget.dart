import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/const/colors.dart';
import '../../../../utils/const/sizes.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    this.cameraTapped,
    this.galleryTapped,
  });

  final VoidCallback? cameraTapped;
  final VoidCallback? galleryTapped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        color: AppColors.kSecondary,
        margin: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Stack(
          children: [

            Padding(
              padding: const EdgeInsets.all(AppSizes.md),
              child: Column(
                children: [
                  const SizedBox(
                    width: 30,
                    child: Divider(
                      height: 6,
                      thickness: 4,
                      color: AppColors.kGrey,
                    ),
                  ),
                  20.sH,
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: cameraTapped,
                          child: const SizedBox(
                            height: 90,
                            child: Card(
                              child: Icon(Iconsax.camera),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: galleryTapped,
                          child: const SizedBox(
                            height: 90,
                            child: Card(
                              child: Icon(Iconsax.gallery),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
