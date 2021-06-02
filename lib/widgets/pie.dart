import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Pie extends StatelessWidget {

  Map<String, double> dataMap = {};
  Pie(this.dataMap);

  List<Color> colorList = [
    Color(0xFF4CAF50).withOpacity(0.9),
    Color(0xFFFDD835).withOpacity(0.9),
    Color(0xFFFF5252).withOpacity(0.9),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: PieChart(
            dataMap: dataMap,
            chartRadius: MediaQuery.of(context).size.width / 3.4,
            colorList: colorList,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryTextTheme.headline2.color,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 0,
              chartValueStyle:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
