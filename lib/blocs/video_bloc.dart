import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:devtub/api/api.dart';
import 'package:devtub/blocs/generic_bloc.dart';
import 'package:devtub/model/video_model.dart';

class VideoBloc extends BlocBase {
  APi api;
  List<VideoModel> videos;
  final  _videoController = StreamController<List<VideoModel>>();
  final  _searchController = StreamController<String>();

  VideoBloc() {
    api = APi();
    _searchController.stream.listen(_search);
  }

  _search(String search) async {
    if( search != null ) {
      _videoController.add([]);
      videos = await api.search(search);
    }else
      videos += await  api.nextPage();

    _videoController.add(videos);
  }



  @override
  dispose() {
    _videoController.close();
    _videoController.close();
  }


  Stream get stream => _videoController.stream;

  Sink get inSearch => _searchController.sink;


}


