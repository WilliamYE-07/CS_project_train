import 'package:cs_project_train/SearchedRoom.dart';
import 'package:cs_project_train/questionare.dart';
import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';

class DIY extends StatefulWidget {
  const DIY({super.key, required this.title});

  final String title;

  @override
  State<DIY> createState() => _DIYState();
}

class _DIYState extends State<DIY> {
  int _counter = 0;
  Map<String, List<int>> seatingChart = {}; //Make 2d array and convert it
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
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
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
                    TableRow(
                        children: [
                          TableCell(child: Container(
                            height: 50,
                            width: 50,
                            child: DragTarget<String>(
                              builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                                print(candidateData);
                                print(rejectedData);
                                return Container(
                                  width: 100,
                                  height: 100,
                                  color: candidateData.isEmpty ? Colors.grey : Colors.green,
                                  child: Center(child: Text('Drop Here')),
                                );
                              },
                              onWillAccept: (data) {
                                isColor = true;
                                setState(() {
                                  isDragOver = true;
                                });
                                return true;
                              },
                              onAccept: (data) {
                                // Handle the dropped data here.
                              },
                              onLeave: (data) {
                                setState(() {
                                  isDragOver = false;
                                });
                              },
                            ),
                          )),

                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(child: Container(
                            height: 50,
                            width: 50,
                            child: DragTarget<String>(
                              builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  color: candidateData.isEmpty ? Colors.grey : Colors.green,
                                  child: Center(child: Text('Drop Here')),
                                );
                              },
                              onWillAccept: (data) {
                                setState(() {
                                  isDragOver = true;
                                });
                                return true;
                              },
                              onAccept: (data) {
                                // Handle the dropped data here.
                              },
                              onLeave: (data) {
                                setState(() {
                                  isDragOver = false;
                                });
                              },
                            ),
                          )),
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(child: Container(
                            height: 50,
                            width: 50,
                            child: DragTarget<String>(
                              builder: (BuildContext context, List<String?> candidates, List<dynamic> rejectedData) {
                                return candidates.length > 0
                                ? Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.green,
                                  child: Center(child: Text('Drop Here')) )
                                : Container(
                                width: 100,
                                height: 100,
                                    color: Colors.grey,
                                    child: Center(child: Text('Drop Here')),
                                );
                              },
                              onAccept: (data) {
                                // Handle the dropped data here.
                              },
                              onLeave: (data) {
                                setState(() {
                                  isDragOver = false;
                                });
                              },
                            ),
                          )),
                        ]
                    ),


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
                  ElevatedButton(onPressed: () {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Questionnaire'),
                            content: QuestionnaireForm("10"), // Display the form here
                          );
                        },
                      );
                    });
                  }, child: Text("Save")),
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
