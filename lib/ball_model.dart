import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/network.dart';

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

        // answer = '';
      } else {
        isError = false;
        isAnswered = true;
      }
    } catch (e) {
      isError = true;
    }
    isLoading = false;
    delayExecution();
  }
}
