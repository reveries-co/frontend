import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String body;

  const NoteCard({Key? key, this.title = "", this.body = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              this.title,
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
          padding:
          EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
          child: Text(
            this.body,
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
            Text(
              "  12, 3",
              style: TextStyle(
                fontFamily: 'Rubik',
                height: 1.2,
                fontWeight: FontWeight.w600,
                fontSize: 11.0,
              ),
            )
          ],
        ),
      ]),
    );
  }
}
