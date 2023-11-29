import 'package:cs_project_train/SelfDesign/DIY.dart';
import 'package:cs_project_train/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Login/authentication.dart';
import 'SelfDesignRoom.dart';


class SelfDesign extends StatefulWidget {
  const SelfDesign({super.key});

  @override
  State<SelfDesign> createState() => _DesignState();
}

class _DesignState extends State<SelfDesign> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Widget> rooms = [];

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() {
    return db.collection("users").doc(getUID()).collection("SelfDesignRoom").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Your Rooms"),
      ),
      body: ListView(
        children: [
          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child:CircularProgressIndicator()); // Display a loading indicator while waiting for data
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching data')); // Display an error message if data fetching fails
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available')); // Display a message if no data is available
              } else {
                rooms.clear();
                for (var i in snapshot.data!.docs) {
                  var data = i.data();
                  rooms.add(
                    SelfDesignRoom(
                      data["groupname"],
                      data["members"][0],
                      data["number of members"]
                    )
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        obscureText: false,
                        decoration: const InputDecoration(
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
        ]
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
