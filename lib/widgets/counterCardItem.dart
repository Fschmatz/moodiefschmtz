import 'package:flutter/material.dart';

class CounterCardItem extends StatefulWidget {
  @override
  _CounterCardItemState createState() => _CounterCardItemState();

  Color color;
  int value;
  CounterCardItem({Key key,this.value,this.color}) : super(key: key);
}

class _CounterCardItemState extends State<CounterCardItem> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 45,
      width: 45,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: widget.color,
        child: Center(
            child: Text(
              widget.value.toString(),
              style: TextStyle(fontSize: 16, color: Colors.black87,fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}

