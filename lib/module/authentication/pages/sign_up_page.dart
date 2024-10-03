import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:orca/module/authentication/model/sign_up_model.dart';
import 'package:orca/module/authentication/pages/login_page.dart';
import 'package:orca/module/profile/page/profile_page_one.dart';
import 'package:orca/ui/widget/loading_widget.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import 'package:orca/utils/validators/validators.dart';
import 'package:svg_flutter/svg.dart';

import '../../../config/routes/nav_router.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/asset_paths.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/button/primary_button.dart';
import '../../../ui/input/input_field.dart';
import '../../../ui/widget/rich_text_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(FirebaseAuth.instance,sl(),sl()),
      child: const SignUpPageView(),
    );
  }
}

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({super.key});

  @override
  State<SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cnfrmPassController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign Up',
                  style: context.textTheme.headlineLarge!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 32)),
              const SizedBox(
                height: 55,
              ),

              InputField(
                validator: (value) => Validators.required(value),
                controller: _nameController,
                label: 'Name',
                prefixIcon: SvgPicture.asset(AssetPaths.icProfile),
              ),
              const SizedBox(height: 10,),
              InputField(
                controller: _emailController,
                label: 'Email',
                validator: (value) => Validators.email(value),
                prefixIcon: SvgPicture.asset(AssetPaths.icMail),
              ),
              const SizedBox(height: 10,),
              InputField(
                controller: _passController,
                label: 'Password',
                validator: (value) => Validators.password(value),
                obscureText: true,
                prefixIcon: SvgPicture.asset(AssetPaths.icPass),
              ),
              const SizedBox(height: 10,),
              InputField(
                controller: _cnfrmPassController,
                label: 'Confirm Password',
                validator: (value) {
                  return Validators.password(value);
                },
                obscureText: true,
                prefixIcon: SvgPicture.asset(AssetPaths.icPass),
              ),

              const SizedBox(height: 40,),
              BlocListener<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state.signUpStatus == SignUpStatus.loading) {
                    LoadingDialog.show(context);
                  }
                  if (state.signUpStatus == SignUpStatus.success) {
                    LoadingDialog.hide(context);
                    NavRouter.pushAndRemoveUntil(
                        context, const ProfilePageOne());
                  }
                  if (state.signUpStatus == SignUpStatus.failed) {
                    LoadingDialog.hide(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: PrimaryButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final data = SignUpModel(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passController.text,
                      );

                      context.read<SignUpCubit>().signUp(
                        data.name,
                        data.email,
                        data.password,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(
                            'Please fix the errors in the form.')),
                      );
                    }
                  },
                  title: 'Sign Up',
                  hMargin: 0,
                ),
              ),
              const SizedBox(height: 20,),
              RichTextWidget(
                firstText: 'Already have an account? ',
                secondText: 'Sign In',
                secondTextColor: AppColors.primaryColor,
                onPressed: () {
                  NavRouter.pushAndRemoveUntil(context, const LoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


