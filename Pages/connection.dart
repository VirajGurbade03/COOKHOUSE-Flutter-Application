import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  String _wearableWifiStatus = "Loading...";
  String _roomWifiStatus = "Loading...";
  bool _switchStatus = false; // Switch state
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _getConnectionStatus();
  }

  void _getConnectionStatus() async {
    try {
      // Fetch Wearable Wi-Fi connection status
      _database.child('/D1/WiFi Connected').onValue.listen((event) {
        final String wearableStatus = event.snapshot.value.toString();
        setState(() {
          _wearableWifiStatus = wearableStatus;
        });
      });

      // Fetch Room Wi-Fi connection status
      _database.child('/D1/Connection Status').onValue.listen((event) {
        final String roomStatus = event.snapshot.value.toString();
        setState(() {
          _roomWifiStatus = roomStatus;
        });
      });

      // Fetch the switch state from Firebase
      final switchEvent = await _database.child('/D1/Switch').once();
      final String savedSwitchState = switchEvent.snapshot.value.toString();
      setState(() {
        _switchStatus = savedSwitchState == 'on';
        _isLoading = false; // Data loaded
      });
    } catch (e) {
      setState(() {
        _wearableWifiStatus = "Error loading status";
        _roomWifiStatus = "Error loading status";
        _isLoading = false; // Loading complete
      });
    }
  }

  void _updateSwitchState(bool value) {
    final String switchState =
        value ? "on" : "off"; // Convert boolean to "on"/"off"

    // Update the switch state in Firebase without any additional processing
    _database.child('/D1/Switch').set(switchState).catchError((error) {
      print('Error updating switch state: $error');
    });
  }

  void _launchURL() async {
    const url =
        'https://docs.google.com/spreadsheets/d/1jKGSVySD6uoL3Yqxa2zPJ6JPOrcvlrqE897L-kwKRts/edit?usp=sharing';
    final Uri uri = Uri.parse(url);

    print("Trying to launch: $url");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  // Set all Firebase values to zero
  void _setValuesToZero() async {
    List<String> paths = [
      '/D1/Application/Activity Selected/Activity',
      '/D1/Application/User Details/age',
      '/D1/Application/Activity Selected/MET',
      '/D1/Application/Clothing Data/Clo value',
      '/D1/Application/Clothing Data/Gen',
      '/D1/Application/TCV',
      '/D1/Application/TSV',
      '/D1/Application/Temp Preference',
      '/D1/Application/Velo Preference',
      '/D1/Application/User Details/Name',
      '/D1/Wearable/Body Temperature',
      '/D1/Wearable/CO2',
      '/D1/Wearable/Core temperature',
      '/D1/Wearable/Heart Rate',
      '/D1/Wearable/Humidity',
      '/D1/Wearable/Room Temperature',
      '/D1/Wearable/SpO2',
      '/D1/Wearable/Steps',
    ];

    try {
      for (String path in paths) {
        await _database.child(path).set(0);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All values set to zero successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to set values to zero')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wearable connected Wifi:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _wearableWifiStatus,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Connection Status:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _roomWifiStatus,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Data Collection Switch',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        FlutterSwitch(
                          width: 100.0,
                          height: 55.0,
                          valueFontSize: 20.0,
                          toggleSize: 45.0,
                          value: _switchStatus,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              _switchStatus = val;
                            });
                            _updateSwitchState(val); // Update switch state
                          },
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap:
                              _launchURL, // Call the _launchURL function on tap
                          borderRadius: BorderRadius.circular(
                              42), // Ensure the ink well has rounded corners
                          child: Container(
                            width: 200,
                            height: 52,
                            decoration: ShapeDecoration(
                              color: const Color.fromARGB(255, 23, 122, 253),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(42),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'View Data',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: 1.44,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: _setValuesToZero, // Set all values to zero
                          borderRadius: BorderRadius.circular(42),
                          child: Container(
                            width: 200,
                            height: 52,
                            decoration: ShapeDecoration(
                              color: Colors.red, // Set button color to red
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(42),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Set to Zero',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: 1.44,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Note:\nOnce you have completed your data collection process, please switch off the "Data Collection" button to stop the collection. After that, click on the ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '"Set to Zero"',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .red, // Set the "Set to Zero" text to red
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' button to reset all the collected values to ensure the system is ready for the next session.',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
