import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/profile/model/about_model.dart';
import 'package:orca/module/profile/page/upload_image.dart';
import 'package:orca/ui/input/input_field.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import 'package:orca/utils/validators/validators.dart';

import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/button/primary_button.dart';
import '../../../ui/widget/loading_widget.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';
import '../cubit/profile_cubit/profile_cubit.dart';
import '../model/profile_model.dart';

class ProfilePageSix extends StatefulWidget {


  const ProfilePageSix({super.key,});

  @override
  State<ProfilePageSix> createState() => _ProfilePageSixState();
}

class _ProfilePageSixState extends State<ProfilePageSix> {


  final userRepo =
  UserAccountRepository(storageService: sl(), sessionRepository: sl());

  final _aboutController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String currentPage = '6';

  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tell us about Yourself",
                      style: context.textTheme.headlineLarge!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 25)),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    validator: (value) => Validators.required(value),
                    controller: _aboutController,
                    label: 'About You',
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Relationship Status?",
                      style: context.textTheme.headlineLarge!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 25)),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                      validator: (value) => Validators.required(value),
                      controller: _relationshipController,
                      label: 'Relationship'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Age in Years?",
                      style: context.textTheme.headlineLarge!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 25)),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                      validator: (value) => Validators.required(value),
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      label: 'Age'),
                  const SizedBox(
                    height: 25,
                  ),

                  BlocConsumer<ProfileCubit, ProfileState>(
                    listener: (context, state) async {
                      if (state.profileStatus == ProfileStatus.success &&
                          currentPage == '6') {
                        await NavRouter.push(context, UploadImage());
                      }
                    },
                    builder: (context, state) {
                      return PrimaryButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final userProfile = AboutModel(
                                  about: _aboutController.text,
                                  relationship: _relationshipController.text,
                                  age: _ageController.text);
                              context
                                  .read<ProfileCubit>()
                                  .addAboutProfile(user.id!, userProfile);
                              context
                                  .read<ProfileCubit>()
                                  .setProfileStatus(user.id!, '6');
                            }
                            //NavRouter.push(context, UploadImage());
                          },
                          title: 'Submit');
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
