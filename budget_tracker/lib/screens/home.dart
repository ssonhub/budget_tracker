import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/add_budget.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../services/theme_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    /* Now to access the theme data inside Theme Service
    we can use this syntax to get/set information */

    /* Remember that you need to access the themeService and you can do that
    by calling it after the build method */
    final themeService = Provider.of<ThemeService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Tracker"),
        /* leading: means that the widget will show on the left of the AppBar */
        leading: IconButton(
          /* Notice how we set the themeService.darkTheme = !themeService.darkTheme
          This is a great way to do it when you need to toggle something */
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },
          icon: Icon(themeService.darkTheme ? Icons.sunny : Icons.dark_mode),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddBudgetDialog(
                      budgetToAdd: (budget) {},
                    );
                  });
            },
            icon: const Icon(Icons.attach_money),
          ),
        ],
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: bottomNavItems,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
