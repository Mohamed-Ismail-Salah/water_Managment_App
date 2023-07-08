import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widget/custom_buttom.dart';
 class FloodSelection extends StatelessWidget{
  const FloodSelection({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             CustomBottom(titleText:"Flood Segmentation", onBottom: (){
               Navigator.pushNamed(context, 'FloodSegmentation');
             },),
             SizedBox(height: 50.h,),
             CustomBottom(titleText:"Flood classification", onBottom: (){
               Navigator.pushNamed(context, 'Flood');
             },),

           ],
         ),
       ),
     );
  }

}