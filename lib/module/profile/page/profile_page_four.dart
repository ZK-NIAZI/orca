import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/profile/cubit/profile_cubit/profile_cubit.dart';
import 'package:orca/module/profile/page/profile_page_five.dart';
import 'package:orca/utils/extensions/extended_context.dart';

import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/button/primary_button.dart';
import '../../../ui/widget/gender_list_widget.dart';
import '../../../ui/widget/loading_widget.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';
import '../model/profile_model.dart';

class ProfilePageFour extends StatefulWidget {


  const ProfilePageFour({super.key});

  @override
  State<ProfilePageFour> createState() => _ProfilePageFourState();
}

class _ProfilePageFourState extends State<ProfilePageFour> {
  List<String> seeingInterestList = ['Men', 'Women', 'EveryOne'];
  String selectedSeeingInterest = '';

  final userRepo =
  UserAccountRepository(storageService: sl(), sessionRepository: sl());
  String currentPage = '4';

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
              children: [
                Text("Who are You interested in seeing?",
                    style: context.textTheme.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 25)),
                GenderListWidget(
                    genderList: seeingInterestList,
                    onSelectedGender: (value) {
                      setState(() {
                        selectedSeeingInterest = value;
                      });
                    },
                    selectedGender: selectedSeeingInterest),
                const SizedBox(
                  height: 25,
                ),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state.profileStatus == ProfileStatus.success &&
                        currentPage == '4') {
                      NavRouter.pushReplacement(context, ProfilePageFive());
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                        onPressed: () {
                          if (selectedSeeingInterest != '') {
                            context.read<ProfileCubit>().setSingleValue(user
                                .id!, 'seeingInterest', selectedSeeingInterest);
                            context
                                .read<ProfileCubit>()
                                .setProfileStatus(user.id!, '4');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Seeing Interest not selected')));
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
