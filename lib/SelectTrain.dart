import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/SearchedRoom.dart';
import 'package:cs_project_train/authentication.dart';
import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';
import 'package:cs_project_train/CreateNew.dart';
class SelectTrain extends StatefulWidget {
  const SelectTrain({super.key, required this.title});

  final String title;

  @override
  State<SelectTrain> createState() => _SelectTState();
}

class _SelectTState extends State<SelectTrain> {
  int _counter = 0;
  List<Widget>Rooms = [];
  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  void TrainButton() {
    print("Hello, World!");
  }

  void refreshRooms() {
    FirebaseFirestore.instance.collection("rooms").get().then((querySnapshot) {
      List<Widget> temprooms = [];
      print("hello");

      for (var i in querySnapshot.docs) {
        i.data();

        setState(() {
          temprooms.add(PublicRoom(i.data()["groupname"], i.data()["members"][0], i.data()["number of members"], i.id));
          print("hello");
        });
        print(i.data()["groupname"]);
        print(i.data()["number of members"]);
        print(i.data()["members"]);
      }
      Rooms = temprooms;
    });

  }

  FirebaseFirestore db = FirebaseFirestore.instance;
  AuthenticationHelper Auth = AuthenticationHelper();

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() {
    return db.collection("rooms").get();
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
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: fetchData(), // Call your fetchData function here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                        CircularProgressIndicator()); // Display a loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Error fetching data')); // Display an error message if data fetching fails
                  } else if (!snapshot.hasData) {
                    return Center(
                        child: Text(
                            'No data available')); // Display a message if no data is available
                  } else {
                    List<Widget> temprooms = [];
                    for (var i in snapshot.data!.docs) {
                      i.data();

                      temprooms.add(PublicRoom(
                          i.data()["groupname"], i.data()["members"][0],
                          i.data()["number of members"], i.id));
                    }
                    Rooms = temprooms;

                    return Container(
                            height: 715,
                            width: 500,
                            child: ListView(
                                children: Rooms



                      ),
                    );
                  }
                }
            ),
          ],
        ),
      ),


       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
