import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../const/colors.dart';

class CustomLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  CustomLoader({Key? key, required this.isLoading, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      color: AppColors.kPrimary,
      opacity: 0.1,
      progressIndicator: SpinKitWaveSpinner(
        trackColor: AppColors.kSecondary,
        waveColor: AppColors.kPrimary,
        color: AppColors.kPrimary,
        duration: Duration(seconds: 3),
        size: 50,
      ),
      child: child,
    );
  }
}
