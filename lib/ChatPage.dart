  import 'package:cs_project_train/Room/SearchedRoom.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';
import 'CreateNew.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _counter = 0;

  String CurrentChat = '';
  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  void TrainButton() {
    print("Hello, World!");
  }

  void SelfDesignButton() {
    print("Hello, World!");
  }

  void ChatRoomButton() {
    print("Hello, World!");
  }



  void SearchRoom() {
    print("search result");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchedRoom(title: "Search Result")),
    );
  }
  double ContainerHeight = 0;
  List<Widget> Chat = [];


  @override
  Widget build(BuildContext context) {
    print("hello");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 30),
              height: 662 - ContainerHeight,
              width: 500,
              child: ListView(
                reverse: true,
                children: Chat.reversed.toList(),
              ),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '',
              ),
              onTap: (){
                setState(() {
                  ContainerHeight = 305;
                });
                print("Hello, World!");
              },

              onEditingComplete: (){
                print(CurrentChat);
                setState(() {
                  ContainerHeight = 0;
                  Chat.add(ChatBubble(
                      CurrentChat, false
                  )) ;
                });
                print("Hello, World!");
              },
              onChanged: (String newEntry) {
                print(newEntry);
                CurrentChat = newEntry;
              },
            ),

          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),


    );
  }
}
