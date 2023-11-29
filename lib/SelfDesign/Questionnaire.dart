import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/SelfDesign/SelfDesign.dart';
import 'package:cs_project_train/main.dart';
import 'package:flutter/material.dart';

import '../Login/authentication.dart';

class QuestionnaireForm extends StatelessWidget {
  late final String classID;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String title = "";
  int numberOfMembers = 0;
  String description = "";
  List<List<bool>> gridData = [];

  QuestionnaireForm(this.gridData);

  String getRoomCode() {
    var rnd = new Random();
    int next = rnd.nextInt(1000000);
    while (next < 100000) {
      next *= 10;
    }
    return next.toString();
  }

  HashMap<String, List<bool>> convertGridToSeatingChart() {
    HashMap<String, List<bool>> seatingChart = HashMap<String, List<bool>>();
    for (int i = 0; i < gridData.length; i++) {
      seatingChart.putIfAbsent(i.toString(), () => gridData[i]);
    }
    return seatingChart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Info"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children:[
              const Text(
                'Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (String value) {
                  title = value;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (String value) {
                  description = value;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Max Number of Members',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (String value) {
                  numberOfMembers = int.parse(value);
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                      Map<String, Object> newRoom = HashMap<String, Object>();

                      String code = getRoomCode();
                      newRoom["name"] = title;
                      newRoom["creator"] = getUID();
                      newRoom["code"] = code;
                      newRoom["member_cap"] = numberOfMembers;
                      newRoom["members"] = [];
                      newRoom["description"] = description;
                      newRoom["seating_chart"] = convertGridToSeatingChart();

                      print("Data ready");
                      DocumentReference roomRef = FirebaseFirestore.instance.collection("rooms").doc(code);
                      roomRef.set(newRoom); //this one has some error

                      print("Room made");
                      DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(getUID());
                      userRef.get().then((DocumentSnapshot doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          List roomList = [];
                          if (data.containsKey("rooms")) {
                            roomList = data["rooms"];
                          }
                          roomList.add(roomRef.path);
                          userRef.update({
                            "rooms": roomList
                          });
                        },
                        onError: (e) => print("Error getting document: $e"),
                      );

                      goToPage(context, SelfDesign());
                  },
                  child: Text('Submit'),
                ),
              ),
          ],
          ),
        ),
      ),
    );
  }
}
