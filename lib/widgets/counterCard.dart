import 'package:flutter/material.dart';
import 'package:moodiefschmtz/widgets/counterCardItem.dart';

class CounterCard extends StatefulWidget {
  @override
  _CounterCardState createState() => _CounterCardState();

  int countGood;
  int countMedium;
  int countBad;

  CounterCard({Key key,this.countGood,this.countMedium,this.countBad}) : super(key: key);
}

class _CounterCardState extends State<CounterCard> {

  @override
  Widget build(BuildContext context) {
    return  Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(
            color: Colors.grey[700].withOpacity(0.3),
            width: 1,
          ),
        ),
        child:Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CounterCardItem(key:UniqueKey(),value: widget.countGood,color: Color(0xFF4CAF50)), //g
              CounterCardItem(key:UniqueKey(),value: widget.countMedium,color: Color(0xFFFDD835),),//m
              CounterCardItem(key:UniqueKey(),value: widget.countBad,color: Color(0xFFFF5252),),//b
            ],
          ),
        )
        );
  }
}
