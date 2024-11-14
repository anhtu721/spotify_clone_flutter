import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone_with_flutter/data/models/song_model.dart';
import 'package:spotify_clone_with_flutter/domain/entities/song/song_entity.dart';
import 'package:spotify_clone_with_flutter/domain/usescase/song/is_favorite_usecase.dart';
import 'package:spotify_clone_with_flutter/service.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songID);
  Future<bool> isFavorite(String songID);
  Future<Either> getFavoriteSong();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite =
            await sl<IsFavoriteUsecase>().call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songID = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left('An error occurred, please try again.');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite =
            await sl<IsFavoriteUsecase>().call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songID = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left('An error occurred, please try again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songID) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      String uID = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uID)
          .collection('Favorites')
          .where('songID', isEqualTo: songID)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        firebaseFirestore
            .collection('Users')
            .doc(uID)
            .collection('Favorites')
            .add(
          {
            'songID': songID,
            'addedDate': Timestamp.now(),
          },
        );
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  @override
  Future<bool> isFavorite(String songID) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uID = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uID)
          .collection('Favorites')
          .where('songID', isEqualTo: songID)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getFavoriteSong() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      List<SongEntity> favoriteSongs = [];
      var user = firebaseAuth.currentUser;
      String uID = user!.uid;

      QuerySnapshot favoriteSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uID)
          .collection('Favorites')
          .get();

      for (var element in favoriteSnapshot.docs) {
        String songID = element['songID'];
        var song =
            await firebaseFirestore.collection('Songs').doc(songID).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songID = songID;
        favoriteSongs.add(songModel.toEntity());
      }
      return Right(favoriteSongs);
    } catch (e) {
      return const Left('An error occurred');
    }
  }
}
