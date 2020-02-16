import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:devtub/blocs/favorite_bloc.dart';
import 'package:devtub/blocs/video_bloc.dart';
import 'package:devtub/delegate/data_search.dart';
import 'package:devtub/model/video_model.dart';
import 'package:devtub/screems/favorites.dart';
import 'package:devtub/widgets/video_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.getBloc<VideoBloc>();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("assets/images/logo.png"),
        ),
        elevation: 10,
        backgroundColor: Color.fromRGBO(39, 39, 39, 2),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: StreamBuilder<Map<String, VideoModel>>(
                  stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                  builder: (ctx, snap){
                    if( snap.hasData && snap.data.length > 0){
                      return Text( "${snap.data.length}");
                    }else{
                      return SizedBox();
                    }
                  },
                ),
              ),
              StreamBuilder<Map<String, VideoModel>>(
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                builder: (ctx, snap){
                  return
                    IconButton(
                      icon: Icon( !snap.hasData || snap.data.length == 0?
                       Icons.favorite_border : Icons.favorite ),
                      color:  !snap.hasData || snap.data.length == 0?
                      Colors.white : Colors.red ,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>Favorites())
                        );
                      },
                    );
                },
              )

            ],
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String query =
                  await showSearch(context: context, delegate: DataSearch());
              if (query != null) {
                bloc.inSearch.add(query);
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream: BlocProvider.getBloc<VideoBloc>().stream,
        builder: (ctx, snap) {
          if (snap.hasData) {
            return ListView.builder(
                 itemBuilder: (ctx, idx) {
                   if (idx < snap.data.length)
                     return VideoTile(snap.data[idx]);
                   else if (idx > 1) {
                     bloc.inSearch.add(
                         null); //para chamar o null e atualizar com mais 10
                     return Container(
                         width: 40,
                         height: 40,
                         alignment: Alignment.center,
                         child:
                         //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),),
                         LoadingBouncingGrid.circle(
                           backgroundColor: Colors.greenAccent,
                           inverted: true,
                           size: 25,
                         )
                     );
                   } else {
                     return Container(
                       margin: EdgeInsets.only(top: 20),
                       child: Center(
                         child: Text("Lista Vazia", style: TextStyle(color: Colors.white),),
                       ),
                     );
                   }
                 },
                itemCount: snap.data.length + 1, //para chamar o null e atualizar com mais 10
                );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
