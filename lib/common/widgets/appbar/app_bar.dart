import 'package:flutter/material.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hideBack;
  final Widget? action;
  final Widget? title;
  final Color ? bgColor;
  const BasicAppBar({this.title, super.key, this.hideBack = false, this.action, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? Colors.transparent,
      elevation: 0,
      title: title ?? const Text(''),
      centerTitle: true,
      actions: [
        action ?? Container(),
      ],
      // leading: hideBack ? null : IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Container(
      //       decoration: BoxDecoration(
      //         color: context.isDarkMode
      //             ? Colors.white.withOpacity(0.03)
      //             : Colors.black.withOpacity(0.03),
      //         shape: BoxShape.circle,
      //       ),
      //       child: Icon(Icons.arrow_back_ios_new,
      //           size: 24,
      //           color: context.isDarkMode ? Colors.white : Colors.black),
      //     )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
