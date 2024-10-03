import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/profile/cubit/profile_cubit/profile_cubit.dart';
import 'package:orca/module/profile/page/profile_page_four.dart';
import 'package:orca/utils/extensions/extended_context.dart';

import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/button/primary_button.dart';
import '../../../ui/widget/gender_list_widget.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';

class ProfilePageThree extends StatefulWidget {

  const ProfilePageThree({super.key,});

  @override
  State<ProfilePageThree> createState() => _ProfilePageThreeState();
}

class _ProfilePageThreeState extends State<ProfilePageThree> {
  List<String> orientationList = [
    'Straight',
    'Gay',
    'Lesbian',
    'Bisexual',
    'Asexual',
    'Demisexual'
  ];
  String selectedOrientation = '';
  final userRepo =
  UserAccountRepository(storageService: sl(), sessionRepository: sl());
  String currentPage = '3';

  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Sexual orientation?",
                    style: context.textTheme.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 25)),
                GenderListWidget(
                    genderList: orientationList,
                    onSelectedGender: (value) {
                      setState(() {
                        selectedOrientation = value;
                      });
                    },
                    selectedGender: selectedOrientation),
                const SizedBox(
                  height: 25,
                ),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state.profileStatus == ProfileStatus.success &&
                        currentPage == '3') {
                      NavRouter.pushReplacement(
                          context,
                          const ProfilePageFour(
                          ));
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                        onPressed: () {
                          if (selectedOrientation != '') {
                            context.read<ProfileCubit>().setSingleValue(user
                                .id!, 'orientation', selectedOrientation);
                            context
                                .read<ProfileCubit>()
                                .setProfileStatus(user.id!, '3');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Orientation not selected')));
                          }
                        },
                        title: 'Next');
                  },
                )
              ],
            )),
      ),
    );
  }
}
