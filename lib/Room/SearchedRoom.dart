import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:flutter/material.dart';

import '../Login/authentication.dart';

class SearchedRoom extends StatefulWidget {
  const SearchedRoom({super.key, required this.title});

  final String title;

  @override
  State<SearchedRoom> createState() => _SearchedState();
}

class _SearchedState extends State<SearchedRoom> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
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
      body: Column(

          children: [


          ]
      ),

    );
  }
}
