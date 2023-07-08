import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'widget/drawer.dart';
import 'widget/bottom Navigation Bar.dart';

class Home extends StatelessWidget{
  final drawerController = ZoomDrawerController();
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor:Theme.of(context).canvasColor,
      controller: drawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen:const DrawerScreen(),
      mainScreen:BottomNavigationBarChoose(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.white,
      slideWidth: MediaQuery.of(context).size.width*.65,
       openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }

}