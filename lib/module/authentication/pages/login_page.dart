import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/module/authentication/cubit/sign_in_cubit/sign_in_cubit.dart';
import 'package:orca/module/authentication/pages/sign_up_page.dart';
import 'package:orca/module/profile/page/profile_page_one.dart';
import 'package:orca/module/startup/welcome_page.dart';
import 'package:orca/ui/button/primary_button.dart';
import 'package:orca/ui/input/input_field.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import 'package:orca/utils/validators/validators.dart';
import 'package:svg_flutter/svg_flutter.dart';
import '../../../config/routes/nav_router.dart';
import '../../../constants/asset_paths.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/widget/loading_widget.dart';
import '../../../ui/widget/rich_text_widget.dart';
import '../../dashboard/pages/dashboard_page.dart';
import '../../profile/page/profile_page_five.dart';
import '../../profile/page/profile_page_four.dart';
import '../../profile/page/profile_page_six.dart';
import '../../profile/page/profile_page_three.dart';
import '../../profile/page/profile_page_two.dart';
import '../../profile/page/upload_image.dart';
import '../cubit/sign_in_cubit/sign_in_state.dart';
import '../model/sign_in_model.dart';
import '../model/sign_up_model.dart';
import '../repository/user_account_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(sl(), sl()),
      child: LoginPageView(),
    );
  }
}

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final userRepo =
      UserAccountRepository(storageService: sl(), sessionRepository: sl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              NavRouter.pushAndRemoveUntilFirstWithAnimation(
                  context, const WelcomePage());
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign In',
                  style: context.textTheme.headlineLarge!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 32)),
              const SizedBox(
                height: 55,
              ),
              InputField(
                controller: _emailController,
                label: 'Email',
                validator: (value) => Validators.email(value),
                prefixIcon: SvgPicture.asset(AssetPaths.icMail),
              ),
              const SizedBox(
                height: 18,
              ),
              InputField(
                  controller: _passController,
                  label: 'Password',
                  validator: (value) => Validators.password(value),
                  obscureText: true,
                  prefixIcon: SvgPicture.asset(AssetPaths.icPass)),
              const SizedBox(
                height: 38,
              ),
              BlocConsumer<SignInCubit, LoginState>(
                listener: (context, state) async {
                  if (state.loginStatus == LoginStatus.loading) {
                    LoadingDialog.show(context);
                  }
                  if (state.loginStatus == LoginStatus.success) {
                    SignUpModel user = userRepo.getUserFromDb();
                    await context
                        .read<SignInCubit>()
                        .fetchProfileStatus('${user.id}');
                    LoadingDialog.hide(context);
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
                  if (state.loginStatus == LoginStatus.error) {
                    LoadingDialog.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                  if (state.loginStatus == LoginStatus.userNotFound) {
                    LoadingDialog.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final credential = SigInModel(
                            email: _emailController.text,
                            password: _passController.text);
                        context
                            .read<SignInCubit>()
                            .login(credential.email, credential.password);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Enter your user name and password')),
                        );
                      }
                    },
                    title: 'Sign In',
                    hMargin: 0,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              RichTextWidget(
                firstText: 'Dont have an account? ',
                secondText: 'Signup',
                secondTextColor: AppColors.primaryColor,
                onPressed: () {
                  NavRouter.pushAndRemoveUntil(context, const SignUpPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
