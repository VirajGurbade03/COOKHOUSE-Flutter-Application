import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SimpleMeter extends StatefulWidget {
  const SimpleMeter({super.key});

  @override
  _SimpleMeterState createState() => _SimpleMeterState();
}

class _SimpleMeterState extends State<SimpleMeter> {
  double _markerValue = 0; // Initial value
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    // Listen to changes in the '/Temperature Preference' node in Firebase
    _databaseRef.child('Temperature Preference').onValue.listen((event) {
      final newValue = event.snapshot.value;
      if (newValue != null && newValue is double) {
        setState(() {
          _markerValue = newValue;
        });
      }
    });
  }

  void _onValueChanged(double value) {
    // Round value to nearest -1, 0, or 1 before updating Firebase
    double roundedValue = _roundToNearest(value);
    _databaseRef.child('/D1/Application/Temp Preference').set(roundedValue);
    setState(() {
      _markerValue = roundedValue;
    });
  }

  double _roundToNearest(double value) {
    if (value < -0.5) return -1;
    if (value > 0.5) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cooler',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'No Changes',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Warmer',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: isPortrait
                      ? screenHeight * 0.1
                      : screenHeight * 0.15, // Responsive slider height
                  child: Center(
                    child: Slider(
                      value: _markerValue,
                      min: -1,
                      max: 1,
                      divisions: 2, // Restrict to -1, 0, 1 values
                      onChanged: _onValueChanged,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.blue,
                      label:
                          _markerValue.toStringAsFixed(0), // Show rounded value
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                Text(
                  _markerValue.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize:
                        screenWidth * 0.08, // Responsive font size for value
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
