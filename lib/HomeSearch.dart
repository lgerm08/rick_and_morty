import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:easy_search_bar/easy_search_bar.dart';

import 'package:rick_and_morty_app/CharacterDetails.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {

  String _resultado = "";
  String _searchValue = "";
  int _listSize = 0;
  List<dynamic> _globalCharacterList = [];
  List<dynamic> _auxiliarList = [];
  List<String> _searchSuggestions = [];

  _getCharactersList() async {
    String url = "https://rickandmortyapi.com/api/character";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> result = json.decode(response.body);
    _globalCharacterList = result["results"];
    _auxiliarList = _globalCharacterList;
    _searchSuggestions = [];
    return json.decode(response.body);
  }

  void filterListWithSearchText(String search) {
    setState(() {
      _auxiliarList = _globalCharacterList.where((element) =>
          element["name"].toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _getCharactersList();
    });
  }
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
                appBar: EasySearchBar(
                  iconTheme: IconThemeData(
                    color: Colors.white
                  ),
                  title: Text(
                      "Rick & Morty: Characters List",
                    style: TextStyle(
                        color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onSearch: (value) =>
                  {
                    filterListWithSearchText(value)
                  },
                  backgroundColor: Colors.deepPurpleAccent
                ),
                body: _globalCharacterList.isEmpty ? Container(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Falha ao recuperar lista de personagens."),
                          TextButton(
                            onPressed: () { setState(() {
                            _getCharactersList();
                          }); } ,
                          child: Card(color: Colors.deepPurple, child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh, color: Colors.white),
                              Text("Tentar novamente", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                            ],),),)
                ]))) : Container(
                  color: Colors.white,
                  child: ListView.builder(
                  itemCount: _auxiliarList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.deepPurple,
                      elevation: 6,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                      leading: CircleAvatar(radius: 30.0,
                        backgroundImage: NetworkImage("${_auxiliarList[index]["image"]}"),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text("${_auxiliarList[index]["name"]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text("${_auxiliarList[index]["species"]}", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CharacterDetails(_auxiliarList[index]["id"]
                                        .toString())
                            )
                        );
                      },
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                    ));
                  },
                )),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _getCharactersList();
              });
            },
          ),
            ));
  }
}



