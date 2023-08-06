import 'package:cs_project_train/SearchedRoom.dart';
import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';
import 'CreateNew.dart';
import 'DIY.dart';

class SelfDesign extends StatefulWidget {
  const SelfDesign({super.key, required this.title});

  final String title;

  @override
  State<SelfDesign> createState() => _DesignState();
}

class _DesignState extends State<SelfDesign> {
  int _counter = 0;
  List<Widget> rooms = [];
  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  void goDIY() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DIY(title: "Design It Yourself!")),
    );
  }
  void AddRoom() {
    List<Widget> temprooms = rooms;
    setState(() {
      temprooms.add(selfDesignRoom());
      rooms = temprooms;
      print("hello");
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

  void Nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeatingPage(title: "Seating Page")),
    );
  }

  void UpdateLV() {
    setState(() {

      rooms = rooms;
      print("hello");
    });
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
    UpdateLV();
    print(rooms);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: (String newEntry) {
                print(newEntry);
              },
            ),
            Container(
              height:715,
              width: 500,
              child: ListView(
                  children: rooms



              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: AddRoom,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
