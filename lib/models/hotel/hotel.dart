class Hotel {
  final String id;
  final String name;
  final String address;
  final String thumbnailUrl;
  final int starRating;
  double userRating;
  int pricePerNight;

  Hotel({this.id,
    this.name,
    this.address,
    this.thumbnailUrl,
    this.starRating,
    this.userRating,
    this.pricePerNight
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      address: json['address']['streetAddress'],
      thumbnailUrl: json['thumbnailUrl'],
      starRating: json['starRating'],
      userRating: json['guestReviews']['unformattedRating'],
      pricePerNight: json['ratePlan']['price']['exactCurrent'].round()
    );
  }
}