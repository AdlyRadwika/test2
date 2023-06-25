import 'package:book_selection/utils/theme.dart';
import 'package:book_selection/utils/providers.dart';
import 'package:book_selection/screens/route.dart' as route;
import 'package:flutter/material.dart';
import 'package:book_selection/utils/injection.dart' as di;
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Book Selection App',
        theme: myThemeData,
        onGenerateRoute: route.controller,
        initialRoute: route.homeScreen,
      ),
    );
  }
}
