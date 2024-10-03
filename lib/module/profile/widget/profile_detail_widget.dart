import 'package:flutter/material.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/utils/extensions/extended_context.dart';

import '../../../../constants/asset_paths.dart';
import '../../../ui/widget/picture_widget.dart';

class ProfileDetailWidget extends StatefulWidget {
  final String profilePic;
  final String userName;
  final String email;
  final VoidCallback? onEditTap;
  const ProfileDetailWidget(
      {super.key,
      required this.profilePic,
      required this.userName,
      required this.email,
      this.onEditTap});

  @override
  State<ProfileDetailWidget> createState() => _ProfileDetailWidgetState();
}

class _ProfileDetailWidgetState extends State<ProfileDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 54, bottom: 36),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: AppColors.grey,borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          PictureWidget(
              height: 60,
              width: 60,
              imageUrl:widget.profilePic,
              onTap: () {},
              errorPath: AssetPaths.imagePlaceHolder),
          const SizedBox(
            width: 24,
          ),
          SizedBox(
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userName, style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 7,),
                Text(
                  widget.email,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
