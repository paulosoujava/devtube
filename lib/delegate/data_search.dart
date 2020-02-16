import 'package:devtub/api/api.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) {
      close(context, query);
    });
    return Container();

//    if (query.isNotEmpty) {
//      return FutureBuilder<List>(
//        future: APi().suggestions(query),
//        builder: (ctx, snap) {
//          if (!snap.hasData) {
//            return Center(
//              child: CircularProgressIndicator(
//                backgroundColor: Colors.black87,
//              ),
//            );
//          } else {
//            return ListView.builder(
//              itemCount: snap.data.length,
//              itemBuilder: (ctx, idx) {
//                return ListTile(
//                  leading: Icon(Icons.play_arrow),
//                  title: Text(snap.data[idx]),
//                  onTap: () => close(context, snap.data[idx]),
//                );
//              },
//            );
//          }
//        },
//      );
//    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder<List>(
        future: APi().suggestions(query),
        builder: (ctx, snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black87,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (ctx, idx) {
                return ListTile(
                  leading: Icon(Icons.play_arrow),
                  title: Text(snap.data[idx]),
                  onTap: () => close(context, snap.data[idx]),
                );
              },
            );
          }
        },
      );
    }
    return Container();
  }


}
