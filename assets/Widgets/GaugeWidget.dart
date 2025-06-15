import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatefulWidget {
  const GaugeWidget({super.key});

  @override
  _GaugeWidgetState createState() => _GaugeWidgetState();
}

class _GaugeWidgetState extends State<GaugeWidget> {
  double _markerValue = 0; // Initial value
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
  }

  void _onValueChanged(double value) {
    setState(() {
      _markerValue = value;
    });

    double roundedValue = double.parse(value.toStringAsFixed(2));

    // Update the value to Firebase Realtime Database at '/D1/Application/TSV'
    _databaseRef.child('/D1/Application/TSV').set(roundedValue);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust size and font dynamically based on screen size
    final gaugeHeight = screenHeight * 0.3; // 30% of screen height
    final gaugeFontSize = screenWidth * 0.1; // Font size as 5% of screen width
    final annotationFontSize =
        screenWidth * 0.035; // Smaller font size for labels

    return Padding(
      padding:
          EdgeInsets.all(screenWidth * 0.05), // Padding based on screen width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: gaugeHeight, // Responsive height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.6),
              shape: BoxShape.rectangle,
              color: const Color(0xFF202020),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: screenHeight * 0.04), // Dynamic padding
              child: Center(
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: -3,
                      maximum: 3,
                      interval: 1, // Show only integer labels
                      radiusFactor: 1, // Increase size of radial axis
                      showLabels: true,
                      showTicks: true,
                      axisLabelStyle: GaugeTextStyle(
                        fontSize: annotationFontSize, // Dynamic font size
                        color: Colors.white,
                      ),
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.2,
                        cornerStyle: CornerStyle.bothCurve,
                        thicknessUnit: GaugeSizeUnit.factor,
                        gradient: SweepGradient(
                          colors: <Color>[
                            Color.fromRGBO(30, 132, 251, 1),
                            Color.fromRGBO(205, 29, 19, 1),
                          ],
                          stops: <double>[0.25, 0.75],
                        ),
                      ),
                      pointers: <GaugePointer>[
                        MarkerPointer(
                          value: _markerValue,
                          markerHeight:
                              screenWidth * 0.1, // Marker size responsive
                          markerWidth: screenWidth * 0.1,
                          markerType: MarkerType.circle,
                          color: Colors.white,
                          enableDragging: true,
                          onValueChanged: _onValueChanged,
                        ),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Align(
                            alignment: AlignmentDirectional(0, -0.2),
                            child: Text(
                              _markerValue.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: gaugeFontSize, // Dynamic font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          angle: 90,
                          positionFactor: 0.1,
                        ),
                        GaugeAnnotation(
                          widget: Align(
                            alignment: AlignmentDirectional(0, 0.7),
                            child: Text(
                              'Cold',
                              style: TextStyle(
                                fontSize: annotationFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          angle: 180,
                          positionFactor: 1.1,
                        ),
                        GaugeAnnotation(
                          widget: Align(
                            alignment: AlignmentDirectional(-0.1, -0.6),
                            child: Text(
                              'Slight\n Cold',
                              style: TextStyle(
                                fontSize: annotationFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          angle: 180,
                          positionFactor: 1.1,
                        ),
                        GaugeAnnotation(
                          widget: Align(
                            alignment: AlignmentDirectional(0, 0.7),
                            child: Text(
                              'Hot',
                              style: TextStyle(
                                fontSize: annotationFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          angle: 0,
                          positionFactor: 1.1,
                        ),
                        GaugeAnnotation(
                          widget: Align(
                            alignment: AlignmentDirectional(0.1, -0.6),
                            child: Text(
                              'Slightly\n   Hot',
                              style: TextStyle(
                                fontSize: annotationFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          angle: 0,
                          positionFactor: 1.1,
                        ),
                        GaugeAnnotation(
                          widget: Align(
                            alignment: const AlignmentDirectional(-0.8, -1.4),
                            child: Text(
                              'Neutral',
                              style: TextStyle(
                                fontSize: annotationFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          angle: 0,
                          positionFactor: 1.1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
