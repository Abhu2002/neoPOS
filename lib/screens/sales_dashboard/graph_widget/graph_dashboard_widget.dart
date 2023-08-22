import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:syncfusion_flutter_charts/charts.dart';


import 'graph_dashboard_bloc.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

enum MonthLabel {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  Septeber,
  October,
  November,
  December
}

class _GraphPageState extends State<GraphPage> {
  MonthLabel? selectedMonth;

  @override
  void initState() {
    selectedMonth = isCurrentMonth(DateTime.now().month);
    super.initState();
    BlocProvider.of<GraphDashboardBloc>(
      context,
    ).add(Graphinitevent(DateTime.now().month));
  }

  final TextEditingController monthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<MonthLabel>> monthEntries =
        <DropdownMenuEntry<MonthLabel>>[];
    for (final MonthLabel month in MonthLabel.values) {
      monthEntries.add(
        DropdownMenuEntry<MonthLabel>(value: month, label: month.name),
      );
    }
    final List<ChartData> chartData = [];
    return BlocBuilder<GraphDashboardBloc, GraphDashboardState>(
        builder: (context, state) {
      if (state is GraphFilterState) {
        for (var a in state.processedData) {
          chartData.add(ChartData(a.x.day, a.y));
        }
        return Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Daily Sales",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: DropdownMenu<MonthLabel>(
                          initialSelection: selectedMonth,
                          controller: monthController,
                          label: const Text('Month'),
                          dropdownMenuEntries: monthEntries,
                          onSelected: (MonthLabel? month) {
                            setState(() {
                              selectedMonth = month;
                            });
                            int monthIndex = isMonth(month);
                            BlocProvider.of<GraphDashboardBloc>(context)
                                .add(Graphinitevent(monthIndex));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: SfCartesianChart(
                        primaryXAxis: NumericAxis(
                            minimum: 0,
                            maximum: 31,
                            interval: 1,
                            majorGridLines: const MajorGridLines(width: 0)),
                        series: <ChartSeries<ChartData, int>>[
                          ColumnSeries<ChartData, int>(
                              xAxisName: "Day of Month",
                              yAxisName: "Sales in Amount",
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              // Sets the corner radius
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)))
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return const SizedBox(
          height: 200,
          width: 200,
          child: Center(child: CircularProgressIndicator()));
    });
  }

  int isMonth(MonthLabel? a) {
    switch (a) {
      case MonthLabel.January:
        return 1;
      case MonthLabel.February:
        return 2;
      case MonthLabel.March:
        return 3;
      case MonthLabel.April:
        return 4;
      case MonthLabel.May:
        return 5;
      case MonthLabel.June:
        return 6;
      case MonthLabel.July:
        return 7;
      case MonthLabel.August:
        return 8;
      case MonthLabel.Septeber:
        return 9;
      case MonthLabel.October:
        return 10;
      case MonthLabel.November:
        return 11;
      case MonthLabel.December:
        return 12;
      default:
        return 1;
    }
  }

  MonthLabel isCurrentMonth(int a) {
    switch (a) {
      case 1:
        return MonthLabel.January;
      case 2:
        return MonthLabel.February;
      case 3:
        return MonthLabel.March;
      case 4:
        return MonthLabel.April;
      case 5:
        return MonthLabel.May;
      case 6:
        return MonthLabel.June;
      case 7:
        return MonthLabel.July;
      case 8:
        return MonthLabel.August;
      case 9:
        return MonthLabel.Septeber;
      case 10:
        return MonthLabel.October;
      case 11:
        return MonthLabel.November;
      case 12:
        return MonthLabel.December;
      default:
        return MonthLabel.December;
    }
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final double y;
}
