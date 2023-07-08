import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:water_managment/features/Home/presentaion/view/widget/bottom%20Navigation%20Bar.dart';
  import 'package:water_managment/features/Home/presentaion/view/home.dart';
import 'package:water_managment/features/Home/presentaion/view/widget/list_body_home.dart';

import 'core/App_Theme/AppThemeData.dart';
import 'core/App_Theme/thim_provider.dart';
import 'features/Flood/presention/view/flood-classification.dart';
import 'features/Flood/presention/view/flood.dart';
 import 'features/leak/presentaion/view/leak-text.dart';
import 'features/leak/presentaion/view/leak-voice.dart';
import 'features/leak/presentaion/view/water-Leak-screen.dart';
 import 'features/meter/presentaion/view/meter.dart';
import 'features/quality/presentaion/view/water-quality-screen.dart';
import 'features/rain/presentaion/view/rain-screen.dart';
import 'features/treatment/presention/view/water-treatment-screen.dart';

void main() {
  runApp(ChangeNotifierProvider<ThimProvider>(
      child: const MyApp() ,
      create:(context)=>ThimProvider(),
  )  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context , child) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          'BottomNavigationBarChoose': (context) => BottomNavigationBarChoose(),
          'ListBodyHome': (context) => ListBodyHome(),
          'Rain': (context) => Rain(),
          'FloodClassification': (context) => const FloodClassification(),
          'FloodSelection': (context) => const FloodSelection(),
           'WaterTreatment': (context) => const WaterTreatment(),
          'WaterMeter': (context) => const WaterMeterView(),
          'WaterQuality': (context) => WaterQuality(),
          'WaterLeak': (context) => WaterLeak(),
          'LeakText': (context) => const LeakText(),
          'LeakVoice': (context) => LeakVoice(),
        },
        debugShowCheckedModeBanner: false,
        themeMode: Provider.of<ThimProvider>(context).thememMode,
        darkTheme: AppTheme.appDarkThemeData,
        theme: AppTheme.appLightThemeData,
    );

        }
      );
  }
}
