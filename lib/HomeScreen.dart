import 'package:cs_project_train/Room/SearchedRoom.dart';
import 'package:cs_project_train/Room/SelectTrain.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';
import 'package:cs_project_train/SelfDesign/SelfDesign.dart';
import 'package:cs_project_train/chats/ChatRooms.dart';

import 'chats/chat_selector.dart';
import 'form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  void TrainButton() {
    print("Hello, World!");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SelectTrain(title: "Select Your Train")),
    );
  }

  void SelfDesignButton() {
    print("Hello, World!");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SelfDesign(title: "Design Your Room")),
    );
  }

  void ChatRoomButton() {
    print("Hello, World!");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatSelector()),
    );
  }

  void Nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeatingPage("Seating Page", "1234")),
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
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PersonalInfoSelection()),
            );
          }, icon: Icon(Icons.person))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          TextField(
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Input Room Code',
            ),
            onChanged: (String newEntry) {
              print(newEntry);
            },
          ),
          ElevatedButton(onPressed: SearchRoom, child: Text("Search")),
          Center(
              child: Column(
            children: [
              GestureDetector(
                onTap: TrainButton,
                child: Container(
                    width: 300,
                    height: 130,
                    margin: EdgeInsets.all(20),
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
                    child: Column(children: [
                      Text(
                        "Train",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
                    ])),
              ),
              /*
            ElevatedButton(
                onPressed: SelfDesignButton, child: Text("Self Design")),

             */

              GestureDetector(
                onTap: SelfDesignButton,
                child: Container(
                    width: 300,
                    height: 130,
                    margin: EdgeInsets.all(20),
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
                    child: Column(children: [
                      Text(
                        "Self Design",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
                    ])),
              ),

              GestureDetector(
                onTap: ChatRoomButton,
                child: Container(
                    width: 300,
                    height: 130,
                    margin: EdgeInsets.all(20),
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
                    child: Column(children: [
                      Text(
                        "Chat Rooms",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
                    ])),
              ),
            ],
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: SearchRoom,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
