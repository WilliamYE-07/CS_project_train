
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
  String highestEducation = "High School";

  List<String> genders = ['Male', 'Female', 'Other'];
  List<String> countries = ['USA', 'Canada', 'UK', 'Australia', 'China', 'Other'];
  List<String> education = ['High School', 'Associates', 'Bachelors', 'Masters', 'Doctorates'];
  List<String> information = [];

  String city = "";
  String age = "";
  String color = "";
  String activities = "";
  String entertainments = "";
  String schoolSubjects = "";
  String school = "";
  String occupation = "";
  String major = "";

  void showOptionsDialog(List<String> options, String currentValue, Function(String) onSelect) {
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

  Widget selectionButton(String label, List<String> options, String variable, Function(String) onSelect) {
    return ElevatedButton(
      onPressed: () {
        showOptionsDialog(options, variable, onSelect);
      },
      child: Text('${label}: ${variable}'),
    );
  }

  Widget getTextEntry(String label, String variable, Function(String) onSelect) {
    return TextField(
      obscureText: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      onChanged: onSelect,
    );
  }

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
              selectionButton("Gender", genders, selectedGender, (value) {
                setState(() {
                  selectedGender = value;
                });
              }),
              selectionButton("Country", countries, selectedCountry, (value) {
                setState(() {
                  selectedCountry = value;
                });
              }),
              getTextEntry("Age", age, (value) {
                setState(() {
                  age = value;
                });
              }),
              getTextEntry("City", city, (value) {
                setState(() {
                  city = value;
                });
              }),
              getTextEntry("Favorite Activities", activities, (value) {
                setState(() {
                  activities = value;
                });
              }),
              getTextEntry("Favorite Shows and Movies", entertainments, (value) {
                setState(() {
                  entertainments = value;
                });
              }),
              getTextEntry("School", school, (value) {
                setState(() {
                  school = value;
                });
              }),
              getTextEntry("Favorite School Subjects", schoolSubjects, (value) {
                setState(() {
                  schoolSubjects = value;
                });
              }),
              selectionButton("Highest Education", education, highestEducation, (value) {
                setState(() {
                  highestEducation = value;
                });
              }),
              getTextEntry("Major", major, (value) {
                setState(() {
                  major = value;
                });
              }),
              getTextEntry("Occupation", occupation, (value) {
                setState(() {
                  occupation = value;
                });
              }),
              ElevatedButton(
                onPressed: () {
                  information.add(major);
                  information.add(selectedGender);
                  information.add(selectedCountry);
                  information.add(city);
                  information.add(entertainments);
                  information.add(schoolSubjects);
                  information.add(school);
                  information.add(occupation);
                  information.add(major);
                  information.add(age);
                  information.add(highestEducation);

                  FirebaseFirestore.instance.collection("users").doc(getUID()).update(
                      {
                        "information": information
                      }
                  );

                  Navigator.of(context).pop();
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
