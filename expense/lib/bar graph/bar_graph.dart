import 'package:expense/bar%20graph/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double SundayAmount;
  final double MondayAmount;
  final double TuesdayAmount;
  final double WednesdayAmount;
  final double ThursdayAmount;
  final double FridayAmount;
  final double SaturdayAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.SundayAmount,
    required this.MondayAmount,
    required this.TuesdayAmount,
    required this.WednesdayAmount,
    required this.ThursdayAmount,
    required this.FridayAmount,
    required this.SaturdayAmount,});

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
      SundayAmount: SundayAmount,
      MondayAmount: MondayAmount,
      TuesdayAmount: TuesdayAmount,
      WednesdayAmount: WednesdayAmount,
      ThursdayAmount: ThursdayAmount,
      FridayAmount: FridayAmount,
      SaturdayAmount: SaturdayAmount,
    );
    barData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        titlesData: FlTitlesData(show: true, 
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getBottomTitles
        ),
        ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),  
        barGroups: barData.barData
            .map((data) => BarChartGroupData(
                  x: data.x,
                  barRods: [BarChartRodData(toY: data.y, color: Colors.amber, width: 20, borderRadius: BorderRadius.circular(4),
                  backDrawRodData: BackgroundBarChartRodData(show: true, toY: 100, color: Colors.grey.shade300))],
                ))
            .toList(),
      ),
    );
  }
  
  }

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(color: Colors.black, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Sun', style: style);
    case 1:
      text = const  Text('Mon', style: style);
    case 2:
      text = const  Text('Tue', style: style);
    case 3:
      text = const  Text('Wed', style: style);
    case 4:
      text = const  Text('Thu', style: style);
    case 5:
      text = const  Text('Fri', style: style);
    case 6:
      text = const  Text('Sat', style: style);
    default:
      text = const  Text('');
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}