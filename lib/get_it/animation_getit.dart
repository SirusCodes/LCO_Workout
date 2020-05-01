import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:lco_workout/enum/card_status.dart';

class AnimationGetIt with ChangeNotifier {
  AnimationController controller;

  int unit = 0, ten = 0, hundred = 0, _time = 3;

  List<String> exerciseList = [], rawList = [];
  Queue _queue = Queue();

  CardStatus status = CardStatus.start;

  String nextExer = "";
  int nextExerInt = 0;

  void seperateTime() {
    unit = _time % 10;
    _time = _time ~/ 10;
    ten = _time % 10;
    _time = _time ~/ 10;
    hundred = _time % 10;
  }

  void nextTime() {
    switch (_queue.first) {
      case 'end':
        status = CardStatus.end;
        controller.reverse();
        break;
      case 'break':
        status = CardStatus.progress;
        controller.reverse();
        _time = 4;
        nextExer = exerciseList[++nextExerInt];
        notifyListeners();
        break;
      default:
        status = CardStatus.progress;
        controller.forward();
        _time = 6;
        break;
    }
    _queue.removeFirst();
    seperateTime();
  }

  void editList() {
    List<String> _rawList = List<String>.from(rawList);

    _queue.clear();
    nextExerInt = 0;
    nextExer = exerciseList[nextExerInt];
    // if someone starts the page then he will get a 3s wait
    _time = 3;
    status = CardStatus.start;
    // building queue
    for (var i = 0; i < 9; i++) {
      if (i.isEven) {
        _queue.add(_rawList.first);
        _rawList.removeAt(0);
      } else {
        _queue.add("break");
      }
    }
    _queue.add("end");
  }
}
