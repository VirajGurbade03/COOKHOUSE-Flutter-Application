import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';

class Option {
  String name;
  bool isSelected;
  double value;

  Option({required this.name, this.isSelected = false, required this.value});
}

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final List<Option> activity = [
    Option(name: 'Sleeping', isSelected: false, value: 0.7),
    Option(name: 'Reclining', isSelected: false, value: 0.8),
    Option(name: 'Seated, quiet', isSelected: false, value: 1.0),
    Option(name: 'Reading, seated', isSelected: false, value: 1.0),
    Option(name: 'Writing', isSelected: false, value: 1.0),
    Option(name: 'Typing', isSelected: false, value: 1.1),
    Option(name: 'Standing, relaxed', isSelected: false, value: 1.2),
    Option(name: 'Filing, seated', isSelected: false, value: 1.2),
    Option(name: 'Filing, standing', isSelected: false, value: 1.4),
    Option(name: 'Walking about', isSelected: false, value: 1.7),
    Option(name: 'Cooking', isSelected: false, value: 1.8),
    Option(name: 'Table sawing', isSelected: false, value: 1.8),
    Option(name: 'Walking 2mph (3.2kmh)', isSelected: false, value: 2.0),
    Option(name: 'Lifting/packing', isSelected: false, value: 2.1),
    Option(name: 'Seated, heavy limb movement', isSelected: false, value: 2.2),
    Option(name: 'Light machine work', isSelected: false, value: 2.2),
    Option(name: 'Walking 3mph (4.8kmh)', isSelected: false, value: 2.6),
    Option(name: 'House cleaning', isSelected: false, value: 2.7),
    Option(name: 'Driving, heavy vehicle', isSelected: false, value: 3.2),
    Option(name: 'Dancing', isSelected: false, value: 3.4),
    Option(name: 'Calisthenics', isSelected: false, value: 3.5),
    Option(name: 'Walking 4mph (6.4kmh)', isSelected: false, value: 3.8),
    Option(name: 'Tennis', isSelected: false, value: 3.8),
    Option(name: 'Heavy machine work', isSelected: false, value: 4.0),
    Option(name: 'Handling 100lb (45 kg) bags', isSelected: false, value: 4.0),
  ];

  final DatabaseReference _databaseRef = FirebaseDatabase.instance
      .ref()
      .child('/D1/Application/Activity Selected');

  void _onOptionChanged(bool? value, int index) {
    setState(() {
      for (var i = 0; i < activity.length; i++) {
        activity[i].isSelected = i == index ? value ?? false : false;
      }
    });
  }

  void _submitData() {
    final selectedOption = activity.firstWhere((option) => option.isSelected,
        orElse: () => Option(name: 'None', value: 0.0));

    if (selectedOption.isSelected) {
      _databaseRef.set({
        'Activity': selectedOption.name,
        'MET': selectedOption.value,
      }).then((_) {
        // Show the SnackBar after successful data submission
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your activity is recorded"),
          ),
        );
        print('Data submitted');
      }).catchError((error) {
        // Handle errors and show a SnackBar with the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to submit data: $error"),
          ),
        );
        print('Failed to submit data: $error');
      });
    } else {
      // Show a SnackBar if no option is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No option selected"),
        ),
      );
      print('No option selected');
    }
  }

  Widget _buildOptionList(
      String title, List<Option> options, void Function(bool?, int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width *
                0.05, // Responsive font size
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        ...options.asMap().entries.map(
              (entry) => ListTile(
                title: Text(
                  entry.value.name,
                  style: const TextStyle(color: Colors.white),
                ),
                leading: Radio<bool>(
                  value: true,
                  groupValue: entry.value.isSelected,
                  onChanged: (bool? value) {
                    onChanged(value, entry.key);
                  },
                ),
              ),
            ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
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
                const SizedBox(width: 15),
                const Text(
                  "Activities",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.07,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: _buildOptionList(
                  'Set your current activity status..!'
                      .toUpperCase(), // Uppercase title for emphasis
                  activity,
                  _onOptionChanged,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centered buttons
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.6, // 60% of screen width
                    height: 48,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: CupertinoButton(
                      onPressed: _submitData,
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Color.fromARGB(255, 60, 60, 60),
                            fontSize: 16.23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
