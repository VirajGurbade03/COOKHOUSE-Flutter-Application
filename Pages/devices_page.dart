import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  int? _selectedDevice;

  @override
  void initState() {
    super.initState();
    _loadSelectedDevice(); // Load selected device when the app starts
  }

  // Load selected device from SharedPreferences
  Future<void> _loadSelectedDevice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedDevice = prefs.getInt('selectedDevice');
    });
  }

  // Save selected device to SharedPreferences
  Future<void> _saveSelectedDevice(int deviceNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedDevice', deviceNumber);
  }

  void _selectDevice(int deviceNumber) {
    setState(() {
      _selectedDevice = deviceNumber;
    });
    _saveSelectedDevice(deviceNumber); // Save selected device when selected
  }

  void _connectDevice() {
    if (_selectedDevice != null) {
      _databaseReference.child('Devices Status').set({
        'selected_device': 'D$_selectedDevice',
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device connected successfully!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error connecting device: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a device to connect.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            for (int i = 1; i <= 5; i++)
              GestureDetector(
                onTap: () {
                  try {
                    _selectDevice(i);
                  } catch (e) {
                    print('Error selecting device: $e'); // Log the error
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.75, // Responsive width
                  height: 52,
                  margin: const EdgeInsets.only(
                      bottom: 16.0), // Space between buttons
                  decoration: ShapeDecoration(
                    color: _selectedDevice == i ? Colors.blue : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42),
                      side: BorderSide(
                        color: _selectedDevice == i ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Devices $i',
                    style: TextStyle(
                      color: _selectedDevice == i ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.75,
                    52), // Responsive width
              ),
              onPressed: _connectDevice,
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
