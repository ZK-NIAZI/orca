import 'package:flutter/material.dart';
import 'package:orca/constants/asset_paths.dart';
import 'package:orca/module/profile/widget/interest_display_list.dart';
import 'package:orca/ui/button/primary_button.dart';
import 'package:orca/ui/widget/picture_widget.dart';
import 'package:orca/utils/extensions/extended_context.dart';

import '../../constants/app_colors.dart';
import '../../module/profile/widget/detail_widget.dart';
import '../../module/profile/widget/title_widget.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final String imageUrl;
  final String bio;
  final String gender;
  final String orientation;
  final String interest;
  final String relationship;
  final String age;
  final List<String> interests;

  const CustomBottomSheetWidget({
    Key? key,
    required this.imageUrl,
    required this.bio,
    required this.gender,
    required this.orientation,
    required this.interest,
    required this.relationship,
    required this.age,
    required this.interests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PictureWidget(
                radius: 4,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                onTap: () {},
                errorPath: AssetPaths.imagePlaceHolder,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Bio', style: context.textTheme.headlineMedium),
                    const SizedBox(height: 10),
                    Text(bio, style: context.textTheme.bodyMedium, textAlign: TextAlign.justify),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      onPressed: () {},
                      title: 'Send a compliment',
                      width: 200,
                      height: 40,
                      fontSize: 14,
                    ),
                    const SizedBox(height: 30),
                    Text('About Me', style: context.textTheme.headlineMedium),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleWidgetTwo(title: 'Gender'),
                                TitleWidgetTwo(title: 'Orientation'),
                                TitleWidgetTwo(title: 'Interest'),
                                TitleWidgetTwo(title: 'Relationship'),
                                TitleWidgetTwo(title: 'Age'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailWidget(detail: gender),
                                DetailWidget(detail: orientation),
                                DetailWidget(detail: interest),
                                DetailWidget(detail: relationship),
                                DetailWidget(detail: age),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('My Interests', style: context.textTheme.headlineMedium),
                    const SizedBox(height: 10),
                    InterestDisplayList(interestList: interests),
                    const SizedBox(height: 20),
                    PrimaryButton(onPressed: () {}, title: 'Recommend to a friend'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomSheet {
  static Future<String> profileDetailSheet(
      BuildContext context, {
        required String imageUrl,
        required String bio,
        required String gender,
        required String orientation,
        required String interest,
        required String relationship,
        required String age,
        required List<String> interests,
      }) async {
    return await showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return CustomBottomSheetWidget(
          imageUrl: imageUrl,
          bio: bio,
          gender: gender,
          orientation: orientation,
          interest: interest,
          relationship: relationship,
          age: age,
          interests: interests,
        );
      },
    ) ?? Future.value('nothing');
  }
}

