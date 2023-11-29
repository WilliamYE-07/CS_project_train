import 'package:cs_project_train/Room/SearchedRoom.dart';
import 'package:cs_project_train/Room/select_train.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:cs_project_train/main.dart';
import 'package:flutter/material.dart';
import 'package:cs_project_train/SelfDesign/SelfDesign.dart';
import 'package:cs_project_train/chats/ChatRooms.dart';

import 'chats/chat_selector.dart';
import 'form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  TextEditingController entryCode = new TextEditingController();

  Widget makeLargeButton(String label, String imageURL, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 130,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 20, color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 30)
          ]
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            Image.network(
              imageURL,
              width: 50,
              height: 50,
            )
          ]
        )
      ),
    );
  }

  void TrainButton() {
    goToPage(context, SelectTrain());
  }

  void SelfDesignButton() {
    goToPage(context, SelfDesign());
  }

  void ChatRoomButton() {
    goToPage(context, ChatSelector());
  }

  void SearchRoom() {
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
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PersonalInfoSelection()),
                );
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: ListView(
        children: [
          TextField(
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Input Room Code',
            ),
            onChanged: (String newEntry) {
              setState(() {
                entryCode.text = newEntry;
              });
            },
          ),
          ElevatedButton(onPressed: SearchRoom, child: Text("Search")),
          makeLargeButton(
            "Train",
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg",
            TrainButton
          ),
          makeLargeButton(
              "Self Design",
              "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg",
              SelfDesignButton
          ),
          makeLargeButton(
              "Chat Rooms",
              "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg",
              ChatRoomButton
          ),
        ],
      ),
    );
  }
}
