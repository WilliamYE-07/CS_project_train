import 'dart:collection';

import 'package:cs_project_train/Room/SearchedRoom.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';
import '../CreateNew.dart';
import 'DIY.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Login/authentication.dart';


class SelfDesign extends StatefulWidget {
  const SelfDesign({super.key, required this.title});

  final String title;

  @override
  State<SelfDesign> createState() => _DesignState();
}

class _DesignState extends State<SelfDesign> {
  FirebaseFirestore db = FirebaseFirestore.instance;
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
    db.collection("users").doc(getUID()).collection(
        "SelfDesignRoom").get().then((querySnapshot) {
      List<Widget> temprooms = [];
      for (var i in querySnapshot.docs) {
        i.data();

        setState(() {
          temprooms.add(selfDesignRoom(
              i.data()["groupname"], i.data()["members"][0],
              i.data()["number of members"]));
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
    newRoom["groupname"] = "name"; //.("groupname","name");
    newRoom["code"] = "10086";
    newRoom["members"] = ["Jack", "William"];
    newRoom["number of members"] = "14";
    FirebaseFirestore.instance.collection("users").doc(
        getUID()).collection("SelfDesignRoom")
        .doc("newRoom1")
        .set(newRoom);
    FirebaseFirestore.instance.collection("rooms").doc(
        newRoom["code"] as String?).set(newRoom);
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
    print(rooms);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),

      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: fetchData(), // Call your fetchData function here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                  CircularProgressIndicator()); // Display a loading indicator while waiting for data
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                      'Error fetching data')); // Display an error message if data fetching fails
            } else if (!snapshot.hasData) {
              return Center(
                  child: Text(
                      'No data available')); // Display a message if no data is available
            } else {
              List<Widget> temprooms = [];
              for (var i in snapshot.data!.docs) {
                i.data();

                  temprooms.add(selfDesignRoom(
                      i.data()["groupname"], i.data()["members"][0],
                      i.data()["number of members"]));
              }
              rooms = temprooms;

              return Padding(
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
                      height: 715,
                      width: 500,
                      child: ListView(
                          children: rooms


                      ),
                    ),
                  ],
                ),
              );
            }
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: goDIY,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() {
    return db.collection("users").doc(getUID()).collection(
        "SelfDesignRoom").get();
  }
}
