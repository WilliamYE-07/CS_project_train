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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Find a Train"),
      ),
      body: FutureBuilder(
        future: getRooms(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) { // Successfully loaded data
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? posts = snapshot.data;
            if (posts != null) {
              return ListView.builder( // Once posts are retrieved, generates ListView
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = posts[index].data();

                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SeatingPage(data))
                        );
                      },
                      child: Text(data['name'])
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
    );
  }
}
