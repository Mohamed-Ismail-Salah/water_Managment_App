import 'package:flutter/material.dart';
import 'package:auto_animated/auto_animated.dart';

import '../../../../../core/widget/body_list.dart';



class ListBodyHome extends StatelessWidget {
  final options = const LiveOptions(
    delay: Duration(milliseconds: 200),
    showItemInterval: Duration(milliseconds: 200),
    showItemDuration: Duration(milliseconds: 200),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );
  List<String> pathImageList = [
    "assets/images/flood_background.jpg",
    "assets/images/rain_background.jpg",
    "assets/images/wastewater-treatment -background.jpg",
    "assets/images/water meter background.jpg",
    "assets/images/Water quality  background.jpeg",
    "assets/images/water-leak background.jpg"
  ];
  List<String> titleList = [
    "Flood",
    "rain",
    "water treatment",
    "water meters",
    "water quality",
    "Water Leak",
  ];
  List<String> descriptionList = [
    '''
Connecting to the satellite and taking a picture from it of the places where we want to predict the occurrence of torrential rains 
    ''',
    ''' 
Predicting the occurrence of rain, as information is collected that affects it on the occurrence of rain
    ''',
    ''' 
a group of sensors to determine the amount of energy and dxygen needed to purify water to determine if the cost of the process is within the permissible cost
    ''',
    ''' 
A sensor connected to the meter makes the user keep track of his consumption rate
    ''',
    ''' 
A sensor that measures the Quality of water and sends notifications of its contents and send notifications of its contents and determines if it is fit for consumption
    ''',
    '''
Send notifications to the application when a leak occurs, and the type of the leak
    ''',
  ];

  List<String> screenLocationList = [
    'FloodClassification',
    'Rain',
    'WaterTreatment',
    'WaterMeter',
    'WaterQuality',
    'LeakText'
  ];

  ListBodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiveList.options(
      padding: const EdgeInsets.all(8),
      itemCount: pathImageList.length,
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) {
        return FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: BodyList(
              descriptionText: descriptionList[index],
              pathImage: pathImageList[index],
              titleText: titleList[index],
              screenLocation: screenLocationList[index],
            ));
      },
      options: options,
    );



  }
}
