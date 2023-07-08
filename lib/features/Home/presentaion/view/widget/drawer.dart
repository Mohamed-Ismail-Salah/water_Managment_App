import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolling_switch/rolling_switch.dart';
import '../../../../../core/App_Theme/thim_provider.dart';

class DrawerScreen extends StatelessWidget{
  const DrawerScreen({super.key});
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            RollingSwitch.icon(
              initialState:Provider.of<ThimProvider>(context,listen: false).act,
              onChanged: (bool state) {

                 Provider.of<ThimProvider>(context,listen: false).changingMode(state);
              },
              rollingInfoRight: const RollingIconInfo(
                icon: Icons.sunny,
                text: Text('Light'),
              ),
              rollingInfoLeft: const RollingIconInfo(
                icon: Icons.dark_mode,
                backgroundColor: Colors.grey,
                text: Text('Dark'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}