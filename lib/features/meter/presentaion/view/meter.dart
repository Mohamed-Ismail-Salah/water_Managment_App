import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class WaterMeterView extends StatefulWidget {
  const WaterMeterView({super.key});

  @override
  State<WaterMeterView> createState() => _WaterMeterViewState();
}

class _WaterMeterViewState extends State<WaterMeterView> {
  late File _image;
  late List _results;
  CrossFadeState show = CrossFadeState.showSecond;
  bool imageSelect = false;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    Tflite.close();

    String res;
    {
      res = (await Tflite.loadModel(
        model: 'assets/modles/waterMeters/Meter.tflite',
        labels: 'assets/modles/waterMeters/labels.txt',
      ))!;
    }
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 10,
      threshold: 0.05,
      imageMean: 255,
      imageStd: 255,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
      show = CrossFadeState.showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:   Text("Water Meter")),
      ),
      body: ListView(
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SizedBox(
                      height: 220.h,
                      width: 150.w,
                      child: Image.asset(
                        "assets/images/uplod image.png",
                      )),
                   Center(
                    child: Text(
                      ' Please select a photo for a test',
                      style:   TextStyle(
                          color: Colors.blue,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            firstChild: SingleChildScrollView(
              child: Column(
                children: (imageSelect)
                    ? _results.map((result) {
                        return Center(
                          child: Column(

                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: SizedBox(
                                    height: 200.h,
                                    child: Image.file(_image)),
                              ),
                              Card(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "${result['label']}",
                                    style:   TextStyle(
                                        color: Colors.blue, fontSize: 20.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()
                    : [],
              ),
            ),
            crossFadeState: show,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "Pick Image",
        child: const Icon(Icons.image),
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}
