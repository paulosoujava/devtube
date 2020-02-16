import 'dart:convert';

import 'package:devtub/model/video_model.dart';
import 'package:devtub/utils/const.dart';
import 'package:http/http.dart' as http;

class APi {
  String _search;
  String _nextToken;

  search(String search) async {
    _search = search;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");
    return decode(response);
  }
  nextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
    );
    return decode(response);
  }

  List<VideoModel> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      _nextToken = decoded['nextPageToken'];
      return decoded["items"].map<VideoModel>((map) {
        return VideoModel.fromJson(map);
      }).toList();
    }
    throw Exception("Faild search");
  }

  Future<List> suggestions(String src ) async {
    http.Response  response = await http.get(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$src&format=5&alt=json",
    );

    if( response.statusCode == 200 ){
      return json.decode(response.body)[1].map( (v){
        return v[0];
      }).toList();
    }
    return throw("Fail suggestions");
  }
}
