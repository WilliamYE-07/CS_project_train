import 'package:cs_project_train/SelfDesign/questionnaire.dart';
import 'package:cs_project_train/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DIY extends StatefulWidget {
  const DIY({super.key});

  @override
  State<DIY> createState() => _DIYState();
}

class _DIYState extends State<DIY> {
  List<List<bool>> gridData = [];
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  int width = 6;
  int height = 6;

  _DIYState() {
    widthController.text = width.toString();
    heightController.text = height.toString();

    // initialize the gridData of width and height
    for (int i = 0; i < width; i++) {
      gridData.add([]);
      for (int j = 0; j < height; j++) {
        gridData[i].add(false);
      }
    }
  }

  void onWidthChanged(int newWidth) {
    // if new width is larger, add the difference to all rows.
    if (newWidth > width) {
      for (int i = 0; i < height; i++) {
        for (int j = width; j < newWidth; j++) {
          gridData[i].add(false);
        }
      }
    }
    // if new width is smaller, remove the difference from all rows.
    else {
      for (int i = 0; i < height; i++) {
        for (int j = width-1; j >= newWidth; j--) {
          gridData[i].removeAt(j);
        }
      }
    }
    width = newWidth;
  }

  void onHeightChanged(int newHeight) {
    // if new height is larger, add however many rows
    if (newHeight > height) {
      for (int i = height; i < newHeight; i++) {
        gridData.add([]);
        for (int j = 0; j < width; j++) {
          gridData[i].add(false);
        }
      }
    }
    // if new height is smaller, remove however many rows
    else {
      for (int j = height-1; j >= newHeight; j--) {
        gridData.removeAt(j);
      }
    }
    height = newHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Do It Yourself"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 75,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridData[0].length, // Number of columns
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // Calculate the row and column of the current index
                    int row = index ~/ gridData[0].length;
                    int col = index % gridData[0].length;

                    // Return a container for each item in the grid
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gridData[row][col] ? Colors.green : Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              gridData[row][col] = !gridData[row][col];
                            });
                          },
                          child: SizedBox.shrink()
                      ),
                    );
                  },
                  itemCount: gridData.length * gridData[0].length,
                ),
              ),
              Expanded(
                flex: 25,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Width: "),
                          Expanded(
                            child: TextField(
                              controller: widthController,
                              onSubmitted: (String newVal) {
                                setState(() {
                                  onWidthChanged(int.parse(newVal));
                                });
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                          Text("Height: "),
                          Expanded(
                            child: TextField(
                              controller: heightController,
                              onSubmitted: (String newVal) {
                                setState(() {
                                  onHeightChanged(int.parse(newVal));
                                });
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              goToPage(context, QuestionnaireForm(gridData));
                            },
                            child: Text("Continue")
                          ),
                        ],
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
