import 'package:cs_project_train/SearchedRoom.dart';
import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';

class SelectTrain extends StatefulWidget {
  const SelectTrain({super.key, required this.title});

  final String title;

  @override
  State<SelectTrain> createState() => _SelectTState();
}

class _SelectTState extends State<SelectTrain> {
  int _counter = 0;

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

  void Nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeatingPage(title: "Seating Page")),
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
              width: 300,
              child: ListView(
                children: [Container(
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
                        "G1",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
                    ])),Container(
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
                        "G1",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
                    ])),Container(
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
                        "G1",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
                    ])),Container(
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
                        "G1",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
                    ])),Container(
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
                        "G1",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
                    ]))]
              ),
            ),
          ],
        ),
      ),


       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
