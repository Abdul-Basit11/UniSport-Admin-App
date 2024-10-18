import 'package:flutter/cupertino.dart';

class AppSizes {
  /// padding margin
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  /// Icon sizes
  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconLg = 32;

  /// Font Size
  static const double fontSm = 14;
  static const double fontMd = 16;
  static const double fontLg = 18;

  /// Button Size
  static const double buttonHeight = 18;
  static const double buttonRadius = 12;
  static const double buttonWidth = 120;
  static const double buttonElevation = 4;

  /// AppBar Height
  static const double appBarHeight = 56;

  /// Image Size
  static const double imageThumbSize = 80;

  /// Default spacing between sections
  static const double defaultSpace = 22;
  static const double spaceBtwItem = 16;
  static const double spaceBtwSection = 32;

  /// Border Radius
  static const double borderRadiusSm = 4;
  static const double borderRadiusMd = 8;
  static const double borderRadiusLg = 12;

  /// Divider Height
  static const double dividerHeight = 1;

  /// Product Item Dimension
  static const double productImageSize = 120;
  static const double productImageRadius = 16;
  static const double productItemHeight = 160;

  /// Input Field
  static const double inputFieldRadius = 12;
  static const double spaceBtwinputField = 16;

  /// Card Sizes
  static const double cardRadiusLg = 16;
  static const double cardRadiusMd = 12;
  static const double cardRadiusSm = 10;
  static const double cardRadiusXs = 6;
  static const double cardElevation = 6;

  /// Image Carousel height
  static const double imageCarouselHeight = 200;

  /// Loading Indicator Size
  static const double loadingIndicatorSize = 36;

  /// GridView spacing
  static const double gridViewSpacing = 16;
}
extension Space on num {
  SizedBox get sH => SizedBox(
    height: toDouble(),
  );
  SizedBox get sW => SizedBox(
    width: toDouble(),
  );
}
