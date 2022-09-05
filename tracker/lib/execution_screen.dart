import 'package:flutter/material.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/bottom_navigation_bar.dart';
import 'package:tracker/widgets/continue_button.dart';

class ExecutionScreen extends StatefulWidget {
  const ExecutionScreen({Key? key}) : super(key: key);

  @override
  State<ExecutionScreen> createState() => _ExecutionScreenState();
}

class _ExecutionScreenState extends State<ExecutionScreen> {
  final TextEditingController weightEditingController = TextEditingController();
  final TextEditingController repsEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Führe den 1. Satz aus:"),
      bottomNavigationBar: MyBottomNavigationBar(1),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Container(height: 300,
             child: GridView.count(shrinkWrap: true,crossAxisCount: 2, children: [MyLabel("Gewicht:"),MyTextField(
                        weightEditingController,
                        textInputType: TextInputType.number,
                      ),MyLabel("Wiederholungen:"), MyTextField(
                        repsEditingController,
                        textInputType: TextInputType.number,
                      ),MyLabel("Notiz:"), MyTextField(
                        noteEditingController,
                        textInputType: TextInputType.text,
                      ),]),
           ),
            ContinueButton(
              () {

              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyLabel extends StatelessWidget {
  const MyLabel(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headline5);
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.textEditingController,
      {Key? key, required this.textInputType})
      : super(key: key);

  final TextInputType textInputType;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Container(width: 100,height: 40,
      child: TextField(
        keyboardType: textInputType,
        controller: textEditingController,
      ),
    );
  }
}
