class Landmark {
  final String label;
  final String distance;

  Landmark({
    this.label = "", 
    this.distance = ""
    });
  
  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      label: json['label'],
      distance: json['distance'],
    );
  }

  factory Landmark.fromJsonResume(Map<String, dynamic> json) {
    return Landmark(
      label: json['label'],
      distance: json['distance'],
    );
  }

  String toString(){
    return "Distance to " + label + ": " + distance;
  }

  String toJson(){
    return "{"
        '"label": ' + this.label +
        '"distance": ' + this.distance +
        "}";
  }
}
