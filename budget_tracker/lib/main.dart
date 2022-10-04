import 'package:budget_tracker/screens/home.dart';
import 'package:budget_tracker/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Always create your providers above the widget tree
    /* we can wrap our MaterialApp with the ChangeNotifierProvider now
    but when creating the provider, you can't use it directly due to context issues.
    And we need to use it as soon as possible as our Theme is defined inside MaterialApp
    
    Because we need to access the provider as soon as we create, we need a Builder widget
    inbetween to provide us with the necessary parent context */
    return ChangeNotifierProvider<ThemeService>(
      create: (_) => ThemeService(),
      child: Builder(builder: (BuildContext context) {
        final themeService = Provider.of<ThemeService>(context);
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,

                /* we can use themeService.darkTheme to determine if we are
                in dark mode or not */
                brightness:
                    themeService.darkTheme ? Brightness.dark : Brightness.light,
              ),
            ),
            home: const Home());
      }),
    );
  }
}
