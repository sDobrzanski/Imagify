class Photo {
  String id;
  String photoDesc;
  String photoAltDesc;
  String photoAuthor;
  String photoUrlSmall;
  String photoUrlRegular;
  String downloadUrl;
  int likes;

  Photo(
      {this.id,
      this.photoDesc,
      this.photoAltDesc,
      this.photoAuthor,
      this.photoUrlSmall,
      this.photoUrlRegular,
      this.downloadUrl,
      this.likes});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoDesc =
        json['description'] != null ? json['description'] : 'Empty Title';
    photoAltDesc = json['alt_description'] != null
        ? json['alt_description']
        : 'Empty Title';
    photoAuthor = json['user']['name'] != null
        ? json['user']['name']
        : json['user']['username'];
    photoUrlSmall = json['urls']['small'];
    photoUrlRegular = json['urls']['regular'];
    downloadUrl = json['links']['download'];
    likes = json['likes'];
  }
}
