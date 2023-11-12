import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:urbandelive/User/screens/category_page.dart';
// import 'package:urbandelive/User/screens/user_detail.dart';
import 'package:urbandelive/constants/colors.dart';

import '../screens/category_page.dart';
import '../screens/home_screen.dart';
import '../screens/user_detail.dart';
// import 'package:urbandelive/User/screens/homepage.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: (int page) {
          setState(() {
            _page = page;
          });
        },
        children: const [
          HomePage(),
          CategoryPage(),
          Text("Wishlist"),
          Text("Your Cart"),
          UserDetail(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_sharp),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Your Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
        activeColor: buttonBackgroundColor,
        inactiveColor: secondaryColor,
      ),
    );
  }
}
