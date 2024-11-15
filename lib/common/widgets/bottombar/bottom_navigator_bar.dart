import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: context.isDarkMode
          ? const Color(0XFF343434)
          : const Color(0xFFFFFFFF),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppVectors.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppVectors.discovery),
          label: 'Discovery',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppVectors.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppVectors.profile),
          label: 'Profile',
        ),
      ],
      selectedItemColor: AppColors.primaryColor,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }
}
