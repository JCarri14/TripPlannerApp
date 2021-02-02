import 'dart:async';

import '../api/api_response.dart';


class TextBloc {
  
  bool isEmpty;
  StreamController _cityListController;
  
  // Objecte que accepta events
  StreamSink<ApiResponse<List<String>>> get cityListSink =>
    _cityListController.sink;

  Stream<ApiResponse<List<String>>> get cityListStream =>
    _cityListController.stream;


  TextBloc() {
    _cityListController = StreamController<ApiResponse<List<String>>>();
    isEmpty = true;
  }

  fetchCities() async {
    print("Fetching cities");
    if (isEmpty)
      cityListSink.add(ApiResponse.loading('Fetching Cities'));
    try {
      List<String> cities = await _fetchData();
      isEmpty = cities.length > 0 ? false:true;
      cityListSink.add(ApiResponse.completed(cities));
    } catch (e) {
      cityListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  Future<List<String>> _fetchData() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(
      Duration(seconds: 1),
      () => ['Barcelona', 'Barcelona', 'Barcelona', 'Barcelona', 'Barcelona', 'Barcelona', 'Barcelona', 'Barcelona', 'Barcelona', 'Barcelona', 'Barcelona'],
    );

  dispose() {
    _cityListController?.close();
  }
}