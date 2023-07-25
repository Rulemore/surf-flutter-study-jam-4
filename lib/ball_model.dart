import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/network.dart';
import 'package:translator/translator.dart';

class BallModel extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isAnswered = false;
  String answer = "";

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
