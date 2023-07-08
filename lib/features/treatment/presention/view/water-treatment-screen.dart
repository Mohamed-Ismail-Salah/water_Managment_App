import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../../core/widget/custom_buttom.dart';
import '../../../../core/widget/no test.dart';
import '../../data/model/Biological-Oxygen-Demand_modle.dart';
import '../../data/model/Chemical-Oxygen-Demand_modle.dart';
import '../../data/model/Energy-Consumption.dart';

class WaterTreatment extends StatefulWidget {
  const WaterTreatment({Key? key}) : super(key: key);

  @override
  State<WaterTreatment> createState() => _WaterTreatmentState();
}

class _WaterTreatmentState extends State<WaterTreatment> {
  // ignore: prefer_typing_uninitialized_variables
  var prediction;
  String img = "assets/images/5010272.png";
  String resulting = "";
  CrossFadeState show = CrossFadeState.showSecond;
  List<List<dynamic>> _data = [];
  // ignore: non_constant_identifier_names
  late ClassifierBiologicalOxygenDemand _ClassifierBiologicalOxygenDemand;
  // ignore: non_constant_identifier_names
  late ClassifierChemicalOxygenDemand _ClassifierChemicalOxygenDemand;
  // ignore: non_constant_identifier_names
  late ClassifierEnergyConsumption _ClassifierEnergyConsumption;

  String? filePath;
  @override
  void initState() {
    super.initState();
    _ClassifierBiologicalOxygenDemand = ClassifierBiologicalOxygenDemand();
    _ClassifierChemicalOxygenDemand = ClassifierChemicalOxygenDemand();
    _ClassifierEnergyConsumption = ClassifierEnergyConsumption();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Water Treatment")),
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Flexible(
                        child: Text(
                          prediction == null ? '' : " ${prediction}",
                          style:
                              const TextStyle(fontSize: 30, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                )
              ],
            ),
          ),
          secondChild: SizedBox(
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
        CustomBottom(
          titleText: "Energy Consumption",
          onBottom: () {
            setState(() {
              print(_data);
              prediction =
                  "the amount of energy you need\n             ${_ClassifierEnergyConsumption.classify(_data.reshape([
                    1,
                    15,
                    1
                  ]))}";
              print(prediction);
              img = "assets/images/9715681.png";
              show = CrossFadeState.showFirst;
            });
          },
        ),
        CustomBottom(
          titleText: "Chemical Oxygen Demand",
          onBottom: () {
            setState(() {
              print(_data);
              prediction =
                  "the amount of Chemical Oxygen you need${_ClassifierChemicalOxygenDemand.classify(_data.reshape([
                    1,
                    15,
                    1
                  ]))}";
              print(prediction);
              img = "assets/images/5010272.png";
              show = CrossFadeState.showFirst;
            });
          },
        ),
        CustomBottom(
          titleText: "Biological Oxygen Demand",
          onBottom: () {
            setState(() {
              print(_data);
              prediction =
                  "the amount of Biological \n      Oxygen you need\n    ${_ClassifierBiologicalOxygenDemand.classify(_data.reshape([
                    1,
                    15,
                    1
                  ]))}";
              print(prediction);
              img = "assets/images/8295395.png";
              show = CrossFadeState.showFirst;
            });
          },
        )
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
