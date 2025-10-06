import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/routes/routes.dart';
import 'package:flutter_poc/screens/home/bloc/home_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider<HomeBloc>(create: (context) => HomeBloc())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
