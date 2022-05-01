import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_and_events/repository/event/event_repository.dart';
import 'package:notes_and_events/repository/event/model/event_entity.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc({
    required this.eventRepository,
  }) : super(EventState()) {
    on<EventEventAdd>(_onAddNewEvent);
    on<EventGetEvents>(_onGetEvents);
    on<EventDeleteEvent>(_onDeleteEvent);
  }

  final EventRepository eventRepository;

  Future<void> _onAddNewEvent(
      EventEventAdd event, Emitter<EventState> emit) async {
    try {
      emit(state.copyWith(status: EventStatus.loading));
      await eventRepository.addEvent(event.event);
      emit(state.copyWith(status: EventStatus.success));
    } catch (error) {
      emit(state.copyWith(status: EventStatus.error));
    }
  }

  Future<void> _onGetEvents(
      EventGetEvents event, Emitter<EventState> emit) async {
    try {
      emit(state.copyWith(status: EventStatus.loading));
      await emit.forEach(
        eventRepository.getEvents(),
        onData: (events) => state.copyWith(
            status: EventStatus.success, events: events as List<EventEntity>),
        onError: (_, __) {
          return state.copyWith(status: EventStatus.error);
        },
      );
    } catch (error) {
      emit(state.copyWith(status: EventStatus.error));
    }
  }

  Future<void> _onDeleteEvent(
      EventDeleteEvent event, Emitter<EventState> emit) async {
    try {
      eventRepository.deleteEvent(event.id);
      emit(state.copyWith(status: EventStatus.success));
    } catch (_) {
      emit(state.copyWith(status: EventStatus.error));
    }
  }
}
