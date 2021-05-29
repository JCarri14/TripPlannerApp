import 'dart:async';

//HELPERS
import '../../helpers.dart';

//SERVICE
import '../../../network/services.dart';
import '../../../network/api/api_response.dart';

//MODELS
import '../../models.dart';

class CountryProvider {
  GeoService _geoService;

  StreamController _countryListController;

  StreamSink<ApiResponse<List<Country>>> get countryListSink =>
    _countryListController.sink;

  Stream<ApiResponse<List<Country>>> get countryListStream =>
    _countryListController.stream;

  CountryProvider() {
    _countryListController = StreamController<ApiResponse<List<Country>>>();
    _geoService = GeoService();
  }

  fetchCountries(int offset) async {
    countryListSink.add(ApiResponse.loading('Fetching Countries'));
    try {
      List<Country> countries = await _geoService.getAll(GeoType.COUNTRY, offset);
      countryListSink.add(ApiResponse.completed(countries));
    } catch (e) {
      countryListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _countryListController?.close();
  }
}