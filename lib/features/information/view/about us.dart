import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 150.h,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        topRight: Radius.circular(80)),
                    color: Colors.blue.shade100),
                child: Center(
                    child: Image.asset(
                  "assets/images/logo.png",
                  height: 200.h,
                  width: 250.w,
                ))),
            Center(
                child: Text(
              "We are Infinity loop team",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            )),
            Text("Main idea:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            const Text(''' 
Our smart water management project aims to create smart cities, as this is done by linking artificial intelligence and the Internet of Things to manage water in a smarter and easier way by forecasting climate changes, monitoring and analyzing water use patterns, detecting leaks, predicting and improving them. Distribution networks lead to more efficient and sustainable water management as smart cities can reduce water waste, conserve resources and improve overall water management infrastructure
          '''),
            Center(
                child: Text(
              "Some solutions we offer",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            )),
            Text("Rain and Flood Forecasting:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            const Text(''' 
We can use AI and IoT technologies to collect real-time weather data and predict the probability of precipitation and flooding. This information can be used to better manage water resources, prepare for potential floods, and improve emergency response times.
            '''),
            Text("Identify water leaks:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            const Text(''' 
 We can use IoT sensors to detect water leaks in real time and alert maintenance teams to address the problem before it becomes a bigger problem. This helps conserve water and prevent water wastage, and we can also help water intake companies identify water leaks faster which leads to lower costs and faster resolution of the problem.
             '''),
            Text("Determine the water consumption of the facilities:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            const Text(''' 
 We can install smart meters in buildings and facilities to monitor water usage in real time. This information can be analyzed using artificial intelligence algorithms to identify patterns and trends in water consumption, allowing for more efficient and sustainable water management.
              '''),
            Text("Determination of water quality:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            const Text(''' 
 We can use IoT sensors to monitor water quality in real time, including factors such as pH levels, temperature, and chemical levels. This information can be used to identify potential water pollution and take appropriate action to address it.
               '''),
            Text("water treatment :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            const Text(''' 
 Based on the results of water quality monitoring, we can use artificial intelligence algorithms to determine the most efficient and effective way to treat water. This can include determining the amount of energy required to treat water, optimizing the process to conserve resources and reduce waste.
                '''),
          ],
        ),
      ),
    );
  }
}
