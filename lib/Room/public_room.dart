import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';

class PublicRoom extends StatelessWidget {
  String groupname;
  String members;
  String number;
  String id;

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
            boxShadow: const [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 30
              )
            ]
        ),
        child: Column(
          children: [
            Text(
              groupname,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg", width: 30, height: 30,)
          ]
        )
      ),
    );
  }
}