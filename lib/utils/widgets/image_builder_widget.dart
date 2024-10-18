import 'package:flutter/material.dart';


import '../const/colors.dart';

class ImageBuilderWidget extends StatelessWidget {
  final double? height, width;
  final String? image;
  final double? imageRadius;
  final Color? progressIndicatorColor;

  const ImageBuilderWidget(
      {super.key, this.height = 150, this.width = 150, this.image, this.imageRadius, this.progressIndicatorColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kLightGrey, boxShadow: [
        BoxShadow(
          color: AppColors.kblack.withOpacity(0.4),
          blurRadius: 2,
          spreadRadius: 2,
          offset: const Offset(0, 2),
        ),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageRadius ?? 10),
        child: Image(
          filterQuality: FilterQuality.medium,
          height: height,
          width: width,
          fit: BoxFit.cover,
          image: NetworkImage(image ??
                  "https://www.pngkey.com/png/full/950-9501315_katie-notopoulos-katienotopoulos-i-write-about-tech-user.png"

              //'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',

              ),
          errorBuilder: (context, exceptoin, stack) {
            debugPrint(exceptoin.toString());
            return SizedBox(
              height: height,
              width: width,
              child: const Center(
                child: Icon(
                  Icons.error,
                  color: AppColors.kPrimary,
                ),
              ),
            );
          },
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loading) {
            if (loading == null) return child;

            return SizedBox(
              height: height,
              width: width,
              child: Center(
                child: CircularProgressIndicator(
                  value: loading.expectedTotalBytes != null
                      ? loading.cumulativeBytesLoaded / loading.expectedTotalBytes!
                      : null,
                  color: progressIndicatorColor ?? Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
