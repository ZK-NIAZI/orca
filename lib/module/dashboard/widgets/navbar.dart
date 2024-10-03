import 'package:flutter/material.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:svg_flutter/svg.dart';
import '../models/bottom_nav_model.dart';


class Navbar extends StatelessWidget {
  final List<BottomNavModel> tabs;
  final Function(int) onChanged;

  const Navbar({super.key, required this.tabs, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(

        height: 45,
        decoration: BoxDecoration(color: AppColors.primaryColor,),
        padding: const EdgeInsets.symmetric(horizontal: 12),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              tabs.length,
              (index) => IconButton(
                  onPressed: () => onChanged(index),
                  icon: Container(
                    height: 35,
                    width: 35,
                    decoration: tabs[index].isSelected
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.white,
                            )
                        : const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          tabs[index].icon,
                          height: 20,
                          color: tabs[index].isSelected
                              ? AppColors.primaryColor
                              : Colors.black,
                        ),
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }
}
