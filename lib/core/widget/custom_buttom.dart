import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  String titleText;
  Function onBottom;
  CustomBottom({super.key, required this.titleText, required this.onBottom});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          textStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const TextStyle(
                fontSize: 35,
              );
            }
            return const TextStyle(
              fontSize: 20,
            );
          }),
        ),
        child: Text(
          titleText,
          style: TextStyle(color:Theme.of(context).textTheme.headline1?.color),
        ),
        onPressed: () {
          onBottom();
        });
  }
}
