import '../models/geo/city.dart';
import '../models/geo/region.dart';
import '../models/geo/geoResponse.dart';

abstract class CityThumbnailRepository {
  Future<dynamic> getByCityName(String name);
}