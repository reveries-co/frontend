import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/models/fleeting_note.dart';
import 'package:reveries_app/widgets/reveries_app_bar.dart';
import 'package:reveries_app/widgets/reveries_bottom_tabs.dart';

import '../blocs/auth_block.dart';
import '../services/database_service.dart';
import '../widgets/note_card.dart';
import 'login.dart';


class ListFleetingNotesScreen extends StatefulWidget {
  const ListFleetingNotesScreen({Key? key}) : super(key: key);
  static const routeName = '/fleeting';

  @override
  State<ListFleetingNotesScreen> createState() =>
      _ListFleetingNotesScreenState();
}

class _ListFleetingNotesScreenState extends State<ListFleetingNotesScreen> {
  late StreamSubscription<User?> loginStateSubscription;
  List<FleetingNote> _notes = [];

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((gUser) {
      if (gUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        _setupNotes(gUser.uid);
      }
    });
  }

  _setupNotes(uuid) async {
    List<FleetingNote> notes = await DatabaseService.getNotes(uuid);
    setState(() {
      this._notes = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return StreamBuilder<User?>(
        stream: authBloc.currentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final User user = snapshot.data as User;

          return Scaffold(
              backgroundColor: Color(0xFFf3f2fa),
              appBar: ReveriesAppBar.getReveriesAppBar(context, user),
              body: ListView.builder(
                  itemCount: this._notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    FleetingNote note = this._notes[index];
                    return NoteCard(title: note.title, body: note.body);
                  }
              ),
              bottomNavigationBar: ReveriesBottomTabs());
        });
  }
}
