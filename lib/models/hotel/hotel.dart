import 'package:trip_planner_app/models/hotel/landmark.dart';
import 'dart:math';

class Hotel {
  final String id;
  final String name;
  final String address;
  final String postalCode;
  final String thumbnailUrl;
  final List<Landmark> landmarks;
  final double starRating;
  final double userRating;
  int pricePerNight;
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
    print(json);
    Hotel hotel = Hotel(
      id: json['id'].toString(),
      name: json['name'],
      address: json['address']['streetAddress'],
      postalCode: json['address']['postalCode'].toString(),
      thumbnailUrl: json['thumbnailUrl'],
      landmarks: new List<Landmark>(),
      starRating: json['starRating'],
      userRating: json['guestReviews']['unformattedRating'],
      latitude: json['coordinate']['lat'],
      longitude: json['coordinate']['lon']
    );
    if (json['ratePlan'] != null) {
      hotel.pricePerNight = json['ratePlan']['price']['exactCurrent'].round();
    } else {
      hotel.pricePerNight = new Random().nextInt(100) + 20;
    }

    json['landmarks'].forEach((c) {
      hotel.landmarks.add(Landmark.fromJson(c));
    });

    return hotel;
  }
}