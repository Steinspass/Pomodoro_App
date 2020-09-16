import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

  static final  Preferences _instance = new Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPrefs() async{
    this._prefs = await SharedPreferences.getInstance();
  }

  // timepo de trabajo
  get getTimeWork {
    return _prefs.getInt('timeWork') ?? 25;
  }

  set getTimeWork (int value) {
    _prefs.setInt('timeWork', value);
  }

  // Tiempo de descanso corto
  get getTimeBreak {
    return _prefs.getInt('timeBreak') ?? 5;
  }

  set getTimeBreak (int value) {
    _prefs.setInt('timeBreak', value);
  }

  // Tiempo de descanso largo
  get getTimeRest {
    return _prefs.getInt('timeRest') ?? 15;
  }

  set getTimeRest (int value) {
    _prefs.setInt('timeRest', value);
  }

  // Total de tiempos de trabajo por Pomodoro
  get getTotalRounds {
    return _prefs.getInt('TotalRounds') ?? 4;
  }

  set getTotalRounds (int value) {
    _prefs.setInt('TotalRounds', value);
  }

  // Total de Pomodoro's
  get getTotalPomodoro {
    return _prefs.getInt('TotalPomodoro') ?? 2;
  }

  set getTotalPomodoro (int value) {
    _prefs.setInt('TotalPomodoro', value);
  }

}