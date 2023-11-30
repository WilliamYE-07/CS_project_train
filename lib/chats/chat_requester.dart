import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRequester extends StatefulWidget {
  const ChatRequester({super.key});

  @override
  State<ChatRequester> createState() => _ChatRequesterState();
}

class _ChatRequesterState extends State<ChatRequester> {
  final db = FirebaseFirestore.instance;
  String myUid = FirebaseAuth.instance.currentUser!.uid;

  Future<Map<String, dynamic>?> _loadUser(uid) async {
    final db = FirebaseFirestore.instance;
    return (await db.collection("users").doc(uid).get()).data();
  }

  Widget memberDisplay(QueryDocumentSnapshot<Map<String, dynamic>> chatGroup) {
    return ListView.builder( // Displays all group members
      shrinkWrap: true,
      itemCount: chatGroup['members'].length,
      itemBuilder: (BuildContext context, int memberIndex) {
        return FutureBuilder(
          future: _loadUser(chatGroup['members'][memberIndex]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic>? userData = snapshot.data;
              if (userData != null) { // Successfully loaded data
                return Text(userData['name']);
              } else { // Problem loading data
                return const Text("Error loading data");
              }
            } else { // Loading data
              return const Text("loading...");
            }
          },
        );
      },
    );
  }

  Future<void> _acceptInvite(QueryDocumentSnapshot<Map<String, dynamic>> inviteDoc) async {
    var chatRef = await db.collection('chat_keys').add(
        {
          'ref': inviteDoc['chat_ref'],
          'user': myUid
        }
    );

    var recipientCopy = List.from(inviteDoc['recipients']);
    recipientCopy.remove(myUid);
    db.collection('invites').doc(inviteDoc.id).update({
      'recipients': recipientCopy
    });
  }

  Future<void> _declineInvite(QueryDocumentSnapshot<Map<String, dynamic>> inviteDoc) async {
    var recipientCopy = List.from(inviteDoc['recipients']);
    recipientCopy.remove(myUid);
    db.collection('invites').doc(inviteDoc.id).update({
      'recipients': recipientCopy
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Requester"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db.collection('invites').where('recipients', arrayContains: myUid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) { // Successfully loaded data
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? invites = snapshot.data.docs;
                    if (invites != null) {
                    return ListView.builder( // Once posts are retrieved, generates ListView
                      itemCount: invites.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  invites[index]['chat_name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                memberDisplay(invites[index]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _acceptInvite(invites[index]);
                                          });
                                        },
                                        child: Text("Accept")
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _declineInvite(invites[index]);
                                          });
                                        },
                                        child: Text("Decline")
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else { // Problem loading data
                    return const Text("Error loading data");
                  }
                } else { // Loading data
                  return const Text("Loading...");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
