import 'package:flutter/material.dart';



class PersonalInfoSelection extends StatefulWidget {
  @override
  _PersonalInfoSelectionState createState() => _PersonalInfoSelectionState();
}

class _PersonalInfoSelectionState extends State<PersonalInfoSelection> {
  String selectedGender = "Male";
  String selectedCountry = "USA";
  String selectedColor = "Red";

  List<String> genders = ['Male', 'Female', 'Other'];
  List<String> countries = ['USA', 'Canada', 'UK', 'Australia', 'Other'];
  List<String> colors = ['Red', 'Green', 'Blue', 'Yellow', 'Other'];

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 16.0),
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
          ElevatedButton(
            onPressed: () {
              _showOptionsDialog(countries, selectedCountry, (value) {
                setState(() {
                  selectedCountry = value;
                });
              });
            },
            child: Text('Select Country: ${selectedCountry ?? "Select Country"}'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _showOptionsDialog(colors, selectedColor, (value) {
                setState(() {
                  selectedColor = value;
                });
              });
            },
            child: Text('Select Favorite Color: ${selectedColor ?? "Select Color"}'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // You can process the selected values here
              print('Selected Gender: $selectedGender');
              print('Selected Country: $selectedCountry');
              print('Selected Color: $selectedColor');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
