import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone_with_flutter/core/configs/assets/app_images.dart';
import 'package:spotify_clone_with_flutter/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_with_flutter/presentation/register_or_signin/register/register.dart';
import 'package:spotify_clone_with_flutter/presentation/register_or_signin/signin/signin.dart';

class RegisterSignup extends StatelessWidget {
  const RegisterSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AppBar(),
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(AppVectors.topPattern),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SvgPicture.asset(AppVectors.bottomPattern),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset(AppImages.registerOrSignupBG),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppVectors.logo),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enjoy Listen to Music',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Spotify is a proprietary Swedish audio streaming and media services provider',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child:
                          BasicAppButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const RegisterPage()));
                          }, title: 'Register'),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SignInPage()));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: context.isDarkMode
                                  ? AppColors.textButtonColor
                                  : AppColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
