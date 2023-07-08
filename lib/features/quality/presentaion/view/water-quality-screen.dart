import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../core/widget/custom_buttom.dart';
import '../../../../core/widget/no test.dart';
import '../../data/model/water-qualit1.dart';
import '../../data/model/water-qualit2.dart';




class WaterQuality extends StatefulWidget {
  @override
  State<WaterQuality> createState() => _WaterQualityState();
}

class _WaterQualityState extends State<WaterQuality> {
  var prediction;
  String img="assets/images/2226178.png";
  String isSafe="This water is good and safe to use";
  List<List<dynamic>> _data = [];
  String resulting = "";
  CrossFadeState show = CrossFadeState.showSecond;
  late ClassifierWater1 _classifier;
  late ClassifierWater2 _classifier2;
  String? filePath;

  @override
  void initState() {
    super.initState();

    _classifier = ClassifierWater1();
    _classifier2 = ClassifierWater2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Water Quality")),
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
                  img,
                  height: 100.h,
                  width: 100.w,
                ),
                Text(
                  prediction == null ? "" : "${isSafe}",
                  style: const TextStyle(fontSize: 30, color: Colors.blue),
                ),
                SizedBox(
                  height: 250.h,
                )
              ],
            ),
          ),
          secondChild: SizedBox(
            height: 500,
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
                            padding:
                                const EdgeInsets.only(right: 20, left: 20),
                            child: Text("${index + 1}",
                                style:   TextStyle(
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
                              style:   TextStyle(
                                  fontSize: 30.sp, color: Colors.blue)),
                        ],
                      )),
                );
              },
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            maximumSize: MaterialStateProperty.all(const Size(200, 40)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            textStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return   TextStyle(
                  fontSize: 35.sp,
                );
              }
              return   TextStyle(
                fontSize: 20.sp,
              );
            }),
          ),
          child: const Text(
            "Water Quality1",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              print(_data.reshape([1, 9, 1]));
              prediction = _classifier.classify(_data.reshape([1, 9, 1]));
              print(prediction);
              if(prediction[0]>0)
              {
                isSafe="This water is good and safe to use";
                img="assets/images/2226178.png";
              }
              else{
                isSafe="This water is bad and unusable";
                img="assets/images/2482684.png";
              }


              show = CrossFadeState.showFirst;
            });
          },
        ),
        SizedBox(height: 20.h,),
        ElevatedButton(
          style: ButtonStyle(
            maximumSize: MaterialStateProperty.all(const Size(200, 40)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            textStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return   TextStyle(
                  fontSize: 35.sp,
                );
              }
              return   TextStyle(
                fontSize: 20.sp,
              );
            }),
          ),
          child: const Text(
            "Water Quality2",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              print(_data);
              prediction = _classifier2.classify(_data.reshape([1, 16, 1]));
              print(prediction);
              if(prediction[0]>0)
              {
                isSafe="This water is good and safe to use";
                img="assets/images/2226178.png";
              }
              else{
                isSafe="This water is bad and unusable";
                img="assets/images/2482684.png";
              }


              show = CrossFadeState.showFirst;
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
