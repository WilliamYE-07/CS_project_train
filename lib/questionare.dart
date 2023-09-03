import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

class QuestionnaireForm extends StatelessWidget {
  late final String classID;
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool mat = false;
  List<bool> _selectedOptions = [false, false, false]; // Modify this based on your questions
  String Title = "newRoom";
  String numberOfMembers = "";
  String Description = "";
  String members = "";

  QuestionnaireForm(this.classID);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            Text(
              'Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              onChanged: (String value) {
                Title = value;
              },

            ),
            SizedBox(height: 16),
            Text(
              'Number of members',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              onChanged: (String value) {
                numberOfMembers = value;
              },
            ),
            // Add more questions as needed
            SizedBox(height: 16),
            Text(
              'Members',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              onChanged: (String value) {
                members = value;
              },
                decoration: InputDecoration(
                  labelText: "Enter Names with spaces",

                )
            ),
              SizedBox(height: 16),
              Text(
                'Enter Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                  onChanged: (String value) {
                    Description = value;
                  },
                  decoration: InputDecoration(

                  )
              ),
            Center(
              child: ElevatedButton(
                onPressed: () {



                    Map<String, Object> newRoom = new HashMap<String, Object>();
                    newRoom["groupname"] = Title;//.("groupname","name");
                    var rnd = new Random();
                    int next = rnd.nextInt(1000000);
                    while (next < 100000) {
                      next *= 10;
                    }
                    newRoom["code"] = next.toString();
                    newRoom["number of members"] = numberOfMembers;
                    newRoom["members"] = members.split(" ");
                    newRoom["description"] = Description;
                    FirebaseFirestore.instance.collection("users").doc(AuthenticationHelper().uid).collection("SelfDesignRoom").doc(newRoom["groupname"] as String?).set(newRoom);
                    FirebaseFirestore.instance.collection("rooms").doc(newRoom["code"] as String?).set(newRoom);



                },
                child: Text('Submit'),
              ),
            ),
        ],
        ),
      ),
    );
  }
}
