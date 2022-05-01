import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_and_events/view/events/bloc/event_bloc.dart';
import 'package:notes_and_events/view/widgets/show_modal.dart';
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
          subtitle: Text(events[index].description),
          trailing: const Icon(Icons.delete, color: Colors.red),
        );
      },
      itemCount: events.length,
    );
  }
}

class _FloatingActionButtonWidget extends StatefulWidget {
  const _FloatingActionButtonWidget({Key? key}) : super(key: key);

  @override
  State<_FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<_FloatingActionButtonWidget> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        onPressed: () async {
          await showModal<void>(
            context: context,
            backgroundColor: Colors.grey.shade200,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            builder: (_) => Column(
              children: [
                const _HeaderModal(),
                _TitleTextField(controller: _titleController),
                _DescriptionTextField(controller: _descriptionController),
                const Spacer(),
                _AddEventButton(
                  callback: () {
                    final event = EventEntity(
                      id: const Uuid().v4(),
                      title: _titleController.text,
                      description: _descriptionController.text,
                      starts: DateTime.now(),
                      ends: DateTime.now().add(
                        const Duration(days: 1),
                      ),
                      ownerUserId: 'ana',
                    );
                    context.read<EventBloc>().add(EventEventAdd(event: event));
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }
}

class _HeaderModal extends StatelessWidget {
  const _HeaderModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          Text(
            'New event data',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}

class _TitleTextField extends StatelessWidget {
  const _TitleTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Title of the event',
          hintText: 'Title of the event',
        ),
      ),
    );
  }
}

class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        maxLines: 4,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Description of the event',
          hintText: 'Description of the event',
        ),
      ),
    );
  }
}

class _AddEventButton extends StatelessWidget {
  const _AddEventButton({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        child: const Text('Add Event'),
        onPressed: callback,
      ),
    );
  }
}
