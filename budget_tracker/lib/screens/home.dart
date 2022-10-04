import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/add_budget.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../services/budget_service.dart';
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
    final themeService = Provider.of<ThemeService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Tracker"),
        leading: IconButton(
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
                      budgetToAdd: (budget) {
                        /* we need to set our budget using the callback coming
                        from the AddBudgetDialog on the IconButton
                        We do that by getting our service from the provider
                        and setting the budgetService.budget to the budget
                        we inputted in the Dialog */
                        final budgetService =
                            Provider.of<BudgetService>(context, listen: false);
                        /* Notice the listen:false
                        that's because we don't want to rebuild that widget
                        when we change the budget. Now when you input, your budget's
                        state will be saved by BudgetService */
                        budgetService.budget = budget;
                      },
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
