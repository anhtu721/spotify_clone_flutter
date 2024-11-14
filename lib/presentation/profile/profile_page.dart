import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone_with_flutter/common/widgets/favorite_buton/favorite_button.dart';
import 'package:spotify_clone_with_flutter/core/configs/constants/app_urls.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/favorite_song_cubit.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/favorite_song_state.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/profile_cubit.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/profile_state.dart';
import 'package:spotify_clone_with_flutter/presentation/song_player/song_player_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        bgColor: AppColors.darkGrey,
        title: Text(
          'Profile',
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
          _favoriteSongs(context),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: Container(
        // height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkGrey : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(45),
            bottomLeft: Radius.circular(45),
          ),
        ),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is ProfileLoaded) {
              return Column(
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageURL!),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    state.userEntity.email!,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.isDarkMode
                          ? const Color(0xFFD8D4D4)
                          : const Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    state.userEntity.fullName!,
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
                ],
              );
            }
            if (state is ProfileFailure) {
              return const Text('Please try again');
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteSongCubit()..getFavoriteSong(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'PUBLIC PLAYLISTS',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode
                        ? AppColors.textGrayColor
                        : Colors.black),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongCubit, FavoriteSongState>(
              builder: (context, state) {
                if (state is FavoriteSongLoading) {
                  return const CircularProgressIndicator();
                } else if (state is FavoriteSongLoaded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SongPlayerPage(
                                        songEntity: state.favoriteSongs[index]),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${AppUrls.coverFirestorage}${state.favoriteSongs[index].artist} - ${state.favoriteSongs[index].title}.jpg?${AppUrls.mediaAlt}'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.favoriteSongs[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: context.isDarkMode
                                                ? AppColors.textGrayColor
                                                : AppColors.textblackColor),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        state.favoriteSongs[index].artist,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: context.isDarkMode
                                                ? AppColors.textGrayColor
                                                : AppColors.textblackColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    state.favoriteSongs[index].duration
                                        .toString()
                                        .replaceAll('.', ':'),
                                    style: TextStyle(
                                        color: context.isDarkMode
                                            ? AppColors.textGrayColor
                                            : AppColors.textblackColor),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  FavoriteButton(
                                    songEntity: state.favoriteSongs[index],
                                    key: UniqueKey(),
                                    function: () {
                                      context
                                          .read<FavoriteSongCubit>()
                                          .removeSong(index);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: state.favoriteSongs.length);
                } else if (state is FavoriteSongFailure) {
                  return const Text('Please try again');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
