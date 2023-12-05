import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Login/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class Chat extends StatefulWidget {
  final DocumentReference docRef;

  const Chat({super.key, required this.docRef});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController message = TextEditingController();
  final db = FirebaseFirestore.instance;
  String myUid = FirebaseAuth.instance.currentUser!.uid;
  Map<String, Widget> userProfiles = {};

  Future<Map<String, dynamic>?> loadUser(String UID) async {
    return (await FirebaseFirestore.instance.collection("users").doc(UID).get()).data();
  }

  Widget getUserProfilePicture(String UID) {
    if (!userProfiles.containsKey(UID)) {
      return FutureBuilder(
        future: loadUser(UID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic>? userData = snapshot.data;
            if (userData != null) { // Successfully loaded data
              // Just save what the FutureBuilder loads
              userProfiles[UID] = Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfilePicture(
                    name: userData['name'],
                    radius: 31,
                    fontsize: 21
                ),
              );
              return userProfiles[UID]!;
            } else { // Problem loading data
              return const Icon(Icons.error);
            }
          } else { // Loading data
            return const CircularProgressIndicator();
          }
        },
      );
    }
    return userProfiles[UID]!;
  }

  Widget theirBubble(String UID, String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getUserProfilePicture(UID),
        ChatBubble(
          clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
          backGroundColor: Color(0xffE7E7ED),
          margin: EdgeInsets.only(top: 10),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget myBubble(String message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ChatBubble(
          clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 10),
          backGroundColor: Colors.blue,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        getUserProfilePicture(getUID()),
      ],
    );
  }

  ListView showMessages(Map<String, dynamic> chatData) {
    return ListView.builder( // Displays all group members
      itemCount: chatData['messages'].length,
      itemBuilder: (BuildContext context, int index) {
        return chatData['messages'][index]['sender'] == getUID()?
          myBubble(chatData['messages'][index]['message']) :
          theirBubble(chatData['messages'][index]['sender'], chatData['messages'][index]['message']);
      },
    );
  }

  Future<void> sendMessage() async {
    List messages = [];

    try {
      messages = ((await widget.docRef.get()).data() as Map<String, dynamic>)['messages'];
    } catch (exception) {
      print(exception.toString());
      //don't really need to do anything
    }

    messages.add(
      {
        'message': message.text,
        'sender': myUid,
        'time': DateTime.now().millisecondsSinceEpoch
      }
    );
    setState(() {
      message.clear();
      widget.docRef.update({
        'messages': messages
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: widget.docRef.get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic>? chatData = snapshot.data.data();
                  if (chatData != null) { // Successfully loaded data
                    if (chatData['messages'] == null) {
                      return Text("No messages.");
                    }
                    return showMessages(chatData);
                  } else { // Problem loading data
                    return const Text("Error loading data");
                  }
                } else { // Loading data
                  return const Text("loading...");
                }
              },
            )
          ),
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Chat something!",
                      ),
                      maxLines: null,
                      controller: message,
                      // onSubmitted: (value) {
                        // sendMessage();
                      // },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(Icons.send),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

}
