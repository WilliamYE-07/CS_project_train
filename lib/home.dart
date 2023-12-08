import 'package:cs_project_train/Login/login.dart';
import 'package:cs_project_train/Room/select_train.dart';
import 'package:cs_project_train/main.dart';
import 'package:cs_project_train/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs_project_train/self_design/self_design.dart';

import 'chats/chat_selector.dart';
import 'personal_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  Widget makeLargeButton(String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 130,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                goToPage(context, Settings());
              },
              icon: const Icon(Icons.settings)
          ),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                goToPage(context, LoginPage());
              },
              icon: const Icon(Icons.east)
          )
        ],
      ),
      body: ListView(
        children: [
          makeLargeButton(
              "Survey",
                  () {
                goToPage(context, PersonalInfoSelection());
              }
          ),
          makeLargeButton(
            "Train",
            () {
              goToPage(context, SelectTrain());
            }
          ),
          makeLargeButton(
              "Self Design",
                () {
                goToPage(context, SelfDesign());
              }
          ),
          makeLargeButton(
              "Chat Rooms",
                () {
                goToPage(context, ChatSelector());
              }
          ),
        ],
      ),
    );
  }
}
