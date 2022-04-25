import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/widgets/reveries_app_bar.dart';
import 'package:reveries_app/widgets/reveries_bottom_tabs.dart';

import '../blocs/auth_block.dart';
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
          DatabaseReference database = FirebaseDatabase.instance.ref(
              "fleeting/$uid"
          );

          return Scaffold(
              backgroundColor: Color(0xFFf3f2fa),
              appBar: ReveriesAppBar.getReveriesAppBar(context, user),
              body: Center(
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormBuilderTextField(
                        name: 'title',
                        decoration: new InputDecoration.collapsed(
                            hintText: 'Title...'
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]
                        )
                      ),
                      FormBuilderTextField(
                        name: 'body',
                        decoration: new InputDecoration.collapsed(
                            hintText: 'What made this Reverie interesting?'
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]
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
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ReveriesBottomTabs());
        });
  }
}
