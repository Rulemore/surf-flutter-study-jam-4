import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/ball_widget.dart';

class MagicBallScreen extends StatelessWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff000002), Color(0xff100C2C)]),
            ),
            // ignore: prefer_const_constructors
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(height: 35),
                BallWidget(),
                SizedBox(height: 40),
                Text(
                  'Нажмите на шар \n или потрясите телефон',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff727272), fontSize: 20),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
