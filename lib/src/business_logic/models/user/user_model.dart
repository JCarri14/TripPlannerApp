import '../../models.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String thumbnail;
  final List<Trip> trips;

  User({
    this.id = "", 
    this.username = "", 
    this.email = "", 
    this.thumbnail= "",
    this.trips = const []
  });

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      thumbnail: json['thumbnail'],
      trips: []
    );

    for(Map<String, dynamic> trip in json['trips']) {
      user.trips.add(Trip.fromJson(trip));
    }
    return user;
  }

  String toJson() {
    String tripsJson = '[';
    for(Trip trip in this.trips){
      tripsJson += trip.toJson() + ", ";
    }
    tripsJson += "]";

    return "{"
      '"id": ' + this.id + ','
      '"username": ' + this.username + ','
      '"email": ' + this.email + ','
      '"thumbnail": ' + this.thumbnail + ','
      '"trips": ' + tripsJson + ''
      "}";
  }

}