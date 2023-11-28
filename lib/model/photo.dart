class Photo {
  String largeImageURL;

  Photo({required this.largeImageURL});

  factory Photo.fromJson(dynamic data) {
    return Photo(largeImageURL: data['largeImageURL']);
  }
}
