import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/ball_model.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BallModel>(builder: (context, ballModel, child) {
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                                builder: (context) => const MagicBallScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFFFFFFFF),
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 8)
                      ],
                    ),
                    const Text(
                      'Настройки',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff727272), fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Скорость анимации',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff727272), fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    Slider(
                      value: ballModel.animationDuration.inMilliseconds.toDouble(),
                      onChanged: (value) {
                        ballModel.setDuration(value.toInt());
                      },
                      min: 200,
                      max: 3000,
                      divisions: 100,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Высота анимации',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff727272), fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    Slider(
                      value: ballModel.endingPosition,
                      onChanged: (value) {
                        ballModel.setPositions(value.toInt());
                      },
                      min: 20,
                      max: 120,
                      divisions: 100,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Размер шара',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff727272), fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    Slider(
                      value: ballModel.ballSize,
                      onChanged: (value) {
                        ballModel.ballSize = value;
                        ballModel.setBallSize(value.toInt());
                      },
                      min: 100,
                      max: 300,
                      divisions: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
