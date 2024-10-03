import 'package:flutter/material.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/utils/extensions/extended_context.dart';

import '../../../ui/widget/on_click.dart';

class SelectableTextWidget extends StatelessWidget {
  final String title;
  final double borderRadius;
  final double hPadding;
  final double vPadding;
  final bool isSelected;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color initialColor;
  final Color borderColor;

  const SelectableTextWidget(
      {super.key,
        required this.title,
        this.borderRadius = 6,
        this.hPadding = 7,
        this.vPadding = 5,
        this.width,
        this.height,
        this.fontSize,
        this.initialColor=AppColors.bgGrey,
        this.borderColor=AppColors.bgGrey,
        required this.isSelected,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OnClick(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
          color: isSelected ? AppColors.primaryColor : initialColor,
        ),
        child: Center(
          child: Text(
            title,
            style: context.textTheme.bodySmall?.copyWith(
                color: isSelected ? Colors.white : Colors.black,fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
