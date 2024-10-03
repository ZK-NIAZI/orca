import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/config/routes/nav_router.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/constants/asset_paths.dart';
import 'package:orca/module/authentication/cubit/sign_in_cubit/sign_in_cubit.dart';
import 'package:orca/module/authentication/cubit/sign_in_cubit/sign_in_state.dart';
import 'package:orca/module/authentication/pages/login_page.dart';
import 'package:orca/module/dashboard/pages/dashboard_page.dart';
import 'package:orca/ui/button/primary_button.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import '../../core/di/service_locator.dart';
import '../authentication/model/sign_up_model.dart';
import '../authentication/repository/user_account_repository.dart';
import '../profile/page/profile_page_five.dart';
import '../profile/page/profile_page_four.dart';
import '../profile/page/profile_page_one.dart';
import '../profile/page/profile_page_six.dart';
import '../profile/page/profile_page_three.dart';
import '../profile/page/profile_page_two.dart';
import '../profile/page/upload_image.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(sl(),sl()),
      child: const WelcomePageView(),
    );
  }
}

class WelcomePageView extends StatefulWidget {
  const WelcomePageView({super.key});

  @override
  State<WelcomePageView> createState() => _WelcomePageViewState();
}

final userRepo =
UserAccountRepository(storageService: sl(), sessionRepository: sl());

class _WelcomePageViewState extends State<WelcomePageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AssetPaths.welcomeBg,
                ),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Image.asset(
                          AssetPaths.logoWhite,
                          height: 150,
                        ),
                        Text('ORCA',
                            style: context.textTheme.headlineLarge!.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.white)),
                        Text('Perfect Dating App',
                            style: context.textTheme.titleMedium!
                                .copyWith(color: Colors.white)),
                      ],
                    )),
                BlocConsumer<SignInCubit, LoginState>(
                  listener: (context, state) async {
                    if (state.loginStatus == LoginStatus.success) {
                      SignUpModel user = userRepo.getUserFromDb();
                      await context
                          .read<SignInCubit>()
                          .fetchProfileStatus('${user.id}');

                      if (state.profileStatus == 'updated') {
                        NavRouter.pushAndRemoveUntil(
                            context, const DashboardPage());
                      } else if (state.profileStatus == 'initial') {
                        NavRouter.pushAndRemoveUntil(
                            context, const ProfilePageOne());
                      } else if (state.profileStatus == '1') {
                        NavRouter.pushAndRemoveUntil(
                            context, const ProfilePageTwo());
                      } else if (state.profileStatus == '2') {
                        NavRouter.pushAndRemoveUntil(
                            context, const ProfilePageThree());
                      } else if (state.profileStatus == '3') {
                        NavRouter.pushAndRemoveUntil(
                            context, const ProfilePageFour());
                      } else if (state.profileStatus == '4') {
                        NavRouter.pushAndRemoveUntil(
                            context, const ProfilePageFive());
                      } else if (state.profileStatus == '5') {
                        NavRouter.pushAndRemoveUntil(
                            context, const ProfilePageSix());
                      } else if (state.profileStatus == '6') {
                        NavRouter.pushAndRemoveUntil(context, UploadImage());
                      }
                    }
                  },
                  builder: (context, state) {
                    return PrefixIconButton(
                      onPressed: () {
                        context.read<SignInCubit>().signInWithGoogle();
                      },
                      title: 'Continue with Google',
                      prefixIconPath: AssetPaths.icGoogle,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      NavRouter.pushAndRemoveUntilFirstWithAnimation(context, const LoginPage());
                    },
                    child: Text(
                      'Continue With Email',
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
