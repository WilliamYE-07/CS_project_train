import 'package:cs_project_train/Room/SearchedRoom.dart';
import 'package:cs_project_train/Room/SelectTrain.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';
import 'package:cs_project_train/SelfDesign/SelfDesign.dart';
import 'package:cs_project_train/chats/ChatRooms.dart';
import 'ChatPage.dart';


class ChatRooms extends StatefulWidget {
  const ChatRooms({super.key, required this.title});

  final String title;

  @override
  State<ChatRooms> createState() => _ChatState();
}

class _ChatState extends State<ChatRooms> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }


  void goToChatPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatPage(title: "Group Name")),
    );
  }



  void SearchRoom() {
    print("search result");
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
          title: Text(widget.title),
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){print("Hello, World!");}, child: Text("Search")),
            ),
            Container(
              height: 662,
              width: 500,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: goToChatPage,
                    child: Container(
                      height: 100,
                      width: 500,
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 20,
                              color: Colors.white70
                          ),
                          borderRadius: BorderRadius.circular(10),

                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 20
                            )
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("groupname")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Jack, William, Joe"),
                              SizedBox(
                                width: 185,
                              ),
                              Text("114514")
                            ],
                          )
                        ],
                      ),

                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );}}