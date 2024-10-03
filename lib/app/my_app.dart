import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/app/bloc/bloc_di.dart';
import 'package:orca/config/theme/light_theme.dart';
import 'package:orca/module/dashboard/pages/dashboard_page.dart';
import 'package:orca/module/profile/page/profile_page_five.dart';
import 'package:orca/module/profile/page/profile_page_four.dart';
import 'package:orca/module/profile/page/profile_page_six.dart';
import 'package:orca/module/profile/page/profile_page_two.dart';
import 'package:orca/module/profile/page/upload_image.dart';
import 'package:orca/module/startup/cubit/startup_cubit.dart';
import 'package:orca/module/startup/splash_page.dart';
import 'package:orca/module/startup/welcome_page.dart';

import '../core/di/service_locator.dart';
import '../module/authentication/model/sign_up_model.dart';
import '../module/authentication/repository/user_account_repository.dart';
import '../module/profile/page/profile_page_one.dart';
import '../module/profile/page/profile_page_three.dart';
class OrcaApp extends StatefulWidget {
  const OrcaApp({super.key});

  @override
  State<OrcaApp> createState() => _OrcaAppState();
}
final userRepo =
UserAccountRepository(storageService: sl(), sessionRepository: sl());
class _OrcaAppState extends State<OrcaApp> {
  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return BlocDI(
      child: MaterialApp(
        title: 'Orca App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: lightTheme,
        home: BlocConsumer<StartupCubit, StartupState>(
          builder: (context, state) {
            if (state.status == Status.authenticated) {
              context.read<StartupCubit>().fetchProfileStatus('${user.id}');
              if(state.profileStatus=='updated'){
                return const DashboardPage();
              }
              else if(state.profileStatus=='initial'){
                return  ProfilePageOne();
              }
              else if(state.profileStatus=='1'){
                return  ProfilePageTwo();
              }
              else if(state.profileStatus=='2'){
                return  ProfilePageThree();
              }
              else if(state.profileStatus=='3'){
                return  ProfilePageFour();
              }
              else if(state.profileStatus=='4'){
                return  ProfilePageFive();
              }
              else if(state.profileStatus=='5'){
                return  ProfilePageSix();
              }
              else if(state.profileStatus=='6'){
                return  UploadImage();
              }

            }
            else if (state.status == Status.unauthenticated) {
              return const WelcomePage();
            }
            return const SplashPage();
          }, listener: (BuildContext context, StartupState state) {
          if (state.status == Status.authenticated) {
            //context.read<StartupCubit>().fetchProfileStatus('${user.id}');
          }
        },
        ),
      ),
    );
  }
}
