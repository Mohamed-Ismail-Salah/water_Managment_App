import 'package:flutter/material.dart';

import 'custom_buttom.dart';


class BodyList extends StatefulWidget {
  String pathImage;
  String titleText;
  String descriptionText;
  String screenLocation;
  BodyList(
      {super.key, required this.descriptionText,
      required this.pathImage,
      required this.titleText,
      required this.screenLocation});

  @override
  State<BodyList> createState() => _BodyListState();
}

class _BodyListState extends State<BodyList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade200],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.7, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(widget.pathImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    widget.descriptionText,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: "Khand-Regular",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomBottom(
                  titleText: widget.titleText,
                  onBottom: () {
                    Navigator.pushNamed(context, widget.screenLocation);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
