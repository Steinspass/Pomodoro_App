

import 'package:flutter/material.dart';
import 'package:pomodoro/model/timer_model.dart';
import 'package:pomodoro/preferences/shared_preferences.dart';

class TimerRepository{

  final Preferences prefs = new Preferences(); 
  final List<TimerItemModel> listCompleteTimers = new List<TimerItemModel>();

  List<TimerItemModel> getTimerCompletedList(){
    final List<TimerItemModel> listTimersPomodoro = new List<TimerItemModel>();
    final List<TimerItemModel> listTimers = new List<TimerItemModel>();

    int totalPomodoro = prefs.getTotalPomodoro;
    int totalRest = prefs.getTotalPomodoro;

    for (var i = 0; i < totalPomodoro; i++) {
      

      List<TimerItemModel> listRoundTimers = _getTimerRoundList();


       if(totalRest != 0){
        TimerItemModel timer = new TimerItemModel(
          type: TypeTimer.timeRest,
          title: 'Time a rest',
          color: Colors.grey[600],
          time: prefs.getTimeRest
        );

        listTimers.add(timer);
        totalRest --;
      }   

      
      listTimersPomodoro.addAll(listRoundTimers);
      if(totalRest == 0) break;
      listTimersPomodoro.addAll(listTimers);
      listTimers.clear();
    }


    listCompleteTimers.addAll(listTimersPomodoro);

    TimerItemModel timer = new TimerItemModel(
          type: TypeTimer.workComplete,
          title: 'Great job !!! 💪',
          color: Colors.tealAccent[400],
          time: 0
        );

    listCompleteTimers.add(timer);

    return listCompleteTimers;
  }  

  
  List<TimerItemModel> _getTimerRoundList(){
    final List<TimerItemModel> listTimers = new List<TimerItemModel>();

    int totalBreak = prefs.getTotalRounds - 1; 
     
    int totalWorkRound = prefs.getTotalRounds; 
    

    for (var i = 0; i < totalWorkRound; i++) {
      // por cada pomodoro agregar a la lista el total de totalWorkRound + totalBreak

      if(totalWorkRound != 0){
        TimerItemModel timer = new TimerItemModel(
          type: TypeTimer.timeWork,
          title: 'Time to work',
          color: Colors.black,
          time: prefs.getTimeWork
        );

        listTimers.add(timer);
        totalWorkRound-1;
      }



      if(totalBreak != 0){
        TimerItemModel timer = new TimerItemModel(
          type: TypeTimer.timeBreak,
          title: 'Time to break',
          color: Colors.grey[900],
          time: prefs.getTimeBreak
        );

        listTimers.add(timer);
        totalBreak--;
      }


    }

    return listTimers;


  }

  





}