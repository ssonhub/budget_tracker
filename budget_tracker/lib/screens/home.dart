import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // To create the list of bottomNavItems, we can declare it as below
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),

    /* If you try clicking on the bottom navigation bar, nothing happens
    because we haven't given any onTap: functionality. */
  ];

  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];

  /* if we wanted to access the HomePage, we could do pages[0] and pages[1]
    would give us Profile. Because onTap: gives us the index when we press,
    we can use that to change the body: of our widget to render each page
    
    To do that, we first need to declare a _currentPageIndex variable that
    will hold the current selected page index and will be the one we'll use to
    set it */

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Tracker"),
      ),
      // parameter we can call pages[_crrentPageIndex]
      // This will render the page selection accordingly
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        /* BottomNavigationBar widget has an onTap(int) 
        when we click the Home icon, it would print out 0 and for the Profile
        icon, it would print out 1*/
        onTap: (index) => print(index),
      ),
    );
  }
}
