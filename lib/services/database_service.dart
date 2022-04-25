import 'package:firebase_database/firebase_database.dart';
import '../models/fleeting_note.dart';

class DatabaseService {

  static Future<List<FleetingNote>> getNotes(String uuid) async {
    DataSnapshot event = await FirebaseDatabase.instance
        .ref("${uuid}/fleeting/").get();

    List<FleetingNote> notes = [];

    event.children.forEach((value) {
      notes.add(FleetingNote.fromSnapshot(value));
    });

    return notes;
  }
}