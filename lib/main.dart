import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:devtub/blocs/favorite_bloc.dart';
import 'package:devtub/blocs/video_bloc.dart';
import 'package:devtub/screems/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
//262626
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideoBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        
        home: Home(),
      ),
    );
  }
}
