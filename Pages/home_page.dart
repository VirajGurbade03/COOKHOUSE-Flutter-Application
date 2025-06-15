// ignore_for_file: unused_import, avoid_print

import 'dart:async';

import 'package:comfortcast_1/Pages/sex_page.dart';
import 'package:comfortcast_1/assets/Widgets/DateWidget.dart';
import 'package:comfortcast_1/assets/Widgets/GaugeWidget.dart';
import 'package:comfortcast_1/assets/Widgets/SimpleMeter.dart';
import 'package:comfortcast_1/assets/Widgets/SimpleMeter1.dart';
import 'package:comfortcast_1/assets/Widgets/SimpleMeter2.dart';
import 'package:comfortcast_1/assets/Widgets/SimpleMeter3.dart';
import 'package:comfortcast_1/assets/Widgets/TodayActivityWidget.dart';
import 'package:comfortcast_1/assets/Widgets/customdrawer%20.dart';
import 'package:comfortcast_1/assets/Widgets/datawidget.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<SexPageState> sexPageKey;

  const HomePage({super.key, required this.sexPageKey});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFemaleSelected = false;
  bool isMaleSelected = false;
  final _temperatureStream = StreamController<String>.broadcast();
  final _humidityStream = StreamController<String>.broadcast();
  final _co2LevelStream = StreamController<String>.broadcast();
  final _bodytempStream = StreamController<String>.broadcast();
  final _coretempStream = StreamController<String>.broadcast();
  final _activitylevelStream = StreamController<String>.broadcast();
  final _stepscontStream = StreamController<String>.broadcast();
  final _heartrateStream = StreamController<String>.broadcast();
  final _oxygenStream = StreamController<String>.broadcast();
  final _totalValueStream = StreamController<String>.broadcast();
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    _databaseReference.child('/D1/Wearable/RT').onValue.listen((event) {
      final String temp = event.snapshot.value.toString();
      _temperatureStream.add(temp);
    });

    _databaseReference.child('/D1/Wearable/HT').onValue.listen((event) {
      final String hum = event.snapshot.value.toString();
      _humidityStream.add(hum);
    });

    _databaseReference.child('/D1/Wearable/CO2').onValue.listen((event) {
      final String co2 = event.snapshot.value.toString();
      _co2LevelStream.add(co2);
    });

    _databaseReference.child('/D1/Wearable/BT').onValue.listen((event) {
      final String bote = event.snapshot.value.toString();
      _bodytempStream.add(bote);
    });

    _databaseReference.child('/D1/Wearable/CT').onValue.listen((event) {
      final String bote = event.snapshot.value.toString();
      _coretempStream.add(bote);
    });

    _databaseReference
        .child('/D1/Application/Activity Selected/MET')
        .onValue
        .listen((event) {
      final String actlev = event.snapshot.value.toString();
      _activitylevelStream.add(actlev);
    });

    _databaseReference.child('/D1/Wearable/ST').onValue.listen((event) {
      final String step = event.snapshot.value.toString();
      _stepscontStream.add(step);
    });

    _databaseReference.child('/D1/Wearable/HR').onValue.listen((event) {
      final String heart = event.snapshot.value.toString();
      _heartrateStream.add(heart);
    });

    _databaseReference.child('/D1/Wearable/SpO2').onValue.listen((event) {
      final String oxygenlev = event.snapshot.value.toString();
      _oxygenStream.add(oxygenlev);
    });

    _databaseReference
        .child('/D1/Application/Clothing Data/Clo value')
        .onValue
        .listen((event) {
      final String value = event.snapshot.value.toString();
      _totalValueStream.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: CustomDrawer(),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(left: 4, top: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 6),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.08,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF070707),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1.11,
                                color: Color(0xFF4D4B4B),
                              ),
                              borderRadius: BorderRadius.circular(20.04),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: 10,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              // Centering the IconButton
                              child: IconButton(
                                icon: Image.asset(
                                    "lib/assets/images/Setting.png"),
                                onPressed: () {
                                  scaffoldKey.currentState?.openDrawer();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Dashboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.08,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF070707),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1.11,
                                color: Color(0xFF4D4B4B),
                              ),
                              borderRadius: BorderRadius.circular(20.04),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          top: 14,
                          child: SizedBox(
                            width: 49,
                            height: 49,
                            child: Center(
                              child: IconButton(
                                icon: Image.asset(
                                    "lib/assets/images/Bell_pin_noti.png"),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/NotifyPage");
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 4, right: 10),
                child: Row(
                  children: [
                    const DateWidget(), // Replace this SizedBox with DateWidget
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.60),
                          color: const Color(0xFF202020),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StreamBuilder<String>(
                                stream: _stepscontStream.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return SizedBox(
                                      width: screenWidth * 0.2,
                                      height: screenHeight * 0.1,
                                      child: SfRadialGauge(
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                            minimum: 0,
                                            maximum:
                                                10000, // Assuming a step goal of 10,000 steps
                                            showLabels: false,
                                            showTicks: false,
                                            axisLineStyle: AxisLineStyle(
                                              thickness: 0.2,
                                              cornerStyle:
                                                  CornerStyle.bothCurve,
                                              color: const Color.fromARGB(
                                                      30, 0, 255, 30)
                                                  .withOpacity(0.3),
                                              thicknessUnit:
                                                  GaugeSizeUnit.factor,
                                            ),
                                            pointers: <GaugePointer>[
                                              RangePointer(
                                                value: double.tryParse(
                                                        snapshot.data!) ??
                                                    0, // Convert step count to double
                                                width: 0.2,
                                                sizeUnit: GaugeSizeUnit.factor,
                                                color: Colors.green,
                                                cornerStyle:
                                                    CornerStyle.bothCurve,
                                              ),
                                            ],
                                            annotations: const <GaugeAnnotation>[
                                              GaugeAnnotation(
                                                positionFactor: 0.1,
                                                angle: 90,
                                                widget: Icon(
                                                  Icons
                                                      .directions_run, // Running icon in the center
                                                  color: Color.fromRGBO(
                                                      0, 255, 71, 1),
                                                  size: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  const SizedBox(height: 30),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 19),
                                    child: Text(
                                      "Current Activity",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StreamBuilder<String>(
                                        stream: _stepscontStream.stream,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.split('.')[0],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        "Steps",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
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
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14, top: 20, bottom: 15),
                          child: SizedBox(
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.03,
                            child: const Text(
                              "Today Activity",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.48,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 4, left: 4, right: 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              StreamBuilder<String>(
                                stream: _heartrateStream.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return TodayActivityWidget(
                                      title: 'Heart Rate',
                                      value: snapshot.data!,
                                      unit: 'bpm',
                                      imagePath:
                                          'lib/assets/images/heart_rate.png',
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(width: 12),
                              StreamBuilder<String>(
                                stream: _bodytempStream.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return TodayActivityWidget(
                                      title: 'Body Tempe',
                                      value: snapshot.data!,
                                      unit: '°C',
                                      imagePath:
                                          'lib/assets/images/body_tempe.png',
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(width: 12),
                              StreamBuilder<String>(
                                stream: _coretempStream.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return TodayActivityWidget(
                                      title: 'Core Tempe',
                                      value: snapshot.data!,
                                      unit: '°C',
                                      imagePath:
                                          'lib/assets/images/coretempe.png',
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(width: 12),
                              StreamBuilder<String>(
                                stream: _oxygenStream.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return TodayActivityWidget(
                                      title: 'Oxygen Level',
                                      value: snapshot.data!,
                                      unit: '%',
                                      imagePath: 'lib/assets/images/ox.png',
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(width: 12),
                              StreamBuilder<String>(
                                stream: _totalValueStream.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return TodayActivityWidget(
                                      title: 'Clothing Data',
                                      value: snapshot.data!,
                                      unit: 'clo',
                                      imagePath:
                                          'lib/assets/images/clothing.png',
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(width: 12),
                              StreamBuilder<String>(
                                stream: _activitylevelStream.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return TodayActivityWidget(
                                      title: 'Activity Level',
                                      value: snapshot.data!,
                                      unit: 'met',
                                      imagePath:
                                          'lib/assets/images/Activity.png',
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14, top: 20, bottom: 0),
                          child: SizedBox(
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.03,
                            child: const Text(
                              "Room Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.48,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 19, left: 5, right: 5),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: // Replace the containers with images and text with the DataWidget
                                Row(
                              children: [
                                StreamBuilder<String>(
                                  stream: _temperatureStream.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return DataWidget(
                                        title: 'Room Temperature',
                                        value: snapshot.data!,
                                        unit: '°C',
                                        imagePath:
                                            'lib/assets/images/room_tempe.png',
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                                const SizedBox(width: 15),
                                StreamBuilder<String>(
                                  stream: _humidityStream.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return DataWidget(
                                        title: 'Humidity Level',
                                        value: snapshot.data!,
                                        unit: '%',
                                        imagePath:
                                            'lib/assets/images/Humidity.png',
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                                const SizedBox(width: 15),
                                StreamBuilder<String>(
                                  stream: _co2LevelStream.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return DataWidget(
                                        title: 'CO2 Level',
                                        value: snapshot.data!.split('.')[0],
                                        unit: 'ppm',
                                        imagePath:
                                            'lib/assets/images/Co2_level.png',
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14, top: 20, bottom: 0),
                          child: SizedBox(
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.03,
                            child: const Text(
                              "Thermal Sensation Value",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.48,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 4, right: 6, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.60),
                                  shape: BoxShape.rectangle,
                                  color: const Color(0xFF202020),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: GaugeWidget(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14, top: 20, bottom: 0),
                          child: SizedBox(
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.03,
                            child: const Text(
                              "Thermal comfort value",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.48,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 4, right: 6, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.60),
                                  shape: BoxShape.rectangle,
                                  color: const Color(0xFF202020),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: SimpleMeter2(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      // Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 14, top: 20, bottom: 0),
                      //     child: SizedBox(
                      //       width: screenWidth * 0.4,
                      //       height: screenHeight * 0.04,
                      //       child: const Text(
                      //         "Skin Wettedness",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 20.48,
                      //           fontFamily: 'Inter',
                      //           fontWeight: FontWeight.w400,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 20, left: 4, right: 6, bottom: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Expanded(
                      //         child: Container(
                      //           width: screenWidth * 0.8,
                      //           height: screenHeight * 0.24,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(25.60),
                      //             shape: BoxShape.rectangle,
                      //             color: const Color(0xFF202020),
                      //           ),
                      //           child: const Padding(
                      //             padding: EdgeInsets.only(top: 20),
                      //             child: SimpleMeter3(),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 2,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14, top: 20, bottom: 0),
                          child: SizedBox(
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.04,
                            child: const Text(
                              "Tempeture Preference",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.48,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 4, right: 6, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.60),
                                  shape: BoxShape.rectangle,
                                  color: const Color(0xFF202020),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: SimpleMeter(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14, top: 20, bottom: 0),
                          child: SizedBox(
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.04,
                            child: const Text(
                              "Velocity Preference",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.48,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 4, right: 6, bottom: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.60),
                                  shape: BoxShape.rectangle,
                                  color: const Color(0xFF202020),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: SimpleMeter1(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
