import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orca/config/routes/nav_router.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/module/authentication/repository/user_account_repository.dart';
import 'package:orca/module/profile/cubit/profile_data_cubit/profile_data_cubit.dart';
import 'package:orca/module/profile/page/profile_page_one.dart';
import 'package:orca/module/profile/page/update_profile.dart';
import 'package:orca/module/profile/widget/interest_display_list.dart';
import 'package:orca/module/profile/widget/title_widget.dart';
import 'package:orca/module/startup/welcome_page.dart';
import 'package:orca/ui/button/primary_button.dart';
import 'package:orca/ui/widget/loading_widget.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import '../../../core/di/service_locator.dart';
import '../../authentication/model/sign_up_model.dart';
import '../widget/detail_widget.dart';
import '../widget/profile_detail_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final userRepo =
    UserAccountRepository(storageService: sl(), sessionRepository: sl());

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return BlocProvider(
      create: (context) => ProfileDataCubit(FirebaseDatabase.instance.ref()),
      child: ProfilePageView(
        userId: '${user.id}',
      ),
    );
  }
}

class ProfilePageView extends StatefulWidget {
  final String userId;

  const ProfilePageView({super.key, required this.userId});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  UserAccountRepository userAccountRepository = sl<UserAccountRepository>();

  @override
  void initState() {
    super.initState();
    context.read<ProfileDataCubit>().fetchProfile(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: context.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                LoadingDialog.show(context);
                try {
                  await FirebaseAuth.instance.signOut().then((value) async {
                    await userAccountRepository.logout();
                    LoadingDialog.hide(context);
                    NavRouter.push(context, WelcomePage());
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to logOut')));
                  LoadingDialog.hide(context);
                }
              },
              icon: const Icon(Icons.login_outlined))
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<ProfileDataCubit, ProfileDataState>(
            builder: (context, state) {
              if (state.profileDataStatus == ProfileDataStatus.succes) {
                final profile = state.profile;
                print(state.profileDataStatus);
                return Column(
                  children: [
                    ProfileDetailWidget(
                        profilePic: '${profile?.imageUrl}',
                        userName: '${profile?.name}',
                        email: '${profile?.about}',
                        onEditTap: () {}),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleWidget(title: 'Gender'),
                                  TitleWidget(title: 'Orientation'),
                                  TitleWidget(title: 'SeeingInterest'),
                                  TitleWidget(title: 'Relationship'),
                                  TitleWidget(title: 'Age'),
                                ],
                              )),
                          Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailWidget(
                                    detail: '${profile?.gender}',
                                  ),
                                  DetailWidget(
                                    detail: '${profile?.orientation}',
                                  ),
                                  DetailWidget(
                                    detail: '${profile?.seeingInterest}',
                                  ),
                                  DetailWidget(
                                    detail: '${profile?.relationship}',
                                  ),
                                  DetailWidget(
                                    detail: '${profile?.age}',
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleWidget(title: "My Interests"),
                          InterestDisplayList(
                            interestList: profile!.intersets,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        NavRouter.pushAndRemoveUntilFirstWithAnimation(
                            context,
                            UpdateProfile(
                              name: profile.name,
                              about: profile.about,
                              gender: profile.gender,
                              orientation: profile.orientation,
                              seeingInterest: profile.seeingInterest,
                              relationship: profile.relationship,
                              age: profile.age,
                            ));
                      },
                      title: 'Update Profile',
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                );
              }

              if (state.profileDataStatus == ProfileDataStatus.loading) {
                print(state.profileDataStatus);

                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            size: 80, color: AppColors.primaryColor)));
              }
              //return Center(child: Text('${state.message}'),);

              print(state.profileDataStatus);
              return Column(
                children: [
                  ProfileDetailWidget(
                      profilePic:
                          'https://img.freepik.com/free-photo/portrait-young-man-with-green-hoodie_23-2148514952.jpg?w=996&t=st=1726472866~exp=1726473466~hmac=a3d4be875149e40895892aa0b503766d78c3e452a2081876b1d45e07a2004a4f',
                      userName: 'Name',
                      email: 'abc@gmail.com',
                      onEditTap: () {}),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleWidget(title: 'Religion'),
                                TitleWidget(title: 'Profession'),
                                TitleWidget(title: 'Country'),
                                TitleWidget(title: 'Relationship'),
                                TitleWidget(title: 'Age'),
                                TitleWidget(title: 'Interest'),
                              ],
                            )),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailWidget(
                                  detail: '',
                                ),
                                DetailWidget(
                                  detail: '',
                                ),
                                DetailWidget(
                                  detail: '',
                                ),
                                DetailWidget(
                                  detail: '',
                                ),
                                DetailWidget(
                                  detail: '',
                                ),
                                DetailWidget(detail: '')
                              ],
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      NavRouter.pushAndRemoveUntilFirstWithAnimation(
                          context, ProfilePageOne());
                    },
                    title: 'Update Profile',
                  )
                ],
              );
            },
          )),
    );
  }
}
