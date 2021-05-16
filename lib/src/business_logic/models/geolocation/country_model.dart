class Country {
  final String apiId;
  final String name;
  final String code;

  Country({
    this.apiId = "", 
    this.name = "", 
    this.code = ""
  });
  
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      apiId: json['wikiDataId'],
      name: json['name'],
      code: json['code']
    );
  }
}
