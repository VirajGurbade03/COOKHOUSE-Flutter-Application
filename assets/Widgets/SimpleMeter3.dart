import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SimpleMeter3 extends StatefulWidget {
  const SimpleMeter3({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimpleMeter3State createState() => _SimpleMeter3State();
}

class _SimpleMeter3State extends State<SimpleMeter3> {
  double _markerValue = 0; // Initial value
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    // Listen to the 'Skin Wettedness' data from Firebase
    _databaseRef.child('Skin Wettedness').onValue.listen((event) {
      final newValue = event.snapshot.value;
      if (newValue != null && newValue is double) {
        setState(() {
          _markerValue = newValue;
        });
      }
    });
  }

  void _onValueChanged(double value) {
    // Round value to the nearest 0, 1, 2, or 3 before updating Firebase
    double roundedValue = _roundToNearest(value);
    _databaseRef.child('/D1/Application/Skin Wettedness').set(roundedValue);
    setState(() {
      _markerValue = roundedValue;
    });
  }

  double _roundToNearest(double value) {
    return value.roundToDouble(); // Rounds the value to the nearest integer
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.05, // Responsive padding
      ),
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
                      'Normal',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Slightly Wet',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Wet',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Very Wet',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: isPortrait
                      ? screenHeight * 0.1
                      : screenHeight * 0.15, // Responsive height for slider
                  child: Center(
                    child: Slider(
                      value: _markerValue,
                      min: 0, // Minimum value
                      max: 3, // Maximum value
                      divisions: 3, // Only 4 discrete values (0, 1, 2, 3)
                      onChanged: _onValueChanged,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.blue,
                      label: _markerValue
                          .toStringAsFixed(0), // Display value on thumb
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.0), // Responsive spacing
                Text(
                  _markerValue
                      .toStringAsFixed(0), // Display integer values only
                  style: TextStyle(
                    fontSize: screenWidth *
                        0.08, // Responsive font size for value display
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
