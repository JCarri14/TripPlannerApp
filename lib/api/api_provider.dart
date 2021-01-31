import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'net_exception.dart';

class ApiProvider {
  
  Future<dynamic> get(dynamic uri, Map<String,String> headers) async {
      var responseJson;
      try {
        final response = await http.get(uri, headers: headers);
        responseJson = _returnResponse(response);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
    
  }
}