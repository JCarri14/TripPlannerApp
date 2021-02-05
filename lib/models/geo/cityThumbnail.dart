class CityThumbnail {
  final String smallFormatURI;
  final String largeFormatURI;

  CityThumbnail({this.smallFormatURI, this.largeFormatURI});

  factory CityThumbnail.fromJson(Map<String, dynamic> json) {
    return CityThumbnail(
      smallFormatURI: json['photos']['mobile'],
      largeFormatURI: json['photos']['web'],
    );
  }
}
