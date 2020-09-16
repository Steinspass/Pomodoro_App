part of 'timer_bloc.dart';

@immutable
abstract class TimerStater extends Equatable {
  const TimerStater();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerStater {}

class TimerList extends TimerStater {
  final List<TimerItemModel> listTimers;

  const TimerList({ @required this.listTimers});

  @override
  List<Object> get props => [listTimers];
}

class TimerFinished extends TimerStater {}