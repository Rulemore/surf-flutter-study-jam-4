import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/ball_widget.dart';
import 'package:surf_practice_magic_ball/screen/settings_screen.dart';

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
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFFFFFFFF),
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 8)
                  ],
                ),
                BallWidget(),
                const SizedBox(height: 40),
                const Text(
                  'Нажмите на шар \n или потрясите телефон',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff727272), fontSize: 20),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
