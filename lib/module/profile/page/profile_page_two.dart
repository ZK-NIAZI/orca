import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/config/routes/nav_router.dart';
import 'package:orca/module/profile/cubit/profile_cubit/profile_cubit.dart';
import 'package:orca/module/profile/page/profile_page_three.dart';
import 'package:orca/ui/widget/gender_list_widget.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/button/primary_button.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';

class ProfilePageTwo extends StatelessWidget {
  const ProfilePageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileCubit(),
        child: const ProfilePageTwoView());
  }
}


class ProfilePageTwoView extends StatefulWidget {


  const ProfilePageTwoView({super.key,});

  @override
  State<ProfilePageTwoView> createState() => _ProfilePageTwoViewState();
}


class _ProfilePageTwoViewState extends State<ProfilePageTwoView> {
  List<String> genderList = ['Male', 'Female', 'Others'];
  String selectedGenders = '';

  final userRepo =
  UserAccountRepository(storageService: sl(), sessionRepository: sl());
  String currentPage = '2';
  
  
  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("What's Your gender?",
                style: context.textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 25)),
            const SizedBox(
              height: 25,
            ),
            GenderListWidget(
                genderList: genderList,
                onSelectedGender: (value) {
                  setState(() {
                    selectedGenders = value;
                  });
                },
                selectedGender: selectedGenders),

            const SizedBox(
              height: 100,
            ),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {

                if (state.profileStatus == ProfileStatus.success && currentPage=='2') {
                  print(currentPage);
                  NavRouter.pushReplacement(context, const ProfilePageThree());
                }
              },
              builder: (context, state) {
                return PrimaryButton(
                    onPressed: () {
                      if (selectedGenders != '') {
                       context.read<ProfileCubit>().setSingleValue(user.id!, 'gender', selectedGenders);
                        context
                            .read<ProfileCubit>()
                            .setProfileStatus(user.id!, '2');
                      }
                      else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                            SnackBar(content: Text('Gender not selected')));
                      }
                    },
                    title: 'Next');
              },
            )
          ],
        ),
      ),
    );
  }
}
