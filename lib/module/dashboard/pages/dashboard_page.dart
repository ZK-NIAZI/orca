import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/favorite/page/favorite_page.dart';
import 'package:orca/module/home/page/home_page.dart';
import 'package:orca/module/profile/page/profile_page.dart';
import 'package:orca/module/search/pages/search_page.dart';

import '../cubits/dashboard_cubit.dart';
import '../cubits/dashboard_state.dart';
import '../widgets/navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: Navbar(
            tabs: state.tabs,
            onChanged: (index) {
              context.read<DashboardCubit>().changeNavSelection(index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal, // or Axis.vertical
            children: [
              //pages
              const HomePage(),
              const SearchPage(),
              FavoritePage(),
              const ProfilePage()
            ],
          ),
        );
      },
    );
  }
}
