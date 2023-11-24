import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:easy_search_bar/easy_search_bar.dart';

import 'package:rick_and_morty_app/CharacterDetails.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "";
  String _searchValue = "";
  int _listSize = 0;
  List<dynamic> _globalCharacterList = [];
  List<dynamic> _auxiliarList = [];
  List<String> _searchSuggestions = [];

  Future<Map> _getCharactersList() async {
    String url = "https://rickandmortyapi.com/api/character";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> result = json.decode(response.body);
    _globalCharacterList = result["results"];
     _auxiliarList = _globalCharacterList;
    _searchSuggestions = [];
    for (var character in _globalCharacterList) {
      _searchSuggestions.add(character["name"]);
    };
    return json.decode(response.body);
  }

  void filterListWithSearchText(String search) {
    setState(() {
      _auxiliarList = _globalCharacterList.where((element) => element["name"].toLowerCase().contains(search.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: _getCharactersList(),
        builder: (context, snapshot) {
          String resultado;
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return Text("None");
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return Text("Conexão ativa");
            case ConnectionState.done:
              if ( snapshot.hasError ) {
                print("aki");
                print(snapshot.error);
                return Center(
                  child: TextButton(
                    onPressed: () {
                      _getCharactersList();
                    },
                    child: Text("Erro ao requisitar"),
                  ),
                );
              } else {
                return Scaffold(
                  appBar: EasySearchBar(
                    title: Text("Rick & Morty: Characters List"),
                    onSearch: (value) => {
                      filterListWithSearchText(value)
                    },
                    suggestions: _searchSuggestions,
                  ),
                  body:ListView.builder(
                    itemCount: _auxiliarList.length,
                    itemBuilder: (context, index){

                      return ListTile(
                        leading: SizedBox(
                            height: 100.0,
                            width: 100.0, // fixed width and height
                            child: Image.network("${_auxiliarList[index]["image"]}")
                        ),
                        title: Text("${_auxiliarList[index]["name"]}"),
                        subtitle: Text("${_auxiliarList[index]["species"]}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CharacterDetails(_auxiliarList[index]["id"].toString())
                              )
                          );
                        },
                      );
                    },
                  )
                );
              }
          }
        },
      );
  }
}


