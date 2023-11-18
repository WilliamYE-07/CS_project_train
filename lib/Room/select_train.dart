import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Room/SearchedRoom.dart';
import 'package:cs_project_train/Room/public_room.dart';
import 'package:flutter/material.dart';
class SelectTrain extends StatefulWidget {
  const SelectTrain({super.key});

  @override
  State<SelectTrain> createState() => _SelectTState();
}

class _SelectTState extends State<SelectTrain> {
  TextEditingController searchTrain = TextEditingController();
  List<Widget> rooms = [];

  void refreshRooms() {
    FirebaseFirestore.instance.collection("rooms").get().then((querySnapshot) {
      List<Widget> temprooms = [];
      print("hello");

      for (var i in querySnapshot.docs) {
        i.data();

        setState(() {
          temprooms.add(PublicRoom(i.data()["groupname"],
              i.data()["members"][0], i.data()["number of members"], i.id));
          print("hello");
        });
        print(i.data()["groupname"]);
        print(i.data()["number of members"]);
        print(i.data()["members"]);
      }
      rooms = temprooms;
    });
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() {
    return db.collection("rooms").get();
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Select Your Train"),
      ),
      body: ListView(
        children: [
          TextField(
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
            onChanged: (String newEntry) {
              searchTrain.text = newEntry;
            },
          ),
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: fetchData(), // Call your fetchData function here
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Display a loading indicator while waiting for data
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching data')); // Display an error message if data fetching fails
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available')); // Display a message if no data is available
              } else {
                List<Widget> temprooms = [];
                for (var i in snapshot.data!.docs) {
                  var data = i.data();

                  temprooms.add(
                    PublicRoom(
                      data["groupname"],
                      data["members"][0],
                      data["number of members"],
                      i.id
                    )
                  );
                }
                rooms = temprooms;

                return Container(
                  height: 715,
                  width: 500,
                  child: ListView(
                    children: rooms
                  ),
                );
              }
            }),
        ],
      ),
    );
  }
}
