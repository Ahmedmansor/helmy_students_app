import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy/cubits/auth/cubit/auth_cubit.dart';

import '../core/utils/app_settings.dart';
import '../cubits/dash_board/cubit/dash_board_cubit.dart';
import '../views/dash_board/presentation/views/on Boarding/on_boarding_view.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettings.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => DashBoardCubit()..getAllStudents(),
        ),
      ],
      // child: const MaterialApp(home: SplashScreen()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: DashBoardView(),
        home: OnBoarding(),
      ),
    );
  }
}
