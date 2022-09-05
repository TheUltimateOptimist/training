import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  ContinueButton(this.onPressed, {Key? key}) : super(key: key);

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(fixedSize: Size(200, 60),
        
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "Fahre Fort",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          Icon(
            Icons.arrow_forward,
          ),
        ],
      ),
    );
  }
}
