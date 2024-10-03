import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orca/module/favorite/widget/favorite_list_widget.dart';
import 'package:orca/utils/extensions/extended_context.dart';
import '../../../constants/app_colors.dart';
import '../../../core/di/service_locator.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';
import '../cubit/favorite_user_cubit.dart';
import '../cubit/favorite_user_state.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final userRepo =
      UserAccountRepository(storageService: sl(), sessionRepository: sl());

  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return BlocProvider(
      create: (context) => FavoriteUserCubit(),
      child: FavoritePageView(
        userId: "${user.id}",
      ),
    );
  }
}

class FavoritePageView extends StatefulWidget {
  String userId;
  FavoritePageView({super.key, required this.userId});

  @override
  State<FavoritePageView> createState() => _FavoritePageViewState();
}

class _FavoritePageViewState extends State<FavoritePageView> {
  final userRepo =
      UserAccountRepository(storageService: sl(), sessionRepository: sl());

  @override
  void initState() {
    super.initState();
    context.read<FavoriteUserCubit>().fetchAllProfiles(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorite Users',
            style: context.textTheme.headlineMedium,
          ),
        ),
        body: BlocBuilder<FavoriteUserCubit, FavoriteUserState>(
          builder: (context, state) {
            if(state.favoriteUserStatus==FavoriteUserStatus.error){
              return Container(child: Center(child: Text(state.message),),);
            }
            else if(state.favoriteUserStatus==FavoriteUserStatus.succes){
             return ListView.separated(
                 shrinkWrap: true,
                 physics: BouncingScrollPhysics(),
                 itemBuilder: (context, index) {
                   //return Text('${state.favUsers[index].name}');
                   return FavoriteListWidget(
                     image: '${state.favUsers[index].imageUrl}',
                     name: '${state.favUsers[index].name}',
                     email: '${state.favUsers[index].about}',
                     interests: state.favUsers[index].intersets,
                     onCardTap: () {  },
                   );
                 },
                 separatorBuilder: (BuildContext context, int index) {
                   return const SizedBox(
                     height: 15,
                   );
                 },
                 itemCount: state.favUsers.length);
            }
            return Container(child: Center(child: LoadingAnimationWidget.staggeredDotsWave( size: 80, color: AppColors.primaryColor),),);
          },
        ));
  }
}
