import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';
import 'DIY.dart';

class selfDesignRoom extends StatelessWidget {
  String groupname = '';
  String members = '';
  String number = "";
  selfDesignRoom(this.groupname, this.members, this.number);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DIY(title: "Design It Yourself!")),
        );
      },
      child: Container(
        height: 100,
        width: 500,
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(groupname)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(members),
                SizedBox(
                  width: 185,
                ),
                Text(number as String),
              ],
            )
          ],
        ),

      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  String text = '';
  bool Who = true;
  ChatBubble(this.text, this.Who);
  Widget build(BuildContext context) {
    print(text + "From the chatbubble");
    if (Who == true){
      return Padding
        (
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            UnconstrainedBox(
              child: Container(
                height: 40,
                width: 100,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 20,
                      color: Colors.green
                  ),
                  borderRadius: BorderRadius.circular(10),

                  color: Colors.green,

                ),

              ),

            ),

          ],
        )
        ,
      );
    }
    else{
      return Padding
        (
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UnconstrainedBox(
              child: Container(
                height: 40,
                width: 100,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 20,
                      color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(10),

                  color: Colors.grey,

                ),
              ),
            ),
          ],
        )
        ,
      );
    }
  }
}

class PublicRoom extends StatelessWidget {
  String groupname = '';
  String members = '';
  String number = "";
  String id = "";
  PublicRoom(this.groupname, this.members, this.number, this.id);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SeatingPage(groupname, id)),
        );
      },
      child: Container(
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
              groupname,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
          ])),
    );
  }
}