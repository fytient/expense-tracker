import 'package:expense/bar%20graph/individual_bar.dart';

class BarData
{
  final double SundayAmount;
  final double MondayAmount;
  final double TuesdayAmount;
  final double WednesdayAmount;
  final double ThursdayAmount;
  final double FridayAmount;
  final double SaturdayAmount;
  
  BarData({
    required this.SundayAmount,
    required this.MondayAmount,
    required this.TuesdayAmount,
    required this.WednesdayAmount,
    required this.ThursdayAmount,
    required this.FridayAmount,
    required this.SaturdayAmount,
  });
  List<IndividualBar> barData = [];
  void initializeBarData(){
    barData = [
      IndividualBar(x: 0, y: SundayAmount),
      IndividualBar(x: 1, y: MondayAmount),
      IndividualBar(x: 2, y: TuesdayAmount),
      IndividualBar(x: 3, y: WednesdayAmount),
      IndividualBar(x: 4, y: ThursdayAmount),
      IndividualBar(x: 5, y: FridayAmount),
      IndividualBar(x: 6, y: SaturdayAmount),
    ];
  }
}