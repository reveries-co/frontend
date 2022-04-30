import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/widgets/reveries_app_bar.dart';
import 'package:uuid/uuid.dart';
import '../blocs/auth_block.dart';
import 'list_fleeting_notes.dart';
import 'login.dart';

class AddFleetingNoteScreen extends StatefulWidget {
  const AddFleetingNoteScreen({Key? key}) : super(key: key);
  static const routeName = '/fleeting/add';

  @override
  State<AddFleetingNoteScreen> createState() => _AddFleetingNoteScreenState();
}

class _AddFleetingNoteScreenState extends State<AddFleetingNoteScreen> {
  late StreamSubscription<User?> loginStateSubscription;
  final _formKey = GlobalKey<FormBuilderState>();

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
      }
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

          // everything is set up let's generate a UUID for this fleeting note
          var uuid = Uuid();
          String uid = uuid.v1();
          DatabaseReference database =
              FirebaseDatabase.instance.ref("${user.uid}/fleeting/$uid");
          return Scaffold(
              backgroundColor: Color(0xFFf3f2fa),
              appBar: ReveriesAppBar.getReveriesAppBar(context, user),
              body: Center(
                child: FormBuilder(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    margin: EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(
                      children: [
                        FormBuilderTextField(
                            textAlign: TextAlign.center,
                            name: 'title',
                            decoration: new InputDecoration.collapsed(
                              hintText: 'Title...',
                              hintStyle: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Source Serif Pro',
                              ),
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required(context)])),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          constraints: BoxConstraints(
                              minHeight: 150,
                              maxHeight: 600),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  offset: const Offset(
                                    0.0,
                                    4.0,
                                  ),
                                  blurRadius: 16.0,
                                  spreadRadius: 5.0,
                                ),
                              ]),
                          margin: EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 25.0),
                          child: FormBuilderTextField(
                            name: 'body',
                            decoration: new InputDecoration.collapsed(
                                hintText: '''
                                    What made this Reverie interesting?''',
                                hintStyle: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFFD6D6D6),
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Source Serif Pro',
                                )),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required(context)]),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.saveAndValidate()) {
                              await database.set({
                                "title": _formKey.currentState!.value["title"],
                                "body": _formKey.currentState!.value["body"],
                                "created_at":
                                    DateTime.now().millisecondsSinceEpoch,
                                "user": user.uid
                              });
                              Navigator.of(context).pushNamed(ListFleetingNotesScreen.routeName);
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
