import 'package:cs_project_train/SelfDesign/diy.dart';
import 'package:cs_project_train/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Login/authentication.dart';

class SelfDesign extends StatefulWidget {
  const SelfDesign({super.key});

  @override
  State<SelfDesign> createState() => _DesignState();
}

class _DesignState extends State<SelfDesign> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Widget> rooms = [];

  Future<Map<String, dynamic>?> loadUser() async {
    final db = FirebaseFirestore.instance;
    return (await db.collection("users").doc(getUID()).get()).data();
  }

  Future<Map<String, dynamic>?> getRoom(String ID) async {
    final db = FirebaseFirestore.instance;
    return (await db.collection("rooms").doc(ID).get()).data();
  }

  Widget getRoomWidget(String ID) {
    return FutureBuilder(
      future: getRoom(ID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic>? roomData = snapshot.data;
          if (roomData != null) { // Successfully loaded data
            return ElevatedButton(
                onPressed: () {

                },
                child: Text(roomData['name'])
            );
          } else { // Problem loading data
            return const Text("Error loading data");
          }
        } else { // Loading data
          return const Text("loading...");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Your Rooms"),
      ),
      body: FutureBuilder(
        future: loadUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic>? userData = snapshot.data;
            if (userData != null) { // Successfully loaded data
              List<dynamic> roomIDs = userData["rooms"];

              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: roomIDs.length,
                  itemBuilder: (BuildContext context, int index) {
                    String path = roomIDs[index];
                    String ID = path.split("/")[1];
                    return getRoomWidget(ID);
                  }
              );
            } else { // Problem loading data
              return const Text("Error loading data");
            }
          } else { // Loading data
            return const Text("loading...");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToPage(context, DIY());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}