import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/dashboard/pages/dashboard_page.dart';
import 'package:orca/module/profile/cubit/profile_cubit/profile_cubit.dart';
import 'package:orca/ui/button/primary_button.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import '../../../config/routes/nav_router.dart';
import '../../../constants/asset_paths.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/widget/picture_widget.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';
import '../cubit/image_picker_cubit/image_picker_cubit.dart';
import '../cubit/image_picker_cubit/image_picker_state.dart';

class UploadImage extends StatelessWidget {
  UploadImage({super.key});

  final userRepo =
      UserAccountRepository(storageService: sl(), sessionRepository: sl());

  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImagePickerCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Upload Your Images",
                    style: context.textTheme.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 25)),
                const SizedBox(
                  height: 50,
                ),
                BlocBuilder<ImagePickerCubit, ImagePickerState>(
                  builder: (context, state) {
                    if (state.imagePickerStatus ==
                        ImagePickerStatus.uploading) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage(AssetPaths.imagePlaceHolder))),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state.imagePickerStatus == ImagePickerStatus.initial) {
                      return PictureWidget(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        radius: 12,
                        imageUrl: AssetPaths.imagePlaceHolder,
                        isEditable: true,
                        onTap: () {
                          context
                              .read<ImagePickerCubit>()
                              .pickAndUploadImage('${user.id}');
                        },
                        errorPath: AssetPaths.imagePlaceHolder,
                      );
                    } else if (state.imagePickerStatus ==
                        ImagePickerStatus.succes) {
                      print(state.message);
                      return Column(
                        children: [
                          PictureWidget(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            radius: 12,
                            imageUrl: '${state.image?.path}',
                            isEditable: true,
                            onTap: () {
                              context
                                  .read<ImagePickerCubit>()
                                  .pickAndUploadImage('${user.id}');
                            },
                            errorPath: AssetPaths.imagePlaceHolder,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          PrimaryButton(
                              onPressed: () {
                                context
                                    .read<ProfileCubit>()
                                    .setProfileStatus('${user.id}', 'updated');
                                NavRouter.pushReplacement(
                                    context, DashboardPage());
                              },
                              title: 'Continue')
                        ],
                      );
                    }
                    return PictureWidget(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      radius: 12,
                      imageUrl: AssetPaths.imagePlaceHolder,
                      isEditable: true,
                      onTap: () {
                        context
                            .read<ImagePickerCubit>()
                            .pickAndUploadImage('${user.id}');
                      },
                      errorPath: AssetPaths.imagePlaceHolder,
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
