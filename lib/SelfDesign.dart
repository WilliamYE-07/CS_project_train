import 'dart:collection';

import 'package:cs_project_train/SearchedRoom.dart';
import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';
import 'CreateNew.dart';
import 'DIY.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication.dart';


class SelfDesign extends StatefulWidget {
  const SelfDesign({super.key, required this.title});

  final String title;

  @override
  State<SelfDesign> createState() => _DesignState();
}

class _DesignState extends State<SelfDesign> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  AuthenticationHelper Auth = AuthenticationHelper();
  int _counter = 0;
  List<Widget> rooms = [];
  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  _DesignState() {
    refreshRooms();
  }


  void refreshRooms() {
    db.collection("users").doc(AuthenticationHelper().uid).collection("SelfDesignRoom").get().then((querySnapshot) {
      List<Widget> temprooms = [];
      for (var i in querySnapshot.docs) {
        i.data();

        setState(() {
          temprooms.add(selfDesignRoom(i.data()["groupname"], i.data()["members"][0], i.data()["number of members"] ));
          print("hello");
        });
        print(i.data()["groupname"]);
        print(i.data()["number of members"]);
        print(i.data()["members"]);
      }
      rooms = temprooms;
    });

  }


  void goDIY() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DIY(title: "Design It Yourself!")),
    );
  }
  void AddRoom() {
    Map<String, Object> newRoom = new HashMap<String, Object>();
    newRoom["groupname"] = "name";//.("groupname","name");
    newRoom["code"] = "10086";
    newRoom["members"] = ["Jack", "William"];
    newRoom["number of members"] = "14";
    FirebaseFirestore.instance.collection("users").doc(AuthenticationHelper().uid).collection("SelfDesignRoom").doc("newRoom1").set(newRoom);
    FirebaseFirestore.instance.collection("rooms").doc(newRoom["code"] as String?).set(newRoom);
    List<Widget> temprooms = rooms;
    setState(() {
      //temprooms.add();
      rooms = temprooms;
      print("hello");
    });
  }

  void TrainButton() {
    print("Hello, World!");
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

  void UpdateLV() {
    setState(() {

      rooms = rooms;
      print("hello");
    });
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

    UpdateLV();
    print(rooms);
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
              width: 500,
              child: ListView(
                  children: rooms



              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: AddRoom,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
