part of 'event_bloc.dart';

enum EventStatus { initial, success, error, loading }

extension EventStatusX on EventStatus {
  bool get isInitial => this == EventStatus.initial;
  bool get isSuccess => this == EventStatus.success;
  bool get isError => this == EventStatus.error;
  bool get isLoading => this == EventStatus.loading;
}

class EventState extends Equatable {
  EventState({
    this.status = EventStatus.initial,
    List<EventEntity>? events,
  }) : events = events ?? [];

  final EventStatus status;
  final List<EventEntity> events;

  @override
  List<Object?> get props => [status, events];

  EventState copyWith({
    EventStatus? status,
    List<EventEntity>? events,
  }) {
    return EventState(
      status: status ?? this.status,
      events: events ?? this.events,
    );
  }
}
