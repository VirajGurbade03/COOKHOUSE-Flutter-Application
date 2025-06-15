// Create a reusable widget for the containers with images and text
import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String imagePath;

  const DataWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158,
      width: 195,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.60),
        shape: BoxShape.rectangle,
        color: const Color(0xFF202020),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(-0.8, -0.5),
            child: SizedBox(
              width: 70,
              height: 70,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 110,
            top: 23,
            child: SizedBox(
              width: 80,
              height: 80,
              child: Text(
                '$value\n$unit',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-0.10, 0.8),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFA99B9B),
                  fontSize: 18,
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