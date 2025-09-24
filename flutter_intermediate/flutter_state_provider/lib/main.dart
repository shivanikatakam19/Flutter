import 'package:flutter/material.dart';
import 'package:flutter_state_provider/screens/horizontal_view.dart';
import 'package:flutter_state_provider/screens/vertical_view.dart';
import 'package:flutter_state_provider/shared/providers/list-provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumbersListProvider()),
      ],
      child: MaterialApp(home: HorizontalView()),
    );
  }
}
