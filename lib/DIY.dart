import 'package:cs_project_train/SearchedRoom.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 360,
                height: 650,
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
              )
            ],
          ),
        ),
      ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
