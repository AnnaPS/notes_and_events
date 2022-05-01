import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_and_events/view/events/bloc/event_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../repository/repository.dart';

class EventView extends StatelessWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      buildWhen: (previous, current) =>
          current.status.isSuccess || current.status.isLoading,
      builder: (context, state) {
        if (state.status.isSuccess) {
          return Stack(
            children: [
              _EventListWidget(events: state.events),
              const _FloatingActionButtonWidget(),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _EventListWidget extends StatelessWidget {
  const _EventListWidget({
    Key? key,
    required this.events,
  }) : super(key: key);

  final List<EventEntity> events;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(events[index].title),
        );
      },
      itemCount: events.length,
    );
  }
}

class _FloatingActionButtonWidget extends StatelessWidget {
  const _FloatingActionButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        onPressed: () {
          var event = EventEntity(
              id: const Uuid().v4(),
              title: 'test 3',
              description: 'new document added',
              starts: DateTime.now(),
              ends: DateTime.now(),
              ownerUserId: 'owner id test 3');
          context.read<EventBloc>().add(EventEventAdd(event: event));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
