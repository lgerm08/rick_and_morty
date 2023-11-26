import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:rick_and_morty_app/Screens/CharacterDetails.dart';
import '../Model/FilteredListModel.dart';

class CharactersList extends StatefulWidget {
  final String filter;
  const CharactersList(this.filter, {super.key});

  @override
  State<CharactersList> createState() => _CharactersList(filter);
}

class _CharactersList extends State<CharactersList> {

  String filter;
  String teste = "";
  String _resultado = "";
  String _searchValue = "";
  String _filter = "";
  List<dynamic> _globalCharacterList = [];
  final FilteredListModel filteredList = FilteredListModel();

  @visibleForTesting
  _CharactersList(this.filter);

  // Função para recuperar lista de personagens
  Future<Map> _getCharactersList() async {
    String url = "https://rickandmortyapi.com/api/character" + filter;
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> result = json.decode(response.body);
    String? nextPageUrl = result["info"]["next"];
    _globalCharacterList = result["results"];
    while ( nextPageUrl != null) {
      response = await http.get(Uri.parse(nextPageUrl));
      print("Downloading from ${nextPageUrl}");
      Map<String, dynamic> newPageResult = json.decode(response.body);
      _globalCharacterList += newPageResult["results"];
      nextPageUrl = newPageResult["info"]["next"];
      print("List has now ${_globalCharacterList.length} items");
    }
     filteredList.populateList(_globalCharacterList);
    return json.decode(response.body);
  }

  //Funçao para filtrar lista com pesquisa da searchBar
  void filterListWithSearchText(String search) {
    filteredList.filter(_globalCharacterList, search);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: _getCharactersList(),
        builder: (context, snapshot) {
              if ( snapshot.hasError ) {
                print("Error: ${snapshot.error}");
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.deepPurple,
                      iconTheme: IconThemeData(
                          color: Colors.white
                      ),
                      title: Text("Rick & Morty: Characters List",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                      ),),),
                      body: Container(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Error retrieving characters list."),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _getCharactersList();
                              }); } ,
                            child: const Card(color: Colors.deepPurple, child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh, color: Colors.white),
                                Text("Try again", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                              ],),),)
                        ]))));
              } else {
                return Scaffold(
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
                  body: scaffoldBody(snapshot, filteredList)
                );
              }
        },
      );
  }
}

Widget scaffoldBody(AsyncSnapshot<Map<dynamic, dynamic>> snapshot, FilteredListModel filteredList)  {
  switch(snapshot.connectionState) {
    case ConnectionState.none:
      return Center(child: CircularProgressIndicator(),);
    case ConnectionState.waiting:
      return Center(child: CircularProgressIndicator(),);
    case ConnectionState.active:
      return Center(child: CircularProgressIndicator(),);
    case ConnectionState.done:
        return CharacterListBody(listNotifier: filteredList);
  }
}

class CharacterListBody extends StatelessWidget {
  const CharacterListBody({super.key, required this.listNotifier});

  final FilteredListModel listNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListenableBuilder(
              listenable: listNotifier,
              builder: (BuildContext context, Widget? child) {
                final List<dynamic> values = listNotifier.filteredCharacters;
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) => listItem(index, listNotifier.filteredCharacters, context),
                  itemCount: values.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(int index, List<dynamic> filteredList, BuildContext context) {
    return Card(
                color: Colors.deepPurple,
                elevation: 6,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(radius: 30.0,
                    backgroundImage: NetworkImage("${filteredList[index]["image"]}"),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text("${filteredList[index]["name"]}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("${filteredList[index]["species"]}", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CharacterDetails(filteredList[index]["id"]
                                    .toString())
                        )
                    );
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                ));
  }
}

