import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/network.dart';
import 'package:translator/translator.dart';

class BallModel extends ChangeNotifier {
  // модель шара и его костыли
  bool isLoading = false;
  bool isError = false;
  bool isAnswered = false;
  String answer = "";

  Duration animationDuration = Duration(milliseconds: 2900);
  double startingPosition = -60; // Вертикальное положение в начале анимации
  double endingPosition = 60; // Вертикальное положение в конце анимации
  double ballSize = 280;

  void setPositions(int value) {
    startingPosition = -value.toDouble();
    endingPosition = value.toDouble();
    notifyListeners();
  }

  void setDuration(int value) {
    animationDuration = Duration(milliseconds: value);
    notifyListeners();
  }

  void setBallSize(int value) {
    ballSize = value.toDouble();
    notifyListeners();
  }

  void delayExecution() {
    Future.delayed(const Duration(seconds: 3), () {
      notifyListeners();
    });
  }

  void _translateText(String text) async {
    final translator = GoogleTranslator();
    translator.translate(text, from: 'en', to: 'ru').then((value) {
      answer = value.toString();
    });
  }

  void getAnswer() async {
    answer = "";
    isLoading = true;
    isError = false;
    notifyListeners();
    try {
      answer = await Network.getAnswer();
      if (answer == "Error") {
        isError = true;
        isAnswered = false;
      } else {
        isError = false;
        isAnswered = true;
        _translateText(answer);
      }
    } catch (e) {
      isError = true;
    }
    isLoading = false;
    delayExecution();
  }
}
