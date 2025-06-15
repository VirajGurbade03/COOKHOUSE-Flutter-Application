import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fb; // Aliasing the package

class BluetoothService {
  BluetoothService._privateConstructor();

  static final BluetoothService _instance = BluetoothService._privateConstructor();

  factory BluetoothService() {
    return _instance;
  }

  fb.BluetoothDevice? _connectedDevice;
  final _temperatureStreamController = StreamController<double>();

  Stream<double> get temperatureStream => _temperatureStreamController.stream;

  Future<void> connectToDevice(fb.BluetoothDevice device) async {
    try {
      // Connect to the Bluetooth device
      await device.connect();
      _connectedDevice = device;

      // Discover services
      List<fb.BluetoothService> services = await device.discoverServices();
      for (fb.BluetoothService service in services) {
        for (fb.BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == '6d1aae7d-6813-45f4-ad8b-f2d528b8d3b5') {
            // Set up notification for temperature updates
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              double temperature = _parseTemperature(value);
              _temperatureStreamController.add(temperature);
            });
          }
        }
      }
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }

  double _parseTemperature(List<int> value) {
    // Example parsing: You may need to adjust based on your data format
    try {
      // Assuming the temperature data is represented as an ASCII string
      return double.parse(String.fromCharCodes(value));
    } catch (e) {
      print('Error parsing temperature: $e');
      return 0.0;
    }
  }

  void dispose() {
    _temperatureStreamController.close();
    if (_connectedDevice != null) {
      _connectedDevice!.disconnect();
    }
  }
}
