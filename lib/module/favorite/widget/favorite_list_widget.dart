import 'package:flutter/material.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/constants/asset_paths.dart';
import 'package:orca/module/profile/widget/interest_display_list.dart';
import 'package:orca/module/profile/widget/title_widget.dart';
import 'package:orca/ui/widget/picture_widget.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import 'package:svg_flutter/svg.dart';

class FavoriteListWidget extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final List<String> interests;
  final VoidCallback onCardTap;

  const FavoriteListWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.email,
      required this.interests, required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.grey,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      child: InkWell(
        onTap: onCardTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(AssetPaths.icFavoriteFill),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PictureWidget(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  imageUrl: image,
                  onTap: () {},
                  errorPath: '',
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,

                          maxLines: 1, style: context.textTheme.headlineLarge),
                      const SizedBox(height: 5),
                      Text(
                        email,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const TitleWidget(title: 'Interests'),
            InterestDisplayList(interestList: interests),



          ],
        ),
      ),
    );
  }
}
