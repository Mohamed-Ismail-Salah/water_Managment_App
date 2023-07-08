import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/custom_buttom.dart';



class WaterLeak extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Water Leak")),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CustomBottom(titleText:"Leak Data Text", onBottom: (){
              Navigator.pushNamed(context, 'LeakText');
            },)

           ,

            SizedBox(height: 50.h,),
            CustomBottom(titleText:"Leak Data Voice", onBottom: (){
              Navigator.pushNamed(context, 'LeakVoice');
            },)




          ],
        ),
      ),
    );
  }

}