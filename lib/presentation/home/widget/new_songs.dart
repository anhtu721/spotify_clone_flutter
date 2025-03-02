import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/core/configs/constants/app_urls.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_with_flutter/presentation/home/bloc/newsong/new_song_cubit.dart';
import 'package:spotify_clone_with_flutter/presentation/home/bloc/newsong/new_song_state.dart';
import 'package:spotify_clone_with_flutter/presentation/song_player/song_player_page.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewSongCubit()..getNewSongs(),
      child: SizedBox(
          height: 200,
          child: BlocBuilder<NewSongCubit, NewSongsState>(
            builder: (context, state) {
              if (state is NewSongsLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              } else if (state is NewSongsLoaded) {
                return _songs(state.songs);
              } else if (state is NewSongsLoadFail) {
                return const Center(child: Text('Failed to load new songs'));
              }
              return Container();
            },
          )),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      itemCount: songs.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
               builder: (BuildContext context)
              => SongPlayerPage(
                songEntity: songs[index],
              )
            ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 165,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            '${AppUrls.coverFirestorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppUrls.mediaAlt}',
                            // encodedUrl,
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.isDarkMode
                                  ? AppColors.darkGrey
                                  : const Color(0xffE6E6E6)),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: context.isDarkMode
                                ? const Color(0xff959595)
                                : const Color(0xff555555),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    songs[index].title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 26),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    songs[index].artist,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 14,
      ),
    );
  }
}
