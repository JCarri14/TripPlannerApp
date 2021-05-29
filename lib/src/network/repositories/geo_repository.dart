// MODELS
import "../../business_logic/models.dart";

// HELPERS
import "../../business_logic/helpers.dart";

abstract class GeoRepository {
  Future<List<dynamic>> getAll(GeoType type, int offset);
  Future<List<dynamic>> getByPrefix(GeoType type, String prefix, int offset);
  Future<dynamic> getById(GeoType type, String id);
  Future<City> getCityByCoordinates(double latitude, double longitude);
  Future<List<Region>> getRegionsByCountry(String countryId, int offset);
  Future<List<City>> getCitiesByRegion(String countryId, String regionId, int offset);
}