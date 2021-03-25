import 'package:flutter/material.dart';
import 'package:moodiefschmtz/db/mood.dart';

class MoodCard extends StatefulWidget {
  @override
  _MoodCardState createState() => _MoodCardState();

  Mood mood;
  Function(int) delete;

  MoodCard({Key key, this.mood, this.delete}) : super(key: key);
}

class _MoodCardState extends State<MoodCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Color(int.parse(widget.mood.color.substring(6, 16))),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
              child: Text(
            widget.mood.date,
            style: TextStyle(fontSize: 18, color: Colors.black87,fontWeight: FontWeight.w600),
          )),
          onLongPress: () => widget.delete(
            (widget.mood.id_mood),
          ),
        ));
  }
}
