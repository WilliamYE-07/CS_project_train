import 'package:cs_project_train/Room/SearchedRoom.dart';
import 'package:cs_project_train/SelfDesign/questionare.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';

class DIY extends StatefulWidget {
  const DIY({super.key, required this.title});

  final String title;

  @override
  State<DIY> createState() => _DIYState();
}

class _DIYState extends State<DIY> {
  int _counter = 0;
  Map<String, List<int>> seatingChart = {
    "Row1" : [0,0,0],
    "Row2" : [0,0,0],
    "Row3" : [0,0,0],

  }; //Make 2d array and convert it
  //extend the table cell class to include an index

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

  bool isColor = false;
  bool isDragOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 360,
                height: 500,
                color: Colors.green,
                child: Table(
                  border: TableBorder.all(), // Add border to the table cells
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row1"]?[0] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row1"]?[1] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row1"]?[2] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row2"]?[0] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row2"]?[1] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row2"]?[2] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),

                    ]),
                    TableRow(children: [
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row3"]?[0] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row3"]?[1] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),
                      TableCell(
                          child: ElevatedButton(
                              onPressed: () {
                                seatingChart["Row3"]?[2] = 1;
                                print(seatingChart);
                              },
                              child: Text("Hello"))),

                    ]),
                  ],
                ),
              ),
              Container(
                width: 360,
                height: 100,
                color: Colors.amber,
                child: Draggable<String>(
                  data: 'MyData',
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(child: Text('Drag Me')),
                  ),
                  feedback: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue.withOpacity(0.7),
                    child: Center(child: Text('Dragging...')),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Questionnaire'),
                                content: QuestionnaireForm(
                                    seatingChart), // Display the form here
                              );
                            },
                          );
                        });
                      },
                      child: Text("Save")),
                  ElevatedButton(onPressed: () {}, child: Text("Formats")),
                ],
              ),
            ],
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
