import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pomodoro/bloc/timer_bloc.dart';
import 'package:pomodoro/model/timer_model.dart';
import 'package:pomodoro/pages/settings_page.dart';
import 'package:pomodoro/preferences/shared_preferences.dart';
import 'package:pomodoro/utils/get_time.dart';
import 'package:pomodoro/widgets/fab_button.dart';
import 'package:simple_timer/simple_timer.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin {


  List<TimerItemModel> listTimers = new List<TimerItemModel>();

  final Preferences prefs = new Preferences();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPlay = false;
  bool isPause = false;

  // declaration
  TimerController _timerController;

    @override
  void initState() {
    // initialize timercontroller
    _timerController = TimerController(this);
    super.initState();
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: NeumorphicAppBar(
        actions: [
          _buttonOptions()
        ],
        color: Colors.black,
        centerTitle: true,
        title: _titleAppBar(),
      ),
      body: _buildBody(),
      endDrawer: BuildDrawerMenu(),
      floatingActionButton: isPlay ? _fabPauseAndDeleteButton()  : _fabPlayButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _titleAppBar() {
    return Text(
      'NeuPomodoro',
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.tealAccent[400],
        fontWeight: FontWeight.w700
      ),
    );
  }

  Widget _buttonOptions(){
    return GestureDetector(
      onTap: _openEndDrawer,
      child: NeumorphicIcon(
        Icons.more_vert,
        size: 30.0,
        style: NeumorphicStyle(
          color: Colors.tealAccent[700],
          depth: 1,
          intensity: 1,
          shape: NeumorphicShape.flat
        ),
      ),
    );
  }

  Widget _fabPlayButton() {
    return buildFabButton(Icons.play_circle_filled, 60.0, (){
      BlocProvider.of<TimerBloc>(context).add(TimerStart());
      _timerController.start();
      isPlay = true;
      isPause = false;
      setState(() {});
    });

  }

  Widget _fabPauseAndDeleteButton() {
    final pauseButton = buildFabButton(Icons.pause_circle_filled, 60.0, (){
      // pause the timer
      _timerController.pause();
      isPause = true;
      setState(() {});
    });

     final deleteButton = buildFabButton(Icons.remove_circle, 60.0, (){
       BlocProvider.of<TimerBloc>(context).add(TimerCompleted(isFinished: true));
      _timerController.reset();
      isPlay = false;
      setState(() {});
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isPause ? _fabPlayButton() : pauseButton,
        SizedBox(width: 25.0,),
        deleteButton
      ],
    );
  }


  //! --- Build Body 

  Widget _buildBody(){

    return BlocBuilder<TimerBloc, TimerStater>(
      builder: (context, state){

        return Container(
          color: Colors.black,
          child: Column(
            children: 
            (state is TimerList) ?
              [
              _containerTimer(state.listTimers[0].time),
              _progressBar(),
              _listOfItemRound(state.listTimers)
              ]
              :
              [
                Center(
                  child: NeumorphicIcon(Icons.beenhere,
                  size: 80.0, 
                  style: NeumorphicStyle(
                    color: Colors.tealAccent[700],
                    depth: 1,
                    intensity: 1,
                    shape: NeumorphicShape.flat
                  ),),
                ),
              ],
            
            
          ),
        );
      },
    );

    
  }

  
  Widget _containerTimer(int time){
    

    return Center(
      child: Neumorphic(
      padding: EdgeInsets.symmetric(
        horizontal: 1.0,
        vertical: 1.0
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 20.0
      ),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.circle(), 
        depth: 5,
        intensity: 1.0,
        lightSource: LightSource.bottomLeft,
        color: Colors.black
      ),
      
      child: _buildTimer(time)
  ),
    );
  }

  Widget _buildTimer(int time){


    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 0.0
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 0.0
      ),
      child: SimpleTimer(
        duration: Duration(seconds: time ),
        controller: _timerController,
        onStart: handleTimerOnStart,
        onEnd: handleTimerOnEnd,
        valueListener: timerValueChangeListener,
        timerStyle: TimerStyle.expanding_sector,
        backgroundColor: Colors.black,
        progressIndicatorColor: Colors.tealAccent[700],
        strokeWidth: 10,
        progressTextStyle: TextStyle(
          fontSize: 55.0,
          fontWeight: FontWeight.w700,
          color: Colors.white
        ),
      ),
    );
  }

  Widget _progressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 15.0
      ),
      child: NeumorphicProgress(
        percent: 0.6,
        height: 15.0,
        style: ProgressStyle(
          accent: Colors.tealAccent[700],
          depth: 15.0,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          variant: Colors.tealAccent[100],
          lightSource: LightSource.bottomLeft,
        ),
      ),
    );
  }

  Widget _listOfItemRound(List<TimerItemModel> list) {

    // listTimers.clear();

    // if(listTimers.isNotEmpty){
    //   listTimers.clear();
    //   listTimers = new List<TimerItemModel>();
    // }
    listTimers = list;

    return Flexible(
      child: ListView.builder(
        itemCount: listTimers.length,
        itemBuilder: (context, i) => _buildItemsTime(listTimers[i])
      ),
    );
    
  }

  Widget _buildItemsTime(TimerItemModel item) {


    Color titleColor = item.type == TypeTimer.workComplete
    ? Colors.grey[850]
    : Colors.grey[100];

    return Center(
      child: Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(4.0)), 
        depth: 2,
        intensity: 1.0,
        lightSource: LightSource.bottomLeft,
        color: item.color
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 15.0
      ),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          color: titleColor
        ),
      )
    ),
  );

  }

  // int getTime(){
  //   if(listTimers.isEmpty) return prefs.getTimeWork;
  //   int time = getTypeOfTime(listTimers.first.type);

  //   return time;
  // }

  void timerValueChangeListener(Duration timeElapsed) {

  }


  void handleTimerOnStart() {
    print("timer has just started");
  }

  void handleTimerOnEnd() {
    print("timer has ended");
 
    isPlay = false;
    _timerController.reset();
    setState(() {});
    
    handleNextTimer();


  }

  void handleNextTimer(){
    if(listTimers.isNotEmpty){
      setState(() {});
      
      //listTimers.removeAt(0);

      BlocProvider.of<TimerBloc>(context)
      ..add(TimerRemove(listTimers: listTimers));
      

      isPlay = true;

      setState(() {});
      _timerController.start(); 
    }else{
      
      isPlay = false;

      BlocProvider.of<TimerBloc>(context).add(TimerCompleted(isFinished: true));

    }
    //listTimers.clear();

    // if(listTimers.isNotEmpty){
    //   listTimers.clear();
    //   listTimers = new List<TimerItemModel>();
    // }
  }
}

class ItemTime{
  final int time;
  final bool isRest;
  final String title;
  final Color color;

  ItemTime(
    this.time,
    this.isRest,
    this.title,
    this.color
  );
}