import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../core/widget/custom_buttom.dart';
import '../../../../core/widget/no test.dart';
import '../../data/model/rain_modle.dart';



class Rain extends StatefulWidget {
  @override
  State<Rain> createState() => _RainState();
}

class _RainState extends State<Rain> {
  final snackBar = const SnackBar(
    content: Text('Please make sure that the file contains 21 items!'),
  );

  var prediction;
  String resulting = "";
  CrossFadeState show = CrossFadeState.showSecond;
  List<List<dynamic>> _data = [];
  late Classifier _classifier;
  String? filePath;
  @override
  void initState() {
    super.initState();

    _classifier = Classifier();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Rain           ")),
        ),
        body: getBody());
  }

  Widget getBody() {
    if (_data.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            NoTest(),
            Flexible(
              child: SizedBox(
                height: 150.h,
              ),
            ),
            CustomBottom(
              titleText: "Upload CSV FIle",
              onBottom: () {
                _pickFile();
              },
            )
          ],
        ),
      );
    } else {
      return Column(children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 400),
          crossFadeState: show,
          firstChild: Center(
            child: Column(
              children: [
                Image.asset(
                  resulting == "IS Rain"
                      ? "assets/images/rain.gif"
                      : "assets/images/no rain.gif",
                  height: 200.h,
                  width: 200.w,
                ),
                Text(
                  resulting,
                  style: TextStyle(fontSize: 30.sp, color: Colors.blue),
                ),
                SizedBox(
                  height: 100.sp,
                )
              ],
            ),
          ),
          secondChild: Container(
            child: SizedBox(
              height: 450.h,
              child: ListView.builder(
                itemCount: _data[0].length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Card(
                        margin: const EdgeInsets.all(3),
                        color: Colors.blue.shade50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20, left: 20),
                              child: Text("${index + 1}",
                                  style: TextStyle(
                                      fontSize: 30.sp, color: Colors.black)),
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 30.w,
                              child: VerticalDivider(
                                width: 20.w,
                                color: Colors.black,
                              ),
                            ),
                            Text("${_data[0][index]}",
                                style: TextStyle(
                                    fontSize: 30.sp, color: Colors.blue)),
                          ],
                        )),
                  );
                },
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            maximumSize: MaterialStateProperty.all(  Size(200, 40)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            textStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return TextStyle(
                  fontSize: 35.sp,
                );
              }
              return TextStyle(
                fontSize: 20.sp,
              );
            }),
          ),
          child: const Text(
            "Input Test",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              print(_data);
              try {
                prediction = _classifier.classify(_data.reshape([1, 21, 1]));
                print(prediction);
                show = CrossFadeState.showFirst;
                prediction[0] > .5
                    ? resulting = "IS Rain"
                    : resulting = "NOT Rain";
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              ;
            });
          },
        ),
        SizedBox(
          height: 50.h,
        ),
        ElevatedButton(
          style: ButtonStyle(
            maximumSize: MaterialStateProperty.all(const Size(300, 40)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            textStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return TextStyle(
                  fontSize: 35.sp,
                );
              }
              return TextStyle(
                fontSize: 20.sp,
              );
            }),
          ),
          child: const Text(
            "Upload new CSV FIle",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _pickFile();
            setState(() {
              show = CrossFadeState.showSecond;
            });
          },
        ),
      ]);
    }
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    print(result.files.first.name);
    filePath = result.files.first.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);

    setState(() {
      _data = fields;
    });
  }
}
