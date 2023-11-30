import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Login/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:http/http.dart' as http;

class SeatingPage extends StatefulWidget {
  const SeatingPage(this.data, {super.key});

  final Map<String, dynamic> data;

  @override
  State<SeatingPage> createState() => _SeatingState(data);
}

class _SeatingState extends State<SeatingPage> {
  List<List<dynamic>> gridData = [];
  Map<String, dynamic> data;

  _SeatingState(this.data) {
    Map<String, dynamic> rawChart = data['seating_chart'];
    for (int i = 0; i<rawChart.keys.length; i++) {
      gridData.add(rawChart[i.toString()]);
    }
  }

  Future<Map<String, dynamic>?> loadUser(String UID) async {
    return (await FirebaseFirestore.instance.collection("users").doc(UID).get()).data();
  }

  String getSitterUID(row, col) {
    Map<String, dynamic> memberList = data['members'];

    // is someone sitting there?
    for (String UID in memberList.keys) {
      int otherRow = memberList[UID][0];
      int otherCol = memberList[UID][1];

      // someone's already sitting here
      if (otherRow == row && otherCol == col) {
        return UID;
      }
    }
    return "";
  }

  Widget getUserSittingThere(int row, int col, String userSittingThere) {
    return FutureBuilder(
      future: loadUser(userSittingThere),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic>? userData = snapshot.data;
          if (userData != null) { // Successfully loaded data
            return ProfilePicture(
                name: userData['name'],
                radius: 31,
                fontsize: 21
            );
          } else { // Problem loading data
            return const Icon(Icons.error);
          }
        } else { // Loading data
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget getFreeSeatButton(row, col) {
    bool validSeat = gridData[row][col];

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
        backgroundColor: gridData[row][col] ? Colors.green : Colors.red,
      ),
      onPressed: validSeat? () {
        joinSeat(row, col).then((value) {
          setState(() {

          });
        });
      } : null,
      child: SizedBox.shrink()
    );
  }

  Future<void> joinSeat(int row, int col) async {
    DocumentReference roomRef = FirebaseFirestore.instance.collection("rooms").doc(data['code']);
    Map<String, dynamic> memberList = data['members'];

    // is someone sitting there?
    for (String UID in memberList.keys) {
      int otherRow = memberList[UID][0];
      int otherCol = memberList[UID][1];

      // someone's already sitting here
      if (otherRow == row && otherCol == col) {
        return;
      }
    }
    // no one is sitting there, safe to begin operation

    // if we're already sitting somewhere else, get up
    if (memberList.containsKey(getUID())) {
      memberList.remove(getUID());
    }

    // sit back down
    memberList.putIfAbsent(getUID(), () => [row, col]);

    await roomRef.update({
      "members": memberList
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.data['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 75,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridData[0].length, // Number of columns
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      // Calculate the row and column of the current index
                      int row = index ~/ gridData[0].length;
                      int col = index % gridData[0].length;

                      String userSittingThere = getSitterUID(row, col);
                      bool isSeatTaken = userSittingThere.isNotEmpty;

                      // Return a container for each item in the grid
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: isSeatTaken?
                            getUserSittingThere(row, col, userSittingThere) :
                            getFreeSeatButton(row, col)
                      );
                    },
                    itemCount: gridData.length * gridData[0].length,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }