import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartWidget extends StatefulWidget {
  final Map<String, double> data;
  const PieChartWidget({super.key, required this.data});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 265,
        child: PieChart(
          dataMap: widget.data,
          // chartType: ChartType.ring,
          baseChartColor: Colors.grey[50]!.withOpacity(0.15),
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          // totalValue: 20,
        ),
      ),
    );
  }
}
