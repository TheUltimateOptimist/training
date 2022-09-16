import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar(String title,
      {Key? key, bool showQuit = false, void Function()? onPressed})
      : super(
          key: key,automaticallyImplyLeading: false,
          title: Text(title),
          actions: showQuit
              ? [
                  TextButton(
                    onPressed: onPressed,
                    child: Text(
                      "Beenden",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ]
              : null,
        );
}
