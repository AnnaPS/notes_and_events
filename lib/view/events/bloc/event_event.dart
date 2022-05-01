part of 'event_bloc.dart';

class EventEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventEventAdd extends EventEvent {
  EventEventAdd({
    required this.event,
  });
  final EventEntity event;

  @override
  List<Object?> get props => [event];
}

class EventGetEvents extends EventEvent {}

class EventDeleteEvent extends EventEvent {
  EventDeleteEvent({
    required this.id,
  });
  final String id;
}
