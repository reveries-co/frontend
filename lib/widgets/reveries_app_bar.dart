import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reveries_app/screens/add_fleeting_note.dart';
import 'package:reveries_app/screens/demo.dart';

import '../blocs/auth_block.dart';
import '../screens/logout.dart';

class ReveriesAppBar {
  static getReveriesAppBar(context, user) {
    final authBloc = Provider.of<AuthBloc>(context);
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(LogoutScreen.routeName);
            },
            child: FadeInImage(
                image: NetworkImage(user.photoURL!),
                placeholder: AssetImage('img/daniel.png')
            )
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            color: Color(0xFF3E424B),
            icon: const Icon(Icons.search),
          ),
        ),
        IconButton(
            icon: const Icon(Icons.add),
            color: Color(0xFF3E424B),
            onPressed: () {
              Navigator.of(context).pushNamed(AddFleetingNoteScreen.routeName);
            }),
      ],
      title: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(DemoScreen.routeName);
          },
          child: Image(
            image: AssetImage('img/mesh_logo_nobg.png'),
            height: 20,
          ),
        ),
      ),
      backgroundColor: Color(0xFFF0F3F8),
    );
  }
}
