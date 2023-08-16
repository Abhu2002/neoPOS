import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/sales_dashboard/sales_dashboard_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesDashboardPage extends StatefulWidget {
  const SalesDashboardPage({super.key});

  @override
  State<SalesDashboardPage> createState() => _SalesDashboardPageState();
}
enum MonthLabel {
 January,February,March,April,May,June,July,August,Septeber,October,November,December}
class _SalesDashboardPageState extends State<SalesDashboardPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SalesDashboardBloc>(
      context,
    ).add(DashboardPageinitevent());
  }

  final TextEditingController monthController = TextEditingController();
  MonthLabel? selectedMonth;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<MonthLabel>> monthEntries =
    <DropdownMenuEntry<MonthLabel>>[];
    for (final MonthLabel month in MonthLabel.values) {
      monthEntries.add(
        DropdownMenuEntry<MonthLabel>(
            value: month, label: month.name),
      );
    }
    final List<ChartData> chartData = [];
    return BlocBuilder<SalesDashboardBloc, SalesDashboardState>(
        builder: ((context, state) {
          if (state is SalesDashBoardLoadedState) {
            for (var a in state.processedData) {
              chartData.add(ChartData(a.x.day, a.y));
            }
            return SizedBox(
              height: MediaQuery
                  .sizeOf(context)
                  .height,
              width: MediaQuery
                  .sizeOf(context)
                  .width,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Daily Sales", style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                                DropdownMenu<MonthLabel>(
                                  initialSelection: selectedMonth,
                                  controller: monthController,
                                  label: const Text('Month'),
                                  dropdownMenuEntries: monthEntries,
                                  onSelected: (MonthLabel? Month) {
                                    setState(() {
                                      selectedMonth = Month;
                                    });
                                    int monthIndex =isMonth(Month);
                                    BlocProvider.of<SalesDashboardBloc>(context).add(DashboardPageinitevent(monthIndex));
                                  },
                                ),
                              ],
                            ),
                          ),
                          SfCartesianChart(primaryXAxis: NumericAxis(minimum: 0,
                              maximum: 31,
                              interval: 1,
                              majorGridLines: const MajorGridLines(width: 0)),
                              series: <ChartSeries<ChartData, int>>[
                                ColumnSeries<ChartData, int>(
                                    isTrackVisible: false,
                                    xAxisName: "Day of Month",
                                    yAxisName: "Sales in Amount",
                                    dataLabelSettings: DataLabelSettings(
                                        isVisible: true),
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    // Sets the corner radius
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)))
                              ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox(
              height: 200,
              width: 200,
              child: Center(child: CircularProgressIndicator()));
        }
        ));
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
}
class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
