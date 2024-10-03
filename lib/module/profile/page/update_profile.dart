import 'package:flutter/material.dart';
import 'package:orca/config/routes/nav_router.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/module/profile/widget/update_input_widget.dart';
import 'package:orca/ui/button/primary_button.dart';
import 'package:orca/utils/extensions/extended_context.dart';

class UpdateProfile extends StatefulWidget {
  final String name;
  final String about;
  final String gender;
  final String orientation;
  final String seeingInterest;
  final String relationship;
  final String age;

  const UpdateProfile(
      {super.key,
      required this.name,
      required this.about,
      required this.gender,
      required this.orientation,
      required this.seeingInterest,
      required this.relationship,
      required this.age});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

final _nameController = TextEditingController();
final _genderController = TextEditingController();
final _orientationController = TextEditingController();
final _seeingInterestController = TextEditingController();
final _relationshipController = TextEditingController();
final _ageController = TextEditingController();
final _aboutController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: context.textTheme.headlineMedium,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UpdateInputWidget(controller: _nameController, label: widget.name, title: 'Name',),
              UpdateInputWidget(controller: _genderController, label: widget.gender, title: 'Gender',),
              UpdateInputWidget(controller: _orientationController, label: widget.orientation, title: 'Orientation',),
              UpdateInputWidget(controller: _seeingInterestController, label: widget.seeingInterest, title: 'Seeing Interest',),
              UpdateInputWidget(controller: _relationshipController, label: widget.relationship, title: 'RelationShip',),
              UpdateInputWidget(controller: _ageController, label: widget.age, title: 'Age',),
              UpdateInputWidget(controller: _aboutController, label: widget.about, title: 'About',maxLines: 6,),
              PrimaryButton(onPressed: () {NavRouter.pop(context);}, title: 'Update')
            ],
          ),
        ),
      ),
    );
  }
}
