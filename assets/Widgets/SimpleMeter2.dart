import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SimpleMeter2 extends StatefulWidget {
  const SimpleMeter2({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimpleMeter2State createState() => _SimpleMeter2State();
}

class _SimpleMeter2State extends State<SimpleMeter2> {
  double _markerValue = 0; // Initial value
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _databaseRef.child('Thermal comfort value').onValue.listen((event) {
      final newValue = event.snapshot.value;
      if (newValue != null && newValue is double) {
        setState(() {
          _markerValue = newValue;
        });
      }
    });
  }

  void _onValueChanged(double value) {
    // Round value to nearest 0, 1, 2, or 3 before updating Firebase
    double roundedValue = _roundToNearest(value);
    _databaseRef.child('/D1/Application/TCV').set(roundedValue);
    setState(() {
      _markerValue = roundedValue;
    });
  }

  double _roundToNearest(double value) {
    return value.roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comfortable',
                      style: TextStyle(
                        fontSize: 10, // Increased font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '      Slightly \nUncomfortable',
                      style: TextStyle(
                        fontSize: 10, // Increased font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Uncomfortable',
                      style: TextStyle(
                        fontSize: 10, // Increased font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '         Very \nUncomfortable',
                      style: TextStyle(
                        fontSize: 10, // Increased font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80, // Increased height for better visibility
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
                Text(
                  _markerValue
                      .toStringAsFixed(0), // Display integer values only
                  style: const TextStyle(
                    fontSize: 30, // Increased font size
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
