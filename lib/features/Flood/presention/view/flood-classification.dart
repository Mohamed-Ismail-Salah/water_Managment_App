import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:tflite/tflite.dart';

class FloodClassification extends StatefulWidget {
  const FloodClassification({Key? key}) : super(key: key);

  @override
  State<FloodClassification> createState() => _FloodClassificationState();
}

class _FloodClassificationState extends State<FloodClassification> {
  late File _image;
  bool _busy = false;
  CrossFadeState show = CrossFadeState.showSecond;
  late List _results;
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
        model: 'assets/modles/flood/classification/classification.tflite',
        labels: 'assets/modles/flood/classification/label.txt',
      ))!;
    }
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
      _busy = false;
      show = CrossFadeState.showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:   Text("Flood       ")),
      ),
      body: ListView(
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Stack(
                children: [
                  Column(
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
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  _busy
                      ? Center(
                          child: SizedBox(
                            height: 500.h,
                            child: LoadingBouncingGrid.circle(
                              borderColor: Colors.blue.withOpacity(0.5),
                              borderSize: 3.0,
                              size: 150.0,
                              backgroundColor: Colors.blue.withOpacity(0.5),
                              duration: const Duration(milliseconds: 500),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            firstChild: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: (imageSelect)
                        ? [
                            Container(
                              decoration: BoxDecoration(),
                              margin: const EdgeInsets.all(10),
                              child: Image.file(_image),
                            ),
                            Column(
                              children: (imageSelect)
                                  ? _results.map((result) {
                                      return Card(
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Text(
                                            "${result['label']} - ${result['confidence'].toStringAsFixed(1)}",
                                            style:   TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  : [],
                            ),
                          ]
                        : [],
                  ),
                  _busy
                      ? Center(
                          child: SizedBox(
                            height: 500.h,
                            child: LoadingBouncingGrid.circle(
                              borderColor: Colors.blue.withOpacity(0.5),
                              borderSize: 3.0,
                              size: 150.0,
                              backgroundColor: Colors.blue.withOpacity(0.5),
                              duration: const Duration(milliseconds: 500),
                            ),
                          ),
                        )
                      : Container()
                ],
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
    if (image ==null) {
      return;
    }
    setState(() {
      _busy = true;
    });
    imageClassification(image);
  }
}
