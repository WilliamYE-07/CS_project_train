import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Login/authentication.dart';
import 'package:cs_project_train/Login/login.dart';
import 'package:cs_project_train/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text
    ).then((result) {
      deleteAccount().then((value) {
        goToPage(context, LoginPage());
      });
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Incorrect email or password.",
          style: TextStyle(fontSize: 16),
        ),
      ));
    });
  }

  Future<void> deleteAccount() async {
    // 1. Change Firebase user doc to obscure identity
    // we don't delete their actual user document
    await FirebaseFirestore.instance.collection("users").doc(getUID()).set({
      "email": "deleted@seatsavvy.com",
      "name": "Deleted User",
      "information": []
    });

    // 2. Delete their Firebase account
    FirebaseAuth.instance.currentUser!.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "If you would like to delete your account, please enter your credentials again.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              onChanged: (String newEntry) {
                setState(() {
                  email.text = newEntry;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (String newEntry) {
                setState(() {
                  password.text = newEntry;
                });
              },
            ),
          ),
          GestureDetector(
            onLongPressUp: () {
              login();
            },
            child: Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Delete My Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
