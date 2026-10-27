import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/cubit/home_tab_cubit.dart';
import 'features/home/screens/home_screen.dart';
import 'features/profile/cubit/profile_cubit.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileCubit()..loadImage()),
        BlocProvider(create: (context) => HomeTabCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}