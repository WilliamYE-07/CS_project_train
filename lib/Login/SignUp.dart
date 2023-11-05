import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';
import '../HomeScreen.dart';
import 'authentication.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.title});

  final String title;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _counter = 0;
  String username = "";
  String password = "";
  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }
  final db = FirebaseFirestore.instance;

  void login() {
    print("you are logged in!");
    AuthenticationHelper()
        .signUp(email: username, password: password!)
        .then((result) {
      if (result == null) {


        Map<String, Object> data = new HashMap<String, Object>() as Map<String, Object>;
        data = {
          "email" :username,
          "name" :username,
          "uid": AuthenticationHelper().uid
        };
        FirebaseFirestore.instance.collection("users").doc(AuthenticationHelper().uid).set(data);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(title: "Hello, $username")),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),

        ),
        body: Padding(
            padding:const EdgeInsets.all(20),
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',

                    ),
                    onChanged: (String newEntry) {
                      username = newEntry;
                      print("Username was changed to $newEntry");
                    },
                  ),

                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',

                    ),
                    onChanged: (String newEntry) {
                      password = newEntry;
                      print(newEntry);
                    },
                  ),
                  ElevatedButton(onPressed: login, child: Text("Continue")),

                ]
            )
        )
    );
  }
}
