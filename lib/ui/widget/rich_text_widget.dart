import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/asset_paths.dart';

class RichTextWidget extends StatelessWidget {
  final double width;
  final String firstText;
  final String secondText;
  final Color firstTextColor;
  final Color secondTextColor;
  final Color firstBgColor;
  final Color secondBgColor;
  final double fontSize;
  final VoidCallback? onPressed;

  RichTextWidget({
    super.key,
    this.width = double.infinity,
    required this.firstText,
    required this.secondText,
    this.firstTextColor = AppColors.black,
    this.secondTextColor = AppColors.black,
    this.firstBgColor = Colors.transparent,
    this.secondBgColor = Colors.transparent,
    this.fontSize = 15,

    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: firstText,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: firstTextColor,
              fontFamily: AssetPaths.avenir,
              fontSize: fontSize,
              backgroundColor: firstBgColor),
          children: [
            TextSpan(
              text: secondText,
              recognizer: TapGestureRecognizer()..onTap = onPressed,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: secondTextColor,
                decoration: TextDecoration.underline,
                fontSize: fontSize,
                fontFamily: AssetPaths.avenir,
                backgroundColor: secondBgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
