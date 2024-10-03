import 'package:flutter/material.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/module/profile/widget/interest_display_list.dart';
import 'package:orca/ui/widget/picture_widget.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import '../../../ui/widget/custom_bottom_sheet.dart';

class UserTileWidget extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String about;
  final String orientation;
  final String gender;
  final String seeingInterest;
  final String relationship;
  final String age;
  final List<String> interests;
  final double height;
  final double borderRadius;
  final VoidCallback? onUserTap;

  const UserTileWidget(
      {super.key,
      this.onUserTap,
      required this.imageUrl,
      required this.name,
      required this.about,
      required this.interests,
      this.height = double.infinity,
      this.borderRadius = 0,
       required this.orientation,
       required this.gender,
       required this.seeingInterest,
       required this.relationship,
       required this.age});

  @override
  State<UserTileWidget> createState() => _UserTileWidgetState();
}

class _UserTileWidgetState extends State<UserTileWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onUserTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widget.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: AppColors.grey),
        child: Stack(
          children: [
            PictureWidget(
                radius: 12,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                imageUrl: widget.imageUrl,
                onTap: () {},
                errorPath: ''),
            Positioned(
              bottom: 50,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: context.textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 32),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.about,
                    style: context.textTheme.headlineSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InterestDisplayList(
                      borderRadius: 15, interestList: widget.interests),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Positioned(
                right: 20,
                top: 20,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.primaryColor.withOpacity(0.6),
                  ),
                  child: IconButton(
                      onPressed: () {
                        CustomBottomSheet.profileDetailSheet(context,
                            imageUrl: widget.imageUrl,
                            bio: widget.about,
                            gender: '${widget.gender}',
                            orientation: '${widget.orientation}',
                            interest: '${widget.seeingInterest}',
                            relationship: '${widget.relationship}',
                            age: '${widget.age}',
                            interests: widget.interests);
                      },
                      icon: const Icon(
                        Icons.arrow_upward_outlined,
                        size: 25,
                        color: AppColors.white,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
