import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/presentation/editprofile/image_helpers/image_picker_helper.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone_with_flutter/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_with_flutter/data/models/user_model.dart';
import 'package:spotify_clone_with_flutter/data/source/auth_firebase_service.dart';
import 'package:spotify_clone_with_flutter/presentation/editprofile/image_helpers/image_upload_helper.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/profile_cubit.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/profile_state.dart';

class EditprofilePage extends StatefulWidget {
  const EditprofilePage({super.key});

  @override
  State<EditprofilePage> createState() => _EditprofilePageState();
}

class _EditprofilePageState extends State<EditprofilePage> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  String? selectedImagePath;
  String? uploadedImageUrl;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        bgColor: context.isDarkMode ? AppColors.darkGrey : Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.isDarkMode
                  ? AppColors.textAppbarColor
                  : AppColors.textblackColor),
        ),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(
            height: 20,
          ),
          if (isUpdating)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            emailController.text = state.userEntity.email!;
            nameController.text = state.userEntity.fullName!;

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: selectedImagePath != null
                                ? FileImage(File(selectedImagePath!))
                                : NetworkImage(state.userEntity.imageURL!)
                                    as ImageProvider,
                            // image: NetworkImage(state.userEntity.imageURL!),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            String? newImagePath =
                                await ImagePickerHelper.pickImage(context);
                            if (newImagePath != null) {
                              setState(() {
                                selectedImagePath = newImagePath;
                              });
                            }
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDarkMode
                                  ? const Color(0xFF222222)
                                  : const Color(0xFFFFFFFF),
                              border:
                                  Border.all(width: 1, color: AppColors.grey),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 24,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: context.isDarkMode
                            ? const Color(0xFFD8D4D4)
                            : const Color(0xFF222222),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: context.isDarkMode
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: context.isDarkMode
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF222222),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: context.isDarkMode
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: BasicAppButton(
                        onPressed: () async {
                          if (selectedImagePath != null) {
                            String imageUrl =
                                await ImageUploadHelper.uploadImage(
                                    selectedImagePath!, '');
                            UserModel updatedUser = UserModel(
                              email: emailController.text,
                              fullName: nameController.text,
                              imageURL: imageUrl,
                            );
                            await AuthFirebaseServiceImpl()
                                .updateUser(updatedUser);
                          } else {
                            UserModel updatedUser = UserModel(
                              email: emailController.text,
                              fullName: nameController.text,
                              imageURL: state.userEntity.imageURL,
                            );
                            await AuthFirebaseServiceImpl()
                                .updateUser(updatedUser);
                          }

                          Navigator.pop(context);
                        },
                        title: 'Update'),
                  )
                ],
              ),
            );
          }
          if (state is ProfileFailure) {
            return const Text('Please try again');
          }
          return Container();
        },
      ),
    );
  }
}
