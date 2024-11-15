import 'package:flutter/material.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_with_flutter/presentation/home/widget/play_list.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        bgColor: context.isDarkMode ? AppColors.darkGrey : Colors.white,
        title: Text(
          'Discovery',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.isDarkMode
                  ? AppColors.textAppbarColor
                  : AppColors.textblackColor),
        ),
      ),
      body: const SingleChildScrollView(
        child: PlayList(),
      ),
    );
  }
}
