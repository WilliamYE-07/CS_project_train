import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/SearchedRoom.dart';
import 'package:cs_project_train/authentication.dart';
import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';
import 'package:cs_project_train/CreateNew.dart';
class SelectTrain extends StatefulWidget {
  const SelectTrain({super.key, required this.title});

  final String title;

  @override
  State<SelectTrain> createState() => _SelectTState();
}

class _SelectTState extends State<SelectTrain> {
  int _counter = 0;
  List<Widget>Rooms = [];
  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  void TrainButton() {
    print("Hello, World!");
  }

  void refreshRooms() {
    FirebaseFirestore.instance.collection("Rooms").get().then((querySnapshot) {
      List<Widget> temprooms = [];
      for (var i in querySnapshot.docs) {
        i.data();

        setState(() {
          temprooms.add(PublicRoom(i.data()["groupname"], i.data()["members"][0], i.data()["number of members"] ));
          print("hello");
        });
        print(i.data()["groupname"]);
        print(i.data()["number of members"]);
        print(i.data()["members"]);
      }
      Rooms = temprooms;
    });

  }

  void SelfDesignButton() {
    print("Hello, World!");
  }

  void ChatRoomButton() {
    print("Hello, World!");
  }

  void Nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeatingPage(title: "Seating Page")),
    );
  }

  void SearchRoom() {
    print("search result");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchedRoom(title: "Search Result")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: (String newEntry) {
                print(newEntry);
              },
            ),
            Container(
              height:715,
              width: 300,
              child: ListView(
                children: Rooms,
              ),
            ),
          ],
        ),
      ),


       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
