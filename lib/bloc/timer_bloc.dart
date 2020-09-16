import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pomodoro/model/timer_model.dart';
import 'package:pomodoro/repository/timer_repository.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerStater> {

  final TimerRepository timerRepository;

  TimerBloc({
    @required TimerRepository timer
  }) : 
  assert(timer != null),
  timerRepository = timer,
  super(TimerInitial());

  @override
  Stream<TimerStater> mapEventToState(
    TimerEvent event,
  ) async* {
    //TODO: agregar un state en el que se devuelva item timer primer item timer
   if(event is TimerStart){

    final List<TimerItemModel> _listTimers = timerRepository.getTimerCompletedList(); 

    yield TimerList(listTimers: _listTimers);

   }

   if(event is TimerRemove){
    
    event.listTimers.removeAt(0);

    yield TimerList(listTimers: event.listTimers );

   }

   if(event is TimerCompleted){

     if(!event.isFinished) return;

     yield TimerFinished();
   }


    

  }
}
