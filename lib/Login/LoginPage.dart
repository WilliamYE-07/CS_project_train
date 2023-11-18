import 'package:cs_project_train/Login/SignUp.dart';
import 'package:cs_project_train/Room/seating_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../HomeScreen.dart';
import 'authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text
    ).then((result) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          onError.message,
          style: TextStyle(fontSize: 16),
        ),
      ));
    });
  }

  void Nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeatingPage("Seating Page", "1234")),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Login"),
      ),
      body: Padding(
        padding:const EdgeInsets.all(20),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              onChanged: (String newEntry) {
                setState(() {
                  email.text = newEntry;
                });
              },
            ),

            TextField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (String newEntry) {
                setState(() {
                  password.text = newEntry;
                });
              },
            ),
            ElevatedButton(onPressed: login, child: Text("Continue")),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp())
              );
            }, child: Text("Sign Up"))
          ]
        )
      )
    );
  }
}
