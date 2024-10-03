import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/profile/cubit/profile_cubit/profile_cubit.dart';
import 'package:orca/module/profile/page/profile_page_two.dart';
import 'package:orca/ui/button/primary_button.dart';
import 'package:orca/ui/input/input_field.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import 'package:orca/utils/validators/validators.dart';

import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';
class ProfilePageOne extends StatelessWidget {
  const ProfilePageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileCubit(),
        child: const ProfilePageOneView());
  }
}

class ProfilePageOneView extends StatefulWidget {
  const ProfilePageOneView({super.key});

  @override
  State<ProfilePageOneView> createState() => _ProfilePageOneViewState();
}

class _ProfilePageOneViewState extends State<ProfilePageOneView> {
  final userRepo =
      UserAccountRepository(storageService: sl(), sessionRepository: sl());

  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String currentPage = '1';

  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("What's Your first name?",
                  style: context.textTheme.headlineLarge!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 25)),
              const SizedBox(
                height: 25,
              ),
              InputField(
                  validator: (value) => Validators.required(value),
                  controller: _nameController,
                  label: 'Name'),
              const SizedBox(
                height: 5,
              ),
              const Text("This is how it'll appear on your profile."),
              const SizedBox(
                height: 200,
              ),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state.profileStatus == ProfileStatus.success &&
                      currentPage == '1') {
                    print(currentPage);
                    NavRouter.pushReplacement(context, const ProfilePageTwo());
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ProfileCubit>().setSingleValue(
                              user.id!, 'name', _nameController.text);
                          context
                              .read<ProfileCubit>()
                              .setProfileStatus(user.id!, '1');
                        }
                      },
                      title: 'Next');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
