import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/common/widgets/favorite_buton/favorite_button.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_with_flutter/presentation/home/bloc/playlist/play_list_cubit.dart';
import 'package:spotify_clone_with_flutter/presentation/home/bloc/playlist/play_list_state.dart';
import 'package:spotify_clone_with_flutter/presentation/song_player/song_player_page.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getNewSongs(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Container(
              // alignment: Alignment.center,
              // child: const CircularProgressIndicator(),
            );
          } else if (state is PlayListLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Play List',
                        style: TextStyle(
                          color: AppColors.textGrayColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'See more',
                        style: TextStyle(
                          color: AppColors.textGrayColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 16, 8, 20),
                    child: _songPlayList(state.songs),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _songPlayList(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SongPlayerPage(
                  songEntity: songs[index],
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : AppColors.lightGrey,
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode
                          ? const Color(0xFF959595)
                          : const Color(0xFF616161),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index].title,
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
                        songs[index].artist,
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
                    songs[index].duration.toString().replaceAll('.', ':'),
                    style: TextStyle(
                        color: context.isDarkMode
                            ? AppColors.textGrayColor
                            : AppColors.textblackColor),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  FavoriteButton(
                    songEntity: songs[index],
                  )
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: songs.length,
    );
  }
}
