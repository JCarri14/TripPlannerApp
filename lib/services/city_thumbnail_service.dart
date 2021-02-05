import 'dart:core';
import 'package:trip_planner_app/models/geo/cityThumbnail.dart';
import 'package:trip_planner_app/repository/city_thumbnail_repository.dart';

import '../api/api_provider.dart';

class CityThumbnailService implements CityThumbnailRepository {
  static const String _baseUrl = "api.teleport.org";
  String _pathUrl;
  Map<String, String> _headers;
  ApiProvider _service = ApiProvider();

  CityThumbnailService() {
    _headers = {
      'useQueryString': 'true'
    };
  }

  Uri _createUri() {
    return Uri.https(_baseUrl, _pathUrl);
  }

  void _updatePath(String name) {
    final pattern = RegExp('\\s+');
    String parseName = name.toLowerCase().replaceAll(pattern, '-');;
    _pathUrl = "/api/urban_areas/slug:" + parseName + "/images/";
  }

  @override
  Future<CityThumbnail> getByCityName(String name) async {
    _updatePath(name);
    final response = await _service.get(_createUri(), _headers);
    return CityThumbnail.fromJson(response);
  }

}