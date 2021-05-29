import 'dart:async';

//SERVICE
import '../../../network/services.dart';
import '../../../network/api/api_response.dart';

//MODELS
import '../../models.dart';

class RegionProvider {
  GeoService _geoService;
  
  StreamController _regionListController;

  StreamSink<ApiResponse<List<Region>>> get regionListSink =>
    _regionListController.sink;

  Stream<ApiResponse<List<Region>>> get regionListStream =>
    _regionListController.stream;

  RegionProvider() {
    _regionListController = StreamController<ApiResponse<List<Region>>>();
    _geoService = GeoService();
  }

  fetchRegions(String countryId, int offset) async {
    regionListSink.add(ApiResponse.loading('Fetching Regions'));
    try {
      List<Region> regions = await _geoService.getRegionsByCountry(countryId, offset);
      regionListSink.add(ApiResponse.completed(regions));
    } catch (e) {
      regionListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _regionListController?.close();
  }
}