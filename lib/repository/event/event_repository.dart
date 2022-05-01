import 'package:notes_and_events/repository/event/model/event_entity.dart';
import '../../database/database.dart';
import '../repository.dart';

class EventRepository {
  EventRepository({
    FirebaseDatabase? firebaseDatabase,
  }) : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase();

  final FirebaseDatabase _firebaseDatabase;

  Stream<List<EventEntity>> getEvents() => _firebaseDatabase.getEvents();

  Future<void> addEvent(EventEntity event) async {
    await _firebaseDatabase.addEvent(event);
  }

  Future<void> deleteEvent(String id) async =>
      await _firebaseDatabase.deleteById(id);
}
