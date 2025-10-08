import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/blocs/bloc/sign_up_bloc.dart';
import 'package:flutter_poc/blocs/login/login_bloc.dart';
import 'package:flutter_poc/routes/routes.dart';
import 'package:flutter_poc/blocs/home/home_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_poc/screens/root_ui.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
      ],
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
      onGenerateRoute: AppRoutes.generateRoute,
      home: const RootScreen(),
    );
  }
}
