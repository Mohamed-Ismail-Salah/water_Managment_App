import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
 import 'package:water_managment/features/Home/presentaion/view/widget/list_body_home.dart';
  import '../../../../../core/App_Theme/thim_provider.dart';
import '../../../../information/view/about us.dart';
import '../../../../information/view/sensitization.dart';

class BottomNavigationBarChoose extends StatefulWidget{
  @override
  State<BottomNavigationBarChoose> createState() => _BottomNavigationBarChooseState();
}

class _BottomNavigationBarChooseState extends State<BottomNavigationBarChoose> {
  @override
   initState() {
    Provider.of<ThimProvider>(context,listen: false).getThemeMode();
  }
   int cindex=0;
  final _drawerController = ZoomDrawerController();
   List<Widget> bodyList=[
    ListBodyHome(),
    Sensitization(),
    AboutUs(),
  ];

  List<String> titleList=[
    "Home",
    "Sensitization",
    "About Us",
  ];


   @override

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
leading:IconButton(
  icon:const Icon(Icons.list) ,
  onPressed: (){
    ZoomDrawer.of(context)?.open();
  },
),
        title:  Center(
            child:Text(titleList[cindex])),
      ),
      body: bodyList[cindex],

        bottomNavigationBar:BottomBarBubble(
          selectedIndex:cindex,
          height: 50.h,
          bubbleSize: 10,
          color: Colors.blue,
backgroundColor:Colors.blue.shade50 ,
          items: [
            BottomBarItem(iconData: Icons.home),
            BottomBarItem(iconData: Icons.tips_and_updates),
            BottomBarItem(iconData: Icons.groups_outlined),
          ],
            onSelect: (index) {
            setState(() {
              cindex=index;
              });
            }
          ,),

    );
  }
}