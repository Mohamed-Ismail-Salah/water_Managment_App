import 'package:flutter/material.dart';

class NoTest extends StatefulWidget {
  String imageloc;
  String hintText;
  String disText;
  NoTest(
      {super.key, this.imageloc = "assets/images/file upload.png",
      this.hintText = "You must upload a csv file ",
      this.disText =
          "this  file consisting of one row.This row consists  variables of type Double"});

  @override
  State<NoTest> createState() => _NoTestState();
}

class _NoTestState extends State<NoTest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
              height: 120,
              width: 120,
              child: Image.asset(
                widget.imageloc,
              )),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.hintText,
            style: const TextStyle(
                color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.disText,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
