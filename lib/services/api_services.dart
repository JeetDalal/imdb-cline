import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'covid_api.dart';

class ApiServices {
  Future getData() async {
    final params = {'country': 'India'};
    var uri = Uri.https(
      'covid-193.p.rapidapi.com',
      '/statistics',
    );
    try {
      var response = await http.get(
        uri,
        headers: {
          'X-RapidAPI-Key':
              'a192f4262cmsh89abb5dd60d6b41p14535bjsncca5d519d7e6',
        },
      );
      if (response.statusCode == 200) {
        print('Good to go');
        var data = jsonDecode(response.body);
        List responseList = [];
        for (Map<String, dynamic> i in data['response']) {
          responseList.add(Response.fromJson(i));
        }
        log(responseList.toString());
        return responseList;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
