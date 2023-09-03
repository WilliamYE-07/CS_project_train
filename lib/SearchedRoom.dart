import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

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


  void Nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SeatingPage(title: "Seating Page")),
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
      body: Column(

          children: [


          ]
      ),

    );
  }
}
