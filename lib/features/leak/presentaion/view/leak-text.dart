import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../core/widget/custom_buttom.dart';
import '../../../../core/widget/no test.dart';
import '../../data/model/acc_Branched.dart';
import '../../data/model/acc_looped.dart';
import '../../data/model/pressure.dart';
import '../../data/model/pressure_looped.dart';


class LeakText extends StatefulWidget {
  const LeakText({Key? key}) : super(key: key);
  @override
  State<LeakText> createState() => _LeakTextState();
}

class _LeakTextState extends State<LeakText> {
  // ignore: prefer_typing_uninitialized_variables
  var prediction;
  int ind = 0;
  List<String> img = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
  ];

  List<String> res = [
    'Circumferential Crack',
    'Gasket Leak',
    'ongitudinal Crack',
    'NonLeak',
    'Official Leak',
  ];
  CrossFadeState show = CrossFadeState.showSecond;
  List<List<dynamic>> _data = [];
  // ignore: non_constant_identifier_names
  late ClassifierAccLooped _ClassifierAccLooped;
  // ignore: non_constant_identifier_names
  late ClassifierPressureLooped _ClassifierPressureLooped;
  // ignore: non_constant_identifier_names
  late ClassifierAccBranched _ClassifierAccBranched;
  // ignore: non_constant_identifier_names
  late ClassifierPressureBranched _ClassifierPressureBranched;

  String? filePath;
  @override
  void initState() {
    super.initState();

    _ClassifierAccLooped = ClassifierAccLooped();
    _ClassifierPressureLooped = ClassifierPressureLooped();
    _ClassifierAccBranched = ClassifierAccBranched();
    _ClassifierPressureBranched = ClassifierPressureBranched();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Leak Data Text")),
        ),
        body: getBody());
  }

  Widget getBody() {
    if (_data.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NoTest(
            imageloc: "assets/images/file upload.png",
            hintText: "You must upload a csv file  ",
            disText:
                "This file consisting of one row. This row consists  8 of variables of type Double",
          ),
          SizedBox(
            height: 150.h,
          ),
          CustomBottom(
            titleText: "Upload CSV FIle",
            onBottom: () {
              _pickFile();
              setState(() {
                show = CrossFadeState.showSecond;
              });
            },
          ),
        ],
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
                  img[ind],
                  height: 100.h,
                  width: 100.w,
                ),
                Text(
                  "${res[ind]}",
                  style: TextStyle(fontSize: 30.sp, color: Colors.blue),
                ),
                SizedBox(
                  height: 200.h,
                )
              ],
            ),
          ),
          secondChild: SizedBox(
            height: 400.h,
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
        CustomBottom(
          titleText: "WaterLeak_acc_Branched",
          onBottom: () {
            setState(() {
              prediction =
                  _ClassifierAccBranched.classify(_data.reshape([1, 8, 1]));
              show = CrossFadeState.showFirst;
              double max = prediction.reduce((double currentMax, num element) =>
                  element > currentMax ? element.toDouble() : currentMax);
              ind = prediction.indexOf(max);
            });
          },
        ),
        CustomBottom(
          titleText: "waterleak-pressure-branched",
          onBottom: () {
            setState(() {
              print(_data);
              prediction = _ClassifierPressureBranched.classify(
                  _data.reshape([1, 8, 1]));
              show = CrossFadeState.showFirst;
              print(prediction);
              double max = prediction.reduce((double currentMax, num element) =>
                  element > currentMax ? element.toDouble() : currentMax);
              ind = prediction.indexOf(max);
            });
          },
        ),
        CustomBottom(
          titleText: "waterleak-acc-looped",
          onBottom: () {
            setState(() {
              print(_data);
              prediction =
                  _ClassifierAccLooped.classify(_data.reshape([1, 8, 1]));
              show = CrossFadeState.showFirst;
              print(prediction);
              double max = prediction.reduce((double currentMax, num element) =>
                  element > currentMax ? element.toDouble() : currentMax);
              ind = prediction.indexOf(max);
            });
          },
        ),
        CustomBottom(
          titleText: " waterleak-pressure-looped-cnn",
          onBottom: () {
            setState(() {
              print(_data);
              prediction =
                  _ClassifierPressureLooped.classify(_data.reshape([1, 8, 1]));
              show = CrossFadeState.showFirst;
              print(prediction);
              double max = prediction.reduce((double currentMax, num element) =>
                  element > currentMax ? element.toDouble() : currentMax);
              ind = prediction.indexOf(max);
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
