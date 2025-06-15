// import 'dart:async';
// import 'package:comfortcast_1/assets/Widgets/BluetoothService.dart'; // Your local BluetoothService class
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb; // Alias for flutter_blue_plus

// class Tempeture extends StatefulWidget {
//   const Tempeture({super.key});

//   @override
//   State<Tempeture> createState() => _TempetureState();
// }

// class _TempetureState extends State<Tempeture> {
//   double _temperature = 0;
//   final BluetoothService _bluetoothService = BluetoothService(); // Your local BluetoothService
//   StreamSubscription<fb.ScanResult>? _scanSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _connectToBluetoothDevice();
//   }

//   Future<void> _connectToBluetoothDevice() async {
//     try {
//       // Start scanning for devices
//       _scanSubscription = fb.FlutterBluePlus.instance.scan().listen(
//         (scanResult) async {
//           if (scanResult.device.name == 'ESPRJ') {
//             // Stop scanning once the device is found
//             await _scanSubscription?.cancel();
//             await _bluetoothService.connectToDevice(scanResult.device);

//             // Ensure temperatureStream is a stream
//             _bluetoothService.temperatureStream.listen(
//               (temperature) {
//                 setState(() {
//                   _temperature = temperature;
//                 });
//               },
//               onError: (error) {
//                 print('Error receiving temperature: $error');
//               },
//             );
//           }
//         },
//         onError: (error) {
//           print('Error during scan: $error');
//         },
//       );

//       // Optionally handle scan timeout
//       Future.delayed(Duration(seconds: 10), () {
//         _scanSubscription?.cancel(); // Stop scanning after a delay
//       });
//     } catch (e) {
//       print('Error in _connectToBluetoothDevice: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _scanSubscription?.cancel();
//     _bluetoothService.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 158,
//       width: 195,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.60),
//         shape: BoxShape.rectangle,
//         color: const Color(0xFF202020),
//       ),
//       child: Stack(
//         children: [
//           Align(
//             alignment: const AlignmentDirectional(-0.8, -0.5),
//             child: SizedBox(
//               width: 70,
//               height: 70,
//               child: Image.asset(
//                 'lib/assets/images/room_tempe.png',
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           Positioned(
//             left: 100,
//             top: 27,
//             child: SizedBox(
//               width: 80,
//               height: 80,
//               child: Text(
//                 "${_temperature.toStringAsFixed(1)} °C", // Display the received temperature
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 30,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w400,
//                   height: 1.2,
//                 ),
//               ),
//             ),
//           ),
//           const Align(
//             alignment: AlignmentDirectional(-0.10, 0.8),
//             child: Padding(
//               padding: EdgeInsets.only(bottom: 8.0),
//               child: Text(
//                 'Room Temperature',
//                 style: TextStyle(
//                   color: Color(0xFFA99B9B),
//                   fontSize: 18,
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
