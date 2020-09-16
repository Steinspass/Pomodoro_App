import 'package:flutter/material.dart';


class TimerItemModel{
  final TypeTimer type;
  final String title;
  final Color color;
  final int time;

  TimerItemModel({
    @required this.type,
    this.title,
    this.color,
    this.time
  });
}

enum TypeTimer{
  timeWork,
  timeBreak,
  timeRest,
  workComplete
}