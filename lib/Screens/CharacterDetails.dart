import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:rick_and_morty_app/Screens/CharacterDetails.dart';
import 'package:rick_and_morty_app/Icons/dna_icon_icons.dart';

class CharacterDetails extends StatefulWidget {
  final String characterId;
  const CharacterDetails(this.characterId, {super.key});
  @override
  State<CharacterDetails> createState() => _CharacterDetailsState(characterId);
}

class _CharacterDetailsState extends State<CharacterDetails> {

  String characterId;
  Map<String, dynamic> _characterDetails = {};
  _CharacterDetailsState(this.characterId);

  Future<Map> _getCharactersDetails() async {
    String url = "https://rickandmortyapi.com/api/character/" + characterId;
    http.Response response = await http.get(Uri.parse(url));
    _characterDetails = json.decode(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          title: Text(
            "Details",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: FutureBuilder<Map>(
          future: _getCharactersDetails(),
          builder: (context, snapshot) {
            String resultado;
            switch(snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if ( snapshot.hasError ) {
                  print(snapshot.error);
                  return Container(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Error retrieving character details."),
                            TextButton(
                              onPressed: () { setState(() {
                                _getCharactersDetails();
                              }); } ,
                              child: const Card(
                                color: Colors.deepPurple,
                                child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        Icon(Icons.refresh, color: Colors.white),
                                        Text("Try again", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                ],),),)
                          ])));
                } else {
                  return Container(
                  color: Colors.deepPurple,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${_characterDetails["image"]}"
                        ),
                        radius: 100,
                      ),
                      Text(
                        "${_characterDetails["name"]}",
                        style: TextStyle(
                            fontFamily: "Pacifico", fontSize: 30, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Origin: ${_characterDetails["origin"]["name"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SourceSansPro",
                          letterSpacing: 2,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        endIndent: 20,
                        indent: 20,
                        thickness: 1,
                        color: Colors.white,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: ListTile(
                          leading: Icon(
                              _characterDetails["gender"] == "Male" ? Icons.male :
                              _characterDetails["gender"] == "Female" ? Icons.female :
                              Icons.question_mark,
                              color: Colors.deepPurple,
                          ),
                          title: Text("Gender: ${_characterDetails["gender"]}"),
                        ),
                      ),
                      Card(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: ListTile(
                            leading: Icon(
                              DnaIcon.dna_icon,
                              color: Colors.deepPurple,
                            ),
                            title: Text("Species: ${_characterDetails["species"]}"),
                          )),
                      Card(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.deepPurple,
                            ),
                            title: Text("Current location: ${_characterDetails["location"]["name"]}"),
                          ))
                    ],
                  ));
                }
            }
          },
        )
    );
  }
}


