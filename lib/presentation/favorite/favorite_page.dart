import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone_with_flutter/common/widgets/favorite_buton/favorite_button.dart';
import 'package:spotify_clone_with_flutter/core/configs/constants/app_urls.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/favorite_song_cubit.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/bloc/favorite_song_state.dart';
import 'package:spotify_clone_with_flutter/presentation/song_player/song_player_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        bgColor: context.isDarkMode ? AppColors.darkGrey : Colors.white,
        title: Text(
          'Favorite Mucsic',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.isDarkMode
                  ? AppColors.textAppbarColor
                  : AppColors.textblackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _favoriteSongs(context),
          ],
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
