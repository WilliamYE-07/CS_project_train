import 'package:cs_project_train/main.dart';

import 'chat_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatAdder extends StatefulWidget {
  const ChatAdder({super.key});

  @override
  State<ChatAdder> createState() => _ChatAdderState();
}

class _ChatAdderState extends State<ChatAdder> {
  TextEditingController groupName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  String uidOfSearchedUser = "";
  List<Map<String, dynamic>> members = [];

  Future<Map<String, dynamic>?> _loadUser() async {
    final db = FirebaseFirestore.instance;
    return (await db.collection("users").doc(uidOfSearchedUser).get()).data();
  }

  Future<void> searchUser(String queryString) async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: queryString).get();
    if (query.docs.isEmpty) {
      setState(() {
        uidOfSearchedUser = "";
      });
    } else {
      QueryDocumentSnapshot result = query.docs[0];
      Map<String, dynamic> resultUser = result.data() as Map<String, dynamic>;
      setState(() {
        uidOfSearchedUser = query.docs[0].id;
      });
    }
  }

  Future<void> createInvites() async {
    String myUid = FirebaseAuth.instance.currentUser!.uid;

    List<String> memberUids = [];
    List<String> memberUidsWithOwner = [];
    for (Map<String, dynamic> entry in members) {
      print(entry);
      memberUids.add(entry['uid']);
      memberUidsWithOwner.add(entry['uid']);
    }
    memberUidsWithOwner.add(myUid);

    var chatDocRef = await FirebaseFirestore.instance.collection('chats').add(
      {
        'chat_name': groupName.text,
        'members': memberUidsWithOwner
      }
    );

    var createdInvite = await FirebaseFirestore.instance.collection('invites').add(
      {
        'sender': myUid,
        'chat_name': groupName.text,
        'recipients': memberUids,
        'members': memberUidsWithOwner,
        'chat_ref': chatDocRef
      }
    );

    var chatRef = await FirebaseFirestore.instance.collection('chat_keys').add(
      {
        'ref': chatDocRef,
        'user': myUid
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Chat Group"),
      ),
      body: Column(
        children: [
          TextField(
            obscureText: false,
            controller: groupName,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Group Name",
            ),
          ),
          TextField(
            obscureText: false,
            controller: email,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Search for a user's email here",
            ),
            onSubmitted: (value) {
              searchUser(value);
            },
          ),
          Container(
            child: FutureBuilder(
              future: _loadUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic>? userData = snapshot.data;
                  if (userData != null) { // Successfully loaded data
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${userData['name']}"),
                                Text("Email: ${userData['email']}"),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (!members.contains(userData)) {
                                    setState(() {
                                      members.add(userData);
                                    });
                                  }
                                },
                                child: Text("Add")
                            )
                          ],
                        ),
                      ),
                    );
                  } else { // Problem loading data
                    return const Text("Error loading data");
                  }
                } else { // Loading data
                  return const Text("No results.");
                }
              },
            ),
          ),
          Text("Group Members"),
          Expanded(
            child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${members[index]['name']}"),
                              Text("Email: ${members[index]['email']}"),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  members.removeAt(index);
                                });
                              },
                              child: Text("Add")
                          )
                        ],
                      ),
                    ),
                  );
                }
            )
          ),
          ElevatedButton(
              onPressed: () {
                createInvites().then((value) {
                  Navigator.of(context).pop();
                });
              },
              child: Text("Submit")
          )
        ],
      ),
    );
  }
}
