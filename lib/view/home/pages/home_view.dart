import 'package:flutter/material.dart';
import 'package:notes_and_events/view/events/pages/event_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            child: const Text('Events'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EventPage(),
              ),
            ),
          ),
          OutlinedButton(
            child: const Text('Notes'),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Work in progress'),
                duration: Duration(seconds: 3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
