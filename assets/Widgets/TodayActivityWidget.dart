import 'package:flutter/material.dart';

class TodayActivityWidget extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String imagePath;

  const TodayActivityWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125.33,
      height: 132.44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.60),
        shape: BoxShape.rectangle,
        color: const Color(0xFF202020),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(-0.6, -0.7),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 19,
            top: 73,
            child: SizedBox(
              width: 80,
              height: 23,
              child: Text(
                '$value $unit',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.48,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-0.1, 0.8),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFA99B9B),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
