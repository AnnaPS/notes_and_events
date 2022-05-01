import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_and_events/view/events/pages/event_view.dart';

import '../../../repository/repository.dart';
import '../bloc/event_bloc.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: BlocProvider(
        create: (_) => EventBloc(
          eventRepository: context.read<EventRepository>(),
        )..add(EventGetEvents()),
        child: const EventView(),
      ),
    );
  }
}
