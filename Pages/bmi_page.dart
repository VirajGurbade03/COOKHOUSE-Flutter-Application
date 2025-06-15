import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  bool isFemaleSelected = false;
  bool isMaleSelected = false;
  double weight = 0.0;
  double height = 0.0;
  double bmi = 0.0;
  int age = 0;
  String gender = ''; // Track the selected gender

  @override
  void initState() {
    super.initState();
  }

  void selectFemale() {
    setState(() {
      isFemaleSelected = true;
      isMaleSelected = false;
      gender = 'Female'; // Set the gender when selected
    });
  }

  void selectMale() {
    setState(() {
      isMaleSelected = true;
      isFemaleSelected = false;
      gender = 'Male'; // Set the gender when selected
    });
  }

  void calculateBMI() {
    if (gender.isEmpty) {
      // Show an alert if no gender is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Please select a gender before calculating BMI.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      bmi = weight / ((height / 100) * (height / 100));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size dynamically
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define proportional padding and sizes based on screen width and height
    final padding = screenWidth * 0.05; // 5% of screen width
    final buttonHeight = screenHeight * 0.08; // 8% of screen height
    final textSize = screenWidth * 0.05; // 5% of screen width for text

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/Homepage");
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.2),
                    Text(
                      "BMI Calculator",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSize * 1.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Gender",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: selectMale,
                      child: CircleAvatar(
                        radius: screenWidth * 0.12,
                        backgroundImage:
                            const AssetImage('lib/assets/images/Male.png'),
                        backgroundColor:
                            isMaleSelected ? Colors.blue : Colors.transparent,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.1),
                    GestureDetector(
                      onTap: selectFemale,
                      child: CircleAvatar(
                        radius: screenWidth * 0.12,
                        backgroundImage:
                            const AssetImage('lib/assets/images/Female.png'),
                        backgroundColor: isFemaleSelected
                            ? const Color.fromARGB(255, 255, 1, 94)
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                buildInputField("Age", (value) {
                  setState(() {
                    age = int.tryParse(value) ?? 0;
                  });
                }),
                SizedBox(height: screenHeight * 0.04),
                buildInputField("Weight (kg)", (value) {
                  setState(() {
                    weight = double.tryParse(value) ?? 0.0;
                  });
                }),
                SizedBox(height: screenHeight * 0.04),
                buildInputField("Height (cm)", (value) {
                  setState(() {
                    height = double.tryParse(value) ?? 0.0;
                  });
                }),
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: Text(
                    'BMI: ${bmi.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.8,
                    height: buttonHeight,
                    child: CupertinoButton(
                      onPressed: calculateBMI,
                      color: const Color(0xFF5F5F5F),
                      borderRadius: BorderRadius.circular(39.95),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build input fields with consistent styles
  Widget buildInputField(String label, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.37,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.10,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(42),
            ),
          ),
          child: TextFormField(
            style: const TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '',
            ),
          ),
        ),
      ],
    );
  }
}
