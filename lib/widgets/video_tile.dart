import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:devtub/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:devtub/blocs/favorite_bloc.dart';
import 'package:loading_animations/loading_animations.dart';


class VideoTile extends StatelessWidget {
  final VideoModel video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.title,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.channel,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, VideoModel>>(
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                initialData: {},
                builder:(ctx, snpa){
                  if( snpa.hasData ){
                    return IconButton(
                      icon: Icon(snpa.data.containsKey(video.id) ?
                      Icons.star : Icons.star_border),
                      color: snpa.data.containsKey(video.id) ?
                      Colors.amber : Colors.white,
                      iconSize: 30,
                      onPressed: (){
                        BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(video);
                      },
                    );
                  }else{
                    return LoadingBouncingGrid.circle(
                      backgroundColor: Colors.greenAccent,
                      inverted: true,
                      size: 25,
                    );
                  }
              }
              ),
            ],
          )
        ],
      ),
    );
  }
}
