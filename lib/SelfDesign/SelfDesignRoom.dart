import 'package:flutter/material.dart';

class SelfDesignRoom extends StatelessWidget {
  String groupname;
  String members;
  String number;

  SelfDesignRoom(this.groupname, this.members, this.number, {super.key});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => DIY(title: "Design It Yourself!")),
        // );
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