import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:devtub/model/video_model.dart';

import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc extends BlocBase{

  Map<String, VideoModel> _favorites = {};

  //final _favController = StreamController<Map<String, VideoModel>>.broadcast();

  final _favController = BehaviorSubject<Map<String, VideoModel>>();
  Stream<Map<String, VideoModel>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites = json.decode(prefs.getString("favorites")).map((k, v) {
          return MapEntry(k, VideoModel.fromJson(v));
        }).cast<String, VideoModel>();

        _favController.add(_favorites);
      }
    });
  }

  void toggleFavorite(VideoModel video) {
    if (_favorites.containsKey(video.id))
      _favorites.remove(video.id);
    else
      _favorites[video.id] = video;

    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
  }
}
