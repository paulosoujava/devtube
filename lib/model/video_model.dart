class VideoModel {
  final String id;
  final String title;
  final String channel;
  final String thumb;

  VideoModel({this.id, this.title, this.channel, this.thumb});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    if(json.containsKey("id"))
    return VideoModel(
      id: json["id"]['videoId'],
      title: json["snippet"]['title'],
      channel: json["snippet"]['channelTitle'],
      thumb: json["snippet"]['thumbnails']['high']['url'],
    );
    else
      return VideoModel(
          id: json["videoId"],
          title: json["title"],
          thumb: json["thumb"],
          channel: json["channel"]
      );
  }

  Map<String, dynamic> toJson(){
    return {
      "videoId": id,
      "title": title,
      "thumb": thumb,
      "channel": channel
    };
  }


  @override
  String toString() {
    return 'VideoModel{id: $id, title: $title, channel: $channel, thumb: $thumb}';
  }


}
