import 'package:eagle_eye/screens/home_fragment.dart';
import 'package:eagle_eye/screens/profile.dart';
import 'package:eagle_eye/screens/search_fragment.dart';
import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavbarItem> items = [
    const NavbarItem(Icons.home, 'Home',
        backgroundColor: Color.fromARGB(255, 42, 147, 46)),
    const NavbarItem(Icons.search, 'Search',
        backgroundColor: Color.fromARGB(255, 10, 88, 50)),
    const NavbarItem(Icons.person, 'Profile',
        backgroundColor: Color.fromARGB(255, 92, 154, 20)),
  ];

  final Map<int, Map<String, Widget>> _routes = const {
    0: {
      '/': HomeFragment(),
    },
    1: {
      '/': SearchFragment(),
    },
    2: {
      '/': ProfileScreen(),
    },
  };
  @override
  Widget build(BuildContext context) {
    return NavbarRouter(
      errorBuilder: (context) {
        return const Center(child: Text('Error 404'));
      },
      onBackButtonPressed: (isExiting) {
        return isExiting;
      },
      destinationAnimationCurve: Curves.fastOutSlowIn,
      destinationAnimationDuration: 600,
      decoration:
          NavbarDecoration(navbarType: BottomNavigationBarType.shifting),
      destinations: [
        for (int i = 0; i < items.length; i++)
          DestinationRouter(
            navbarItem: items[i],
            destinations: [
              for (int j = 0; j < _routes[i]!.keys.length; j++)
                Destination(
                  route: _routes[i]!.keys.elementAt(j),
                  widget: _routes[i]!.values.elementAt(j),
                ),
            ],
            initialRoute: _routes[i]!.keys.first,
          ),
      ],
    );
  }
}
