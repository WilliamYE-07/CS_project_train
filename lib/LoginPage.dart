import 'package:cs_project_train/SignUp.dart';
import 'package:cs_project_train/seating_screen.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  int _counter = 0;
  String username = "";
  String password = "";
  void _incrementCounter() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  void login() {
    print("you are logged in!");
    AuthenticationHelper()
        .signIn(email: username, password: password!)
        .then((result) {
      if (result == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(title: "Hello, $username")),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
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
      body: Padding(
        padding:const EdgeInsets.all(20),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',

              ),
              onChanged: (String newEntry) {
                username = newEntry;
                print("Username was changed to $newEntry");
              },
            ),

            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',

              ),
              onChanged: (String newEntry) {
                password = newEntry;
                print(newEntry);
              },
            ),
            ElevatedButton(onPressed: login, child: Text("Continue")),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp(title: "Hello, $username")),
              );
            }, child: Text("sign up"))
          ]
        )
      )
    );
  }
}
