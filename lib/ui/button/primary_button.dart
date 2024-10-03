import 'package:flutter/material.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import 'package:svg_flutter/svg_flutter.dart';
import '../../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.hMargin = 0,
      this.vMargin = 10,
      this.height = 50,
      this.width = double.infinity,
      this.backgroundColor = AppColors.primaryColor,
      this.titleColor = Colors.white,
      this.fontWeight = FontWeight.w500,
      this.fontSize = 16,
      this.fontWidget,
      this.borderRadius = 39,
      this.shadow = false})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double hMargin;
  final double vMargin;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? titleColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final double? fontSize;
  final Widget? fontWidget;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            if (shadow)
              BoxShadow(
                color: Colors.black.withOpacity(.25),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              )
          ]),
      margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backgroundColor,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: fontWeight,
                  color: titleColor ?? Colors.white,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryOutlineButton extends StatelessWidget {
  const PrimaryOutlineButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.hMargin = 0,
      this.height = 50,
      this.width = double.infinity,
      this.backgroundColor,
      this.titleColor = AppColors.white,
      this.borderColor = Colors.grey,
      this.fontWeight = FontWeight.w600,
      this.fontSize,
      this.fontWidget,
      this.borderRadius = 8})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double hMargin;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? titleColor;
  final double borderRadius;
  final Color borderColor;
  final FontWeight fontWeight;
  final double? fontSize;
  final Widget? fontWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: hMargin),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                color: borderColor,
              )),
          backgroundColor: backgroundColor ?? context.colorScheme.surface,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: fontWeight,
                  color: titleColor,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrefixIconButton extends StatelessWidget {
  const PrefixIconButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.height = 50,
      this.backgroundColor = AppColors.primaryColor,
      this.titleColor = AppColors.white,
      this.fontSize = 16,
      this.prefixIconPath,
      this.hPadding = 12,
      this.borderColor,
      this.prefixIconSize = 25,
      this.borderRadius = 30,
      this.foregroundColor,
      this.width,
      this.fontWeight = FontWeight.w600,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.titleGap = 14});

  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final FontWeight fontWeight;
  final double height;
  final double? width;
  final Color backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final String? prefixIconPath;
  final double prefixIconSize;
  final double hPadding;
  final Color titleColor;
  final MainAxisAlignment mainAxisAlignment;
  final Color? borderColor;
  final double titleGap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                  color: borderColor != null
                      ? borderColor!
                      : context.colorScheme.outline,
                  width: .5)),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              height: prefixIconSize,
              prefixIconPath!,
            ),
            SizedBox(
              width: titleGap,
            ),
            Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  color: titleColor),
            )
          ],
        ),
      ),
    );
  }
}

class SuffixIconButton extends StatelessWidget {
  const SuffixIconButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height = 55,
    this.backgroundColor = const Color(0xff14151C),
    this.titleColor = Colors.white,
    this.borderColor = const Color(0xff20222B),
    this.foregroundColor,
    this.fontSize = 16,
    this.suffixIconSize = 12,
    this.hPadding = 12,
    this.suffixIconPath,
    this.borderRadius = 39,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.titleGap = 200,
    this.topPadding = 24,
  });

  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final double height;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color borderColor;
  final Color titleColor;
  final double borderRadius;
  final double suffixIconSize;
  final double hPadding;
  final String? suffixIconPath;
  final MainAxisAlignment mainAxisAlignment;
  final double titleGap;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: hPadding),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(color: borderColor, width: 1)),
            ),
            child: ListTile(
              leading: Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize,
                    color: titleColor),
              ),
              trailing: SvgPicture.asset(
                height: suffixIconSize,
                suffixIconPath!,
              ),
            )),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    this.height = 50,
    this.backgroundColor = AppColors.white,
    this.borderColor = Colors.transparent,
    this.foregroundColor,
    this.iconSize = 25,
    this.hPadding = 12,
    required this.iconPath,
    this.borderRadius = 39,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  final VoidCallback onPressed;
  final double height;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderRadius;
  final double iconSize;
  final double hPadding;
  final String? iconPath;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                  color: borderColor != null
                      ? borderColor!
                      : context.colorScheme.outline,
                  width: .5)),
        ),
        child: SvgPicture.asset(
          height: iconSize,
          iconPath!,
        ),
      ),
    );
  }
}
