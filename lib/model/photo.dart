class Photo {
  String id;
  String photoDesc;
  String photoAuthor;
  String photoUrlSmall;
  String photoUrlRegular;
  String downloadUrl;
  int likes;

  Photo(
      {this.id,
      this.photoDesc,
      this.photoAuthor,
      this.photoUrlSmall,
      this.photoUrlRegular,
      this.downloadUrl,
      this.likes});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoDesc = json['description'] != null
        ? json['description']
        : json['alt_description'];
    photoAuthor = json['user']['name'] != null
        ? json['user']['name']
        : json['user']['username'];
    photoUrlSmall = json['urls']['small'];
    photoUrlRegular = json['urls']['regular'];
    downloadUrl = json['links']['download'];
    likes = json['likes'];
  }
}
