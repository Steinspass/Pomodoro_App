part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}


class TimerStart extends TimerEvent {}

class TimerRemove extends TimerEvent {

  final List<TimerItemModel> listTimers;

  TimerRemove({ @required this.listTimers });

  @override
  List<Object> get props => [listTimers];
}


class TimerCompleted extends TimerEvent {
  final bool isFinished;

  TimerCompleted({
    @required this.isFinished
  });

  @override
  List<Object> get props => [isFinished];

}