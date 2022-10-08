import 'package:flutter/material.dart';
import 'package:tracker/warm_up_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/bottom_navigation_bar.dart';

import 'models/training.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({Key? key}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Tracker"),
      bottomNavigationBar: MyBottomNavigationBar(1),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                100,
              ),
            ),
          ),
          child: StatefulBuilder(builder: (context, setState) {
            if (!_isLoading) {
              return IconButton(
                iconSize: 100,
                color: Colors.green,
                icon: Icon(
                  Icons.play_arrow_rounded,
                  size: 100,
                ),
                onPressed: () async {
                  double bodyweight = await showDialog(
                      context: context,
                      builder: (context) {
                        return BodyWeightDialog();
                      });
                  setState(() {
                    _isLoading = true;
                  });
                  Training training = await Training.create(bodyweight);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WarmUpScreen(training),
                      ));
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}

class BodyWeightDialog extends StatefulWidget {
  const BodyWeightDialog({Key? key}) : super(key: key);

  @override
  State<BodyWeightDialog> createState() => _BodyWeightDialogState();
}

class _BodyWeightDialogState extends State<BodyWeightDialog> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              if (textEditingController.text != "") {
                Navigator.pop(
                    context, double.parse(textEditingController.text));
              }
            },
            child: Text("Ok"))
      ],
      title: Text("Körpergewicht eingeben:"),
      content: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
