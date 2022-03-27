import 'package:flutter/material.dart';

import '../custom_icons.dart';
import '../google_signin.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf3f2fa),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleSignInDemo()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('img/daniel.png'),
              ),
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
            )
          ],
          title: Center(
            child: Image(
              image: AssetImage('img/mesh_logo_nobg.png'),
              height: 20,
            ),
          ),
          backgroundColor: Color(0xFFF0F3F8),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                Text(
                  'Permanent Notes',
                  style: TextStyle(
                    fontFamily: 'Source Serif Pro',
                    fontWeight: FontWeight.w700,
                    fontSize: 40.0,
                  ),
                ),
                Container(
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
                  padding: EdgeInsets.all(10.0),
                  margin:
                  EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child:
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              ' #14 Liquid Modernity',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                height: 1.2,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                      ),
                  Container(
                          alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(
                                '1 day ago',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  height: 0.5,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12.0,
                                  color: Color(0xFF979797),
                                ),
                              ),
                            ),
                          ),
                      Padding(
                        padding: EdgeInsets.only(left:20, bottom: 20, right: 20, top:10),
                        child: Text(
                          'Very interesting way of describing how people my age see their vision of the world, and how future societies, but you won\'t be an innovator. ',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            height: 2,
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF979797),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.account_tree_rounded,
                          color: Color(0xFFE35D47),
                            size: 15.0,
                        ),
                          Text("  12, 3",
                            style: TextStyle(
                            fontFamily: 'Rubik',
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.0,
                          ),)
                      ],
                       ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}