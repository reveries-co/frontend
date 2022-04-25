import 'package:firebase_database/firebase_database.dart';

class FleetingNote {
  var title = "";
  var body = "";
  var created_at = 0;

  FleetingNote(title, body, created_at) {
    this.title = title;
    this.body = body;
    this.created_at = created_at;
  }

  static FleetingNote fromSnapshot(DataSnapshot value) {
    return new FleetingNote(
        value.child("title").value,
        value.child("body").value,
        value.child("created_at").value,
    );
  }
}