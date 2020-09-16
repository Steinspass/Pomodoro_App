

import 'package:pomodoro/model/timer_model.dart';
import 'package:pomodoro/preferences/shared_preferences.dart';

int getTypeOfTime(TypeTimer typeTimer){

  final Preferences prefs = new Preferences(); 

  switch (typeTimer) {
    case TypeTimer.timeWork: return prefs.getTimeWork; 
      break;

    case TypeTimer.timeBreak: return prefs.getTimeBreak; 
      break;

    case TypeTimer.timeRest: return prefs.getTimeRest; 
      break;

    case TypeTimer.workComplete: return 0; 
      break;    

    default: return 0;
  }

}