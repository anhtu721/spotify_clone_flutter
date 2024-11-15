import 'package:flutter/material.dart';
import 'package:spotify_clone_with_flutter/common/widgets/bottombar/bottom_navigator_bar.dart';
import 'package:spotify_clone_with_flutter/presentation/discovery/discovery_page.dart';
import 'package:spotify_clone_with_flutter/presentation/favorite/favorite_page.dart';
import 'package:spotify_clone_with_flutter/presentation/home/homepage.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DiscoveryPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
