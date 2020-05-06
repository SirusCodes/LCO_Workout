import 'dart:collection';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lco_workout/constants.dart';
import 'package:lco_workout/enum/card_status.dart';

class AnimationGetIt with ChangeNotifier {
  AnimationController controller;

  AssetsAudioPlayer _player = AssetsAudioPlayer();
  AssetsAudioPlayer get getPlayer => _player;

  List<String> musicList = [];

  int currentSet, _count;

  int unit = 0, ten = 0, hundred = 0, _time = startTime, setNum;

  List<String> exerciseList = [], rawList = [];
  List<int> _timeList = [];

  set setTime(List<int> list) {
    _timeList.clear();
    _timeList = list;
  }

  CardStatus get getState {
    _player.currentPosition.listen((position) {
      if (position == _player.current.value.audio.duration) {}
    });
    return this.status;
  }

  set setState(CardStatus status) {
    switch (status) {
      case CardStatus.paused:
        _player.pause();
        break;
      case CardStatus.progress:
        _player.play();
        break;
      case CardStatus.start:
        break;
      case CardStatus.end:
        _player.stop();
        break;
    }
    this.status = status;
  }

  Queue _nextQueue = Queue();

  CardStatus status = CardStatus.start;

  String nextExer = "";
  String imgExer = "";
  String currentExer = "";
  int nextExerInt = 0;
  int imgExerInt = 0;

  void seperateTime() {
    unit = _time % 10;
    _time = _time ~/ 10;
    ten = _time % 10;
    _time = _time ~/ 10;
    hundred = _time % 10;
  }

  void nextTime() {
    switch (_nextQueue.first) {
      case 'end':
        status = CardStatus.end;
        controller.reverse();
        notifyListeners();
        _player.stop();
        break;
      case 'break':
        status = CardStatus.progress;
        controller.reverse();
        _time = breakTime;
        _player.stop();
        break;
      default:
        status = CardStatus.progress;
        if (_count == 5) {
          currentSet++;
          _count = 0;
        }
        _count++;
        _time = _timeList[imgExerInt];
        // music
        _player.open(
          Audio("assets/music/" + musicList[imgExerInt]),
          showNotification: false,
          autoStart: true,
          respectSilentMode: true,
        );

        if (imgExerInt <= 4)
          imgExer = rawList[imgExerInt++];
        else {
          imgExerInt = 0;
          imgExer = rawList[imgExerInt++];
        }
        currentExer = nextExer;
        // since there is an end keyword
        if (_nextQueue.length > 2) {
          // since at start nextInt is 0
          if (nextExerInt >= 4) nextExerInt = -1;

          nextExer = exerciseList[++nextExerInt];
          notifyListeners();
        } else {
          nextExer = "Completed!!!";
          notifyListeners();
        }
        controller.forward();

      // _time = exerTime; //!  TODO: Remove this in final release
    }

    _nextQueue.removeFirst();
    seperateTime();
  }

  void editList() {
    _nextQueue.clear();

    currentSet = 0;
    _count = 0;
    // sets img to start position
    imgExerInt = 0;
    imgExer = rawList[imgExerInt];
    // sets next to start position
    nextExerInt = 0;
    nextExer = exerciseList[nextExerInt];
    // if someone starts the page then he will get a 3s wait
    _time = 3;
    status = CardStatus.start;
    // building queue
    for (var j = 0; j < setNum; j++) {
      List<String> _rawList = List<String>.from(rawList);
      for (var i = 0; i < 9; i++) {
        if (i.isEven) {
          _nextQueue.add(_rawList.first);
          _rawList.removeAt(0);
        } else {
          _nextQueue.add("break");
        }
      }
      _nextQueue.add("break");
    }
    _nextQueue.removeLast();
    _nextQueue.add("end");
  }

  getMusic() {
    Random _rand = Random();
    musicList.clear();

    musicList = List<String>.from(musics);
    musicList.add(musics[_rand.nextInt(3)]);
    musicList.shuffle();

    musicList.forEach((f) => print(f));
  }
}
