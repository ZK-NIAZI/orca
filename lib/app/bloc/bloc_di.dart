import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/profile/cubit/profile_cubit/profile_cubit.dart';
import '../../core/di/service_locator.dart';
import '../../module/dashboard/cubits/dashboard_cubit.dart';
import '../../module/startup/cubit/startup_cubit.dart';

class BlocDI extends StatelessWidget {
  const BlocDI({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit(),
        ),
        BlocProvider<StartupCubit>(
            create: (context) => StartupCubit(sessionRepository: sl())..init()),

      ],
      child: child,
    );
  }
}
