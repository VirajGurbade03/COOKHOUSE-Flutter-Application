
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String month = DateFormat.MMMM().format(now); // August
    String day = DateFormat.d().format(now); // 16
    String weekday = DateFormat.EEEE().format(now); // Wednesday

    return SizedBox(
      width: 138,
      height: 138,
      child: Container(
        decoration: ShapeDecoration(
          image: const DecorationImage(
            image: AssetImage("lib/assets/images/newdate.png"),
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1.11,
            ),
            borderRadius: BorderRadius.circular(25.60),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              month,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                day,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 47,
                    fontWeight: FontWeight.w800,
                    height: 0),
              ),
            ),
            Text(
              weekday,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
