import 'package:trip_planner_app/models/hotel/landmark.dart';

class Hotel {
  final String id;
  final String name;
  final String address;
  final String postalCode;
  final String thumbnailUrl;
  final List<Landmark> landmarks;
  final int starRating;
  final double userRating;
  final int pricePerNight;
  final double latitude;
  final double longitude;

  Hotel({this.id,
    this.name,
    this.address,
    this.postalCode,
    this.thumbnailUrl,
    this.landmarks,
    this.starRating,
    this.userRating,
    this.pricePerNight,
    this.latitude,
    this.longitude
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    Hotel hotel = Hotel(
      id: json['id'],
      name: json['name'],
      address: json['address']['streetAddress'],
      postalCode: json['address'],
      thumbnailUrl: json['thumbnailUrl'],
      landmarks: new List<Landmark>(),
      starRating: json['starRating'],
      userRating: json['guestReviews']['unformattedRating'],
      pricePerNight: json['ratePlan']['price']['exactCurrent'].round(),
      latitude: json['coordinate']['lat'],
      longitude: json['coordinate']['lon']
    );

    json['landmarks'].forEach((c) {
      landmarks.add(Landmark.fromJson(c));
    });

    return hotel;
  }
}