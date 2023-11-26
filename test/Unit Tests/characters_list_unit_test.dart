import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

void main() {
  test("", () async {
    String url = "https://rickandmortyapi.com/api/character";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> result = json.decode(response.body);
    String? nextPageUrl = result["info"]["next"];
    List<dynamic> _globalCharacterList = result["results"];
    while ( nextPageUrl != null) {
      response = await http.get(Uri.parse(nextPageUrl));
      Map<String, dynamic> newPageResult = json.decode(response.body);
      _globalCharacterList += newPageResult["results"];
      nextPageUrl = newPageResult["info"]["next"];
    }
    //826 is number of characters currently available on the API, according to the documentation
    expect(_globalCharacterList.length, 826);
  });
}
