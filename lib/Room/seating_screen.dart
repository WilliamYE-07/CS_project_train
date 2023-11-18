import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Login/authentication.dart';
import 'package:flutter/material.dart';

class SeatingPage extends StatefulWidget {
  const SeatingPage(this.title, this.id);

  final String id;
  final String title;

  @override
  State<SeatingPage> createState() => _SeatingState();
}

class _SeatingState extends State<SeatingPage> {
  Map<String, List<int>> seatingChart = {};
  FirebaseFirestore db = FirebaseFirestore.instance;
  Widget reccomendedSeats = Text("Example");

  _SeatingState() {
    db.collection("rooms").doc(widget.id).get().then((value) {
      for (var i in value.data()?["SeatingChart"].keys) {
        for (int x = 0; x < 3; x++) {
          seatingChart[i]?[x] = value.data()?["SeatingChart"][i][x] as int;
        }
      }
    });
    db.collection("rooms").doc(widget.id).collection("members").get().then((value) {
      for (var i in value.docs) {
        i["SeatNumber"];
        i.id;
        db.collection("users").doc(i.id);
      }
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchData() {
    return db.collection("rooms").doc(widget.id).get();
  }

  Map<String, Map<String, dynamic>> chooseRow(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot, String row, List<int> adjSeat) {
    Map<String, Map<String, dynamic>> seatingChartDictionary = {};

    if (row == "Row1") {
      seatingChartDictionary["SeatingChart"] = {
        "Row1": adjSeat,
        "Row2": snapshot.data!["SeatingChart"]["Row2"],
        "Row3": snapshot.data!["SeatingChart"]["Row3"]
      };
    }
    if (row == "Row2") {
      seatingChartDictionary["SeatingChart"] = {
        "Row1": snapshot.data!["SeatingChart"]["Row1"],
        "Row2": adjSeat,
        "Row3": snapshot.data!["SeatingChart"]["Row3"]
      };
    }
    if (row == "Row3") {
      seatingChartDictionary["SeatingChart"] = {
        "Row1": snapshot.data!["SeatingChart"]["Row1"],
        "Row2": snapshot.data!["SeatingChart"]["Row2"],
        "Row3": adjSeat
      };
    }
    return seatingChartDictionary;
  }


  Widget seatButton(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot, int seatNum, List<int> adjSeat, String row) {
    int seatCode = snapshot.data!["SeatingChart"][row][seatNum];

    if (seatCode == 1) {
      Map<String, Map<String, dynamic>> seatingChartDictionary = chooseRow(snapshot, row, adjSeat);

      return ElevatedButton(
        onPressed: () {
          setState(() {
            db.collection("rooms").doc(widget.id).update(
              {
                "SeatingChart": seatingChartDictionary["SeatingChart"]
              }
            );
            db.collection("rooms").doc(widget.id).collection("members").doc(getUID()).set(
              {
                "SeatNumber": [row, seatNum]
              }
            );
          });
        },
        child: const Text("Take Seat!"));
    }
    if (seatCode == 2) {
      return const Text("SeatTaken");
    }
    else {
      return const Text("No Seat");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: fetchData(), // Call your fetchData function here
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child:CircularProgressIndicator()); // Display a loading indicator while waiting for data
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching data')); // Display an error message if data fetching fails
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available')); // Display a message if no data is available
              } else {
                print(snapshot.data?["number of members"]);
                print(snapshot.data?["members"]);
                print(snapshot.data!?["SeatingChart"]);
                print(snapshot.data!["SeatingChart"]["Row1"][1]);

                return Table(
                  border: TableBorder.all(),
                  // Add border to the table cells
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            0,
                            [
                              2,
                              snapshot.data!["SeatingChart"]["Row1"][1],
                              snapshot.data!["SeatingChart"]["Row1"][2]
                            ],
                            "Row1"
                          )
                        )
                      ),
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            1,
                            [
                              snapshot.data!["SeatingChart"]["Row1"][0],
                              2,
                              snapshot.data!["SeatingChart"]["Row1"][2]
                            ],
                            "Row1"
                          )
                        )
                      ),
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            2,
                            [
                              snapshot.data!["SeatingChart"]["Row1"][0],
                              snapshot.data!["SeatingChart"]["Row1"][1],
                              2
                            ],
                            "Row1"
                          )
                        )
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            0,
                            [
                              2,
                              snapshot.data!["SeatingChart"]["Row2"][1],
                              snapshot.data!["SeatingChart"]["Row2"][2]
                            ],
                            "Row2"
                          )
                        )
                      ),
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            1,
                            [
                              snapshot.data!["SeatingChart"]["Row2"][0],
                              2,
                              snapshot.data!["SeatingChart"]["Row2"][2]
                            ],
                            "Row2"
                          )
                        )
                      ),
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            2,
                            [
                              snapshot.data!["SeatingChart"]["Row2"][0],
                              snapshot.data!["SeatingChart"]["Row2"][1],
                              2
                            ],
                            "Row2"
                          )
                        )
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            0,
                            [
                              2,
                              snapshot.data!["SeatingChart"]["Row3"][1],
                              snapshot.data!["SeatingChart"]["Row3"][2]
                            ],
                            "Row3"
                          )
                        )
                      ),
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            1,
                            [
                              snapshot.data!["SeatingChart"]["Row3"][0],
                              2,
                              snapshot.data!["SeatingChart"]["Row3"][2]
                            ],
                            "Row3"
                          )
                        )
                      ),
                      TableCell(
                        child: Container(
                          child: seatButton(
                            snapshot,
                            2,
                            [
                              snapshot.data!["SeatingChart"]["Row3"][0],
                              snapshot.data!["SeatingChart"]["Row3"][1],
                              2
                            ],
                            "Row3"
                          )
                        )
                      ),
                    ]
                  ),
                ],
              );
            }
          }
        )
      ),
    );
  }
}
