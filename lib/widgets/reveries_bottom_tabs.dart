import 'package:flutter/material.dart';

import '../custom_icons.dart';

class ReveriesBottomTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0, // this will be set when a new tab is tapped
      items: [
        BottomNavigationBarItem(
          icon: new Icon(RevCustomIcons.you),
          label: 'You',
        ),
        BottomNavigationBarItem(
          icon: new Icon(RevCustomIcons.fleeting),
          label: 'Fleeting',
        ),
        BottomNavigationBarItem(
          icon: Icon(RevCustomIcons.permanent),
          label: 'Permanent',
        ),
      ],
    );
  }

}