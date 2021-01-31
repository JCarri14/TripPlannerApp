import 'package:trip_planner_app/repository/base_repository.dart';

import '../models/geo/city.dart';
import '../models/geo/region.dart';
import '../models/geo/geo.dart';
import './base_repository.dart';

abstract class GeoRepository {
  Future<List<dynamic>> getAll(GeoType type, int offset);
  Future<dynamic> getById(GeoType type, String id);
  Future<City> getCityByCoordinates(double latitude, double longitude);
  Future<List<Region>> getRegionsByCountry(String countryId, int offset);
  Future<List<City>> getCitiesByRegion(String countryId, String regionId, int offset);
}