import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Screens/CharactersList.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "\"Rick & Morty\" characters",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: filterBody(context),
    );
  }

  Widget filterBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        color: Colors.deepPurple,
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filterButton(context, "", "See all characters", Icons.all_inclusive),
            // GENDER FILTER SECTION
            Text("Gender",
              style: TextStyle(
                  fontFamily: "Pacifico", fontSize: 25, color: Colors.white),
              textAlign: TextAlign.left,
            ),
            const Divider(
              endIndent: 0,
              indent: 0,
              thickness: 1,
              color: Colors.white,
            ),
            filterButton(context, "/?gender=Female", "Female characters", Icons.male),
            filterButton(context, "/?gender=Male", "Male Characters", Icons.female),
            filterButton(context, "/?gender=genderless", "Genderless characters", Icons.block),
            filterButton(context, "/?gender=Unknown", "Characters with unknown gender", Icons.question_mark),
            // SPECIES FILTER SECTION
            Text("Species",
              style: TextStyle(
                  fontFamily: "Pacifico", fontSize: 25, color: Colors.white),
              textAlign: TextAlign.left,
            ),
            const Divider(
              endIndent: 0,
              indent: 0,
              thickness: 1,
              color: Colors.white,
            ),
            filterButton(context, "/?species=Human", "Human characters", Icons.person),
            filterButton(context, "/?species=Alien", "Alien Characters", Icons.rocket_launch),
            filterButton(context, "/?species=Robot", "Robot characters", Icons.electric_bolt),
            filterButton(context, "/?species=Animal", "Animal characters", Icons.pets),
            // STATUS FILTER SECTION
            Text("Status",
              style: TextStyle(
                  fontFamily: "Pacifico", fontSize: 25, color: Colors.white),
              textAlign: TextAlign.left,
            ),
            const Divider(
              endIndent: 0,
              indent: 0,
              thickness: 1,
              color: Colors.white,
            ),
            filterButton(context, "/?status=Alive", "Alive characters", Icons.health_and_safety),
            filterButton(context, "/?status=Dead", "Dead Characters", Icons.heart_broken_outlined),
            filterButton(context, "/?status=Unknown", "Characters with unknown status", Icons.question_mark),
            ],
        )));
  }

  Widget filterButton(BuildContext context, String urlFilter, String label, IconData icon) {
      return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CharactersList(
                              urlFilter
                            )
                    )
                );
              },
              child: ListTile(
                leading: Icon(icon),
                title: Text("${label}"),
              ),
            ),
          );
  }
}
