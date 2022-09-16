import 'package:flutter/material.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/my_timer.dart';
import 'package:tracker/widgets/app_bar.dart';

import 'package:tracker/widgets/continue_button.dart';

class WarmUpScreen extends StatefulWidget {
  const WarmUpScreen(this.sessionId, {Key? key}) : super(key: key);

  final int sessionId;

  @override
  State<WarmUpScreen> createState() => _WarmUpScreenState();
}

class _WarmUpScreenState extends State<WarmUpScreen> {
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: ContinueButton(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseSelectionScreen(widget.sessionId),
                  ));
            }),floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: MyAppBar("WarmUp"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wärm dich auf!",
              style: Theme.of(context).textTheme.headline3,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: MyTimer()
            ),
            
          ],
        ),
      ),
    );
  }
}
