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

  factory Hotel.fromJsonResume(Map<String, dynamic> json){
    Hotel hotel = Hotel(
        id: json['id'].toString(),
        name: json['name'],
        address: json['address'],
        postalCode: json['postalCode'].toString(),
        thumbnailUrl: json['thumbnailUrl'],
        landmarks: new List<Landmark>(),
        starRating: json['starRating'],
        userRating: json['userRating'],
        pricePerNight: json['pricePerNight'],
        latitude: json['latitude'],
        longitude: json['longitude']
    );

    for(Map<String, dynamic> value in json['landmarks']){
      hotel.landmarks.add(Landmark.fromJsonResume(value));
    }

    return hotel;
  }

  String toJson(){
    String landmarkResponse = "{ landmarks: [";
    for(Landmark landmark in this.landmarks){
      landmarkResponse += landmark.toJson() + ",";
    }
    landmarkResponse += "] }";
    return "{"
        "id: " + this.id + ","
        "name: " + this.name + ","
        "address: " + this.address + ","
        "postalCode: " + this.postalCode + ","
        "thumbnailUrl: " + this.thumbnailUrl + ","
        "landmarks: " + landmarkResponse + ","
        "starRating: " + this.starRating.toString() + ","
        "userRating: " + this.userRating.toString() + ","
        "latitude: " + this.latitude.toString() + ","
        "longitude: " + this.longitude.toString() + ","
        "}";
  }
}