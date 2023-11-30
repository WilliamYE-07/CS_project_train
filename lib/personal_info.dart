
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_project_train/Login/authentication.dart';
import 'package:cs_project_train/main.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class PersonalInfoSelection extends StatefulWidget {
  @override
  _PersonalInfoSelectionState createState() => _PersonalInfoSelectionState();
}

class _PersonalInfoSelectionState extends State<PersonalInfoSelection> {
  String selectedGender = "Male";
  List<String> genders = ['Male', 'Female', 'Other'];
  String selectedCountry = "USA";
  List<String> countries = ['USA', 'Canada', 'UK', 'Australia', 'China', 'Other'];
  TextEditingController age = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController activities = TextEditingController();
  TextEditingController entertainments = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController schoolSubjects = TextEditingController();
  String highestEducation = "High School";
  List<String> education = ['High School', 'Associates', 'Bachelors', 'Masters', 'Doctorates'];
  TextEditingController major = TextEditingController();
  TextEditingController occupation = TextEditingController();

  List<String> information = [];

  _PersonalInfoSelectionState() {
    DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(getUID());
    docRef.get().then((docSnapshot) {
      Map<String, dynamic> info = docSnapshot.data() as Map<String, dynamic>;
      List<dynamic> userInfo = info['information'] as List<dynamic>;

      setState(() {
        selectedGender = userInfo[0];
        selectedCountry = userInfo[1];
        age.text = userInfo[2];
        city.text = userInfo[3];
        activities.text = userInfo[4];
        entertainments.text = userInfo[5];
        school.text = userInfo[6];
        schoolSubjects.text = userInfo[7];
        highestEducation = userInfo[8];
        major.text = userInfo[9];
        occupation.text = userInfo[10];
      });
    });
  }

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

  Widget getTextEntry(String label, TextEditingController controller) {
    return TextFormField(
      obscureText: false,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      onChanged: (value) {
        controller.text = value;
      },
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
              getTextEntry("Age", age),
              getTextEntry("City", city),
              getTextEntry("Favorite Activities", activities),
              getTextEntry("Favorite Shows and Movies", entertainments),
              getTextEntry("School", school),
              getTextEntry("Favorite School Subjects", schoolSubjects),
              selectionButton("Highest Education", education, highestEducation, (value) {
                setState(() {
                  highestEducation = value;
                });
              }),
              getTextEntry("Major", major),
              getTextEntry("Occupation", occupation),
              ElevatedButton(
                onPressed: () {
                  information.add(selectedGender);
                  information.add(selectedCountry);
                  information.add(age.text);
                  information.add(city.text);
                  information.add(activities.text);
                  information.add(entertainments.text);
                  information.add(school.text);
                  information.add(schoolSubjects.text);
                  information.add(highestEducation);
                  information.add(major.text);
                  information.add(occupation.text);

                  FirebaseFirestore.instance.collection("users").doc(getUID()).update(
                      {
                        "information": information
                      }
                  );

                  goToPage(context, HomeScreen());
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
