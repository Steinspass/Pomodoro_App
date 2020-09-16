import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pomodoro/bloc/timer_bloc.dart';
import 'package:pomodoro/pages/home_page.dart';
import 'package:pomodoro/preferences/shared_preferences.dart';
import 'package:pomodoro/repository/timer_repository.dart';
import 'package:pomodoro/theme/my_theme.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializando las Preferences
  final prefs = new Preferences();
  await prefs.initPrefs();

  final TimerRepository timerRepository = new TimerRepository();

  runApp(MyApp(
    timerRepository: timerRepository,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final TimerRepository timerRepository;

  MyApp({@required this.timerRepository})
    : assert(timerRepository != null);


  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[900].withOpacity(0.1));
    return NeumorphicApp(
      title: 'Pomodoro App',
      debugShowCheckedModeBanner: false,
      theme: myThemeApp() ,
      home: BlocProvider(
        create: (context) => TimerBloc(timer: timerRepository) ,
        child: MyHomePage(),
      ), 
    );
  }
}

