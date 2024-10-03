import 'package:flutter/material.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/utils/extensions/extended_context.dart';

import '../../../ui/widget/on_click.dart';

class TextRoundedContainerWidget extends StatelessWidget {
  final String title;
  final double borderRadius;
  final double hPadding;
  final double vPadding;
  final bool isSelected;
  final VoidCallback onTap;
  final double? width;
  const TextRoundedContainerWidget(
      {super.key,
      required this.title,
      this.borderRadius = 6,
      this.hPadding = 7,
      this.vPadding = 5,
        this.width,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OnClick(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: isSelected
              ? AppColors.primaryColor
              : const Color(0xffE5E5E5),
        ),
        child: Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
              color: isSelected ? Colors.white : const Color(0xff626262)),
        ),
      ),
    );
  }
}
