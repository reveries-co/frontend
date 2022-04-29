import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String body;
  final int created_at;

  const NoteCard({
    Key? key,
    this.title = "",
    this.body = "",
    this.created_at = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String human_date = "";
    if (this.created_at != 0) {
      human_date = Jiffy(
          new DateTime.fromMillisecondsSinceEpoch(
            this.created_at
        )
      ).fromNow();
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0.0, 4.0),
              blurRadius: 16.0,
              spreadRadius: 5.0,
            ),
          ]),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
      child: Container(
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
                human_date,
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
            padding: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
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
      ),
    );
  }
}
