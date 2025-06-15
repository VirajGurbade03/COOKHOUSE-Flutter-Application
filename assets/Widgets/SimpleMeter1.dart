import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SimpleMeter1 extends StatefulWidget {
  const SimpleMeter1({super.key});

  @override
  _SimpleMeter1State createState() => _SimpleMeter1State();
}

class _SimpleMeter1State extends State<SimpleMeter1> {
  double _markerValue = 0; // Initial value
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    // Listen to changes in the '/Velocity Preference' node in Firebase
    _databaseRef.child('Velocity Preference').onValue.listen((event) {
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
    _databaseRef.child('/D1/Application/Velo Preference').set(roundedValue);
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

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.05), // Responsive padding
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
                      '   Less Air\n movement',
                      style: TextStyle(
                        fontSize: screenWidth * 0.037, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'No Changes',
                      style: TextStyle(
                        fontSize: screenWidth * 0.037, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '   More Air\n movement',
                      style: TextStyle(
                        fontSize: screenWidth * 0.037, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.09, // Responsive height for slider
                  child: Center(
                    child: Slider(
                      value: _markerValue,
                      min: -1,
                      max: 1,
                      divisions: 2, // Only 3 discrete values (-1, 0, 1)
                      onChanged: _onValueChanged,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.blue,
                      label: _markerValue
                          .toStringAsFixed(0), // Display value on thumb
                    ),
                  ),
                ),
                SizedBox(
                    height: screenHeight *
                        0.01), // Spacing between slider and value display
                Text(
                  _markerValue
                      .toStringAsFixed(0), // Display integer values only
                  style: TextStyle(
                    fontSize: screenWidth * 0.08, // Responsive font size
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
