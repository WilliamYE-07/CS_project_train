import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:cs_project_train/main.dart';
import 'package:flutter/material.dart';

class SelectTrain extends StatefulWidget {
  const SelectTrain({super.key});

  @override
  State<SelectTrain> createState() => _SelectTState();
}

class _SelectTState extends State<SelectTrain> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Widget> rooms = [];

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getRooms() async {
    return (await FirebaseFirestore.instance.collection("rooms").get()).docs;
  }

  Future<Map<String, dynamic>?> searchRoom(String code) async {
    DocumentReference docRef = FirebaseFirestore.instance.collection("rooms").doc(code);
    DocumentSnapshot doc = await docRef.get();
    if (!doc.exists) {
      return null;
    } else {
      return doc.data() as Map<String, dynamic>;
    }
  }

  void goToSeatScreen(BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SeatingPage(data))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Find a Train"),
      ),
      body: Column(
        children: [
          TextField(
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Input Room Code',
            ),
            onSubmitted: (String newEntry) {
              searchRoom(newEntry).then((data) {
                if (data == null) {
                  // show some dialog and say no
                } else {
                  goToSeatScreen(context, data);
                }
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: getRooms(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) { // Successfully loaded data
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? posts = snapshot.data;
                  if (posts != null) {
                    return ListView.builder( // Once posts are retrieved, generates ListView
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = posts[index].data();

                        return GestureDetector(
                          onTap: () {
                            goToSeatScreen(context, data);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              child: Column(
                                children: [
                                  Text(data['name']),
                                  Text(data['code']),
                                  Text(data['description']),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else { // Problem loading data
                    return const Text("Error loading data");
                  }
                } else { // Loading data
                  return const Text("loading...");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
