import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/constants/app_colors.dart';
import 'package:orca/constants/asset_paths.dart';
import 'package:orca/module/home/cubit/home_cubit.dart';
import 'package:orca/module/home/cubit/home_state.dart';
import 'package:orca/module/home/widget/shimer_loading.dart';
import '../../swip_card/widgets/card_stack_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(FirebaseDatabase.instance.ref()),
      child: HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchAllProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 130,
        leading: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset(AssetPaths.logo),
            const Text(
              'ORCA',
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: AppColors.primaryColor,
              )),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.homeStatus == HomeStatus.loading) {
            return ShimmerLoading();
          }
          if (state.homeStatus == HomeStatus.succes) {
            return state.profiles.isNotEmpty
                ? CardsStackWidget(
                    profiles: state.profiles,
                  )
                : const Center(
                    child: Text("No Users Found!"),
                  );
          }
          if (state.homeStatus == HomeStatus.error) {
            print(state.message);
            return Center(
              child: Text('${state.message}'),
            );
          }
          print(state.message);
          return Container();
        },
      ),
    );
  }
}
