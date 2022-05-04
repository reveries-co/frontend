import 'package:firebase_database/firebase_database.dart';
import '../models/fleeting_note.dart';

class DatabaseService {

  static Future<List<FleetingNote>> getNotes(String userUuid) async {
    DataSnapshot event = await FirebaseDatabase.instance
        .ref("fleeting/").orderByChild("user").equalTo(userUuid).get();

    List<FleetingNote> notes = [];

    event.children.forEach((value) {
      notes.add(FleetingNote.fromSnapshot(value));
    });

    notes.sort((a, b) => b.created_at.compareTo(a.created_at));

    return notes;
  }
}