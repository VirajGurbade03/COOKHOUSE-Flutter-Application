import 'package:comfortcast_1/Pages/sex_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class NotifiPage extends StatefulWidget {
  final GlobalKey<SexPageState> sexPageKey;

  const NotifiPage({super.key, required this.sexPageKey});

  @override
  State<NotifiPage> createState() => NotifiPageState();
}

class NotifiPageState extends State<NotifiPage> {
  int _rating = 0;

  void _rate(int index) {
    setState(() {
      _rating = index;
    });
  }

  void _submitFeedback() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a rating before submitting')),
      );
      return;
    }

    try {
      // Store the rating in Firestore
      await FirebaseFirestore.instance.collection('feedback').add({
        'rating': _rating,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your feedback!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting feedback: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.03,
              left: screenWidth * 0.03,
              right: screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/Homepage");
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                  const Text(
                    "Notification",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.07,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Feedback Container
                      SizedBox(
                        width: screenWidth * 0.90,
                        height: screenHeight * 0.2,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: screenWidth * 0.9,
                                height: screenHeight * 0.2,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Color(0xFF818181)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 21,
                              top: 11,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.feedback,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Feedback',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Positioned(
                              left: 21,
                              top: 37,
                              child: SizedBox(
                                width: 346,
                                height: 22,
                                child: Text(
                                  'We value your feedback. Please rate our service:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.51,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 50,
                              child: Row(
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.star,
                                      color: index < _rating
                                          ? Colors.yellow
                                          : Colors.grey,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      _rate(index + 1);
                                    },
                                  );
                                }),
                              ),
                            ),
                            Positioned(
                              left: 21,
                              top: 90,
                              child: ElevatedButton(
                                onPressed: _submitFeedback,
                                child: const Text(
                                  'Submit Feedback',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Clothing Data Container
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.15,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: screenWidth * 0.9,
                                height: screenHeight * 0.15,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Color(0xFF818181)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 21,
                              top: 11,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.dry_cleaning,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Clothing Data',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Positioned(
                              left: 21,
                              top: 37,
                              child: SizedBox(
                                width: 346,
                                height: 22,
                                child: Text(
                                  'Manage your clothing data here:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.51,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
