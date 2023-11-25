import 'package:flutter/material.dart';

class FilteredListModel with ChangeNotifier {// O(N), makes a new copy each time.
  List<dynamic> filteredCharacters = [];

  void filter(List<dynamic> originalList, String search) {
    filteredCharacters =  originalList.where((element) => element["name"].toLowerCase().contains(search.toLowerCase())).toList();
    notifyListeners();
  }

  void populateList(List<dynamic> originalList) {
    filteredCharacters = originalList;
  }
}