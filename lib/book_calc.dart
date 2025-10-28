import 'package:flutter/material.dart';

class BookCalcScreen extends StatefulWidget {
  const BookCalcScreen({super.key});

  @override
  State<BookCalcScreen> createState() => _BookCalcScreenState();
}

class _BookCalcScreenState extends State<BookCalcScreen> {
  // Controllers & Variables
  TextEditingController pagesController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  FocusNode pagesFocusNode = FocusNode();

  double daysToFinish = 0.0;
  double? selectedHours;

  // Variable to hold the error message when input is invalid
  String? pagesError;
  String? speedError;
  String? hoursError;

  // UI layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Reading Time Estimator', style: TextStyle(color: Color.fromARGB(255, 1, 15, 85)),
        ),
        backgroundColor: Color.fromARGB(255, 128, 198, 255),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.lightBlue[50],
            ),
            width: 380,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Total Pages
                Row(
                  children: [
                    SizedBox(width: 130, child: Text('Total Pages')),
                    Expanded(
                      child: TextField(
                        controller: pagesController,
                        focusNode: pagesFocusNode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'e.g. 300',
                          errorText: pagesError, // show error message when input is invalid
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Reading Speed
                Row(
                  children: [
                    SizedBox(width: 130, child: Text('Reading Speed')),
                    Expanded(
                      child: TextField(
                        controller: speedController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'pages/hour',
                          errorText: speedError, 
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Hours per Day
                Row(
                  children: [
                    SizedBox(width: 130, child: Text('Hours per Day')),
                    Expanded(
                      child: DropdownButtonFormField<double>(
                        value: selectedHours,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select hours',
                          errorText: hoursError, 
                        ),
                        items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                            .map((hour) => DropdownMenuItem<double>(
                                  value: hour.toDouble(),
                                  child: Text('$hour hours'),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedHours = value;
                            hoursError = null; 
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Buttons 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Calculate button
                    ElevatedButton(
                      onPressed: calculateDays,
                      child: Text('Calculate'),
                    ),
                    // Reset button
                    ElevatedButton(
                      onPressed: resetFields,
                      child: Text('Reset'),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Output display
                if (daysToFinish > 0)
                  Text(
                    'You will finish in $daysToFinish days',
                      style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 5, 30, 151),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Calculation Function 
  void calculateDays() {
    double pages = double.tryParse(pagesController.text) ?? 0;
    double speed = double.tryParse(speedController.text) ?? 0;

    setState(() {
      // Reset previous errors messages before validating
      pagesError = null;
      speedError = null;
      hoursError = null;
      daysToFinish = 0.0;
    });

    bool hasError = false;
    
    if (pages <= 0) {
      pagesError = "Enter valid pages";
      hasError = true;
    }

    if (speed <= 0) {
      speedError = "Enter valid speed";
      hasError = true;
    }

    if (selectedHours == null) {
      hoursError = "Select hours per day";
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    double totalHours = pages / speed;
    double days = totalHours / selectedHours!;

    setState(() {
      daysToFinish = days.ceilToDouble();
    });
  }

  // Reset Function
  void resetFields() {
    setState(() {
      pagesController.clear();
      speedController.clear();
      selectedHours = null;
      daysToFinish = 0.0;
      pagesError = null;
      speedError = null;
      hoursError = null;
      // Return focus to first input field for convenience
      FocusScope.of(context).requestFocus(pagesFocusNode);
    });
  }
}
