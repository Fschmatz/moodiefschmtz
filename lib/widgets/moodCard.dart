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

    Color cardColor = Color(int.parse(widget.mood.color.substring(6, 16)));

    return Card(
      elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: cardColor,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onLongPress: () => widget.delete(
            (widget.mood.id_mood),
          ),
        ));
  }
}
