import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  void Nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeatingPage(title: "Seating Page")),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Icon (
            Icons.train_sharp,
            color: Colors.amber,
            size: 55.0,
          ),TextButton(onPressed: Nextpage, child: Text("。。。"))
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Nextpage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
