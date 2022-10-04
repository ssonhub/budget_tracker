import 'package:budget_tracker/screens/home.dart';
import 'package:budget_tracker/services/budget_service.dart';
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
    /* After calling notifyListeners on budget_service.dart, we need to go to
    main.dart to initialize it. The problem is that we are currently already
    returning a Theme service provider, so we need a way to initialize
    multiple providers at the same time
    
    Thankfully, there is a MultiProvider widget that takes in multiple providers */
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(create: (_) => ThemeService()),
        ChangeNotifierProvider<BudgetService>(create: (_) => BudgetService()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeService = Provider.of<ThemeService>(context);
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness:
                    themeService.darkTheme ? Brightness.dark : Brightness.light,
              ),
            ),
            home: const Home());
      }),
    );
  }
}
