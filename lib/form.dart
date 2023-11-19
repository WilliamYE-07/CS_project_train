
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Login/authentication.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class PersonalInfoSelection extends StatefulWidget {
  @override
  _PersonalInfoSelectionState createState() => _PersonalInfoSelectionState();
}

class _PersonalInfoSelectionState extends State<PersonalInfoSelection> {
  String selectedGender = "Male";
  String selectedCountry = "USA";
  String selectedColor = "Red";

  List<String> genders = ['Male', 'Female', 'Other'];
  List<String> countries = ['USA', 'Canada', 'UK', 'Australia', 'China', 'Other'];
  List<String> colors = ['Red', 'Green', 'Blue', 'Yellow', 'Other'];
  List<String> information = [];

  String city = "";
  String age = "";
  String color = "";
  String activites = "";
  String entertainments = "";
  String SchoolSubjects = "";
  String School = "";
  String Occupation = "";
  String Major = "";
  String highestDegree = "";




  void _showOptionsDialog(List<String> options, String currentValue, Function(String) onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            title: Text('Select an option'),
            content: SingleChildScrollView(
              child: Column(
                children: options.map((option) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSelect(option);
                      },
                      child: Text(option),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _showOptionsDialog(genders, selectedGender, (value) {
                    setState(() {
                      selectedGender = value;

                    });
                  });
                },
                child: Text('Select Gender: ${selectedGender ?? "Select Gender"}'),
              ),
              SizedBox(height: 16.0),

              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Country',

                ),
                onChanged: (String newEntry) {
                  selectedCountry = newEntry;
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',

                ),
                onChanged: (String newEntry) {
                  age = newEntry;
                },
              ),
              SizedBox(height: 16.0),

              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',

                ),
                onChanged: (String newEntry) {
                  city = newEntry;
                },
              ),
              SizedBox(height: 16.0),

              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Favorite Activites',

                ),
                onChanged: (String newEntry) {
                  activites = newEntry;
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Favorite Shows/Movies',

                ),
                onChanged: (String newEntry) {
                  entertainments = newEntry;
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Favorite School Subjects',

                ),
                onChanged: (String newEntry) {
                  SchoolSubjects = newEntry;

                },
              ),
              SizedBox(height: 16.0),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'School',

                ),
                onChanged: (String newEntry) {
                  School = newEntry;
                },
              ),
              SizedBox(height: 16.0),

              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Highest Degree',

                ),
                onChanged: (String newEntry) {
                  highestDegree = newEntry;
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Occupation',

                ),
                onChanged: (String newEntry) {
                    Occupation = newEntry;
                  },
              ),
              SizedBox(height: 16.0),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Major',

                ),
                onChanged: (String newEntry) {
                  Major = newEntry;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // You can process the selected values here
                  information.add(Major);
                  information.add(selectedGender);
                  information.add(selectedColor);
                  information.add(selectedCountry);
                  information.add(city);
                  information.add(entertainments);
                  information.add(SchoolSubjects);
                  information.add(School);
                  information.add(Occupation);
                  information.add(Major);
                  information.add(age);
                  information.add(highestDegree);

                  db.collection("users").doc(getUID()).set({"information": information});
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );




                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
