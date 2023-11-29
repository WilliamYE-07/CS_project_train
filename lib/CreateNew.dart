import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';
import 'SelfDesign/DIY.dart';

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