import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/sales_dashboard/sales_dashboard_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../../utils/common_card.dart';

class SalesDashboardPage extends StatefulWidget {
  final controller;
  final sidemenu;
  const SalesDashboardPage({super.key, this.controller, this.sidemenu});

  @override
  State<SalesDashboardPage> createState() => _SalesDashboardPageState();
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

class _SalesDashboardPageState extends State<SalesDashboardPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SalesDashboardBloc>(
      context,
    ).add(DashboardPageinitevent());
  }

  final TextEditingController monthController = TextEditingController();
  MonthLabel? selectedMonth;
  var f = NumberFormat("###,###", "en_US");
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
    return BlocBuilder<SalesDashboardBloc, SalesDashboardState>(
        builder: ((context, state) {
      if (state is SalesDashBoardLoadedState) {
        for (var a in state.processedData) {
          chartData.add(ChartData(a.x.day, a.y));
        }
        return SizedBox(
            child: Column(children: [
          Container(
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Container(
                  height: 380,
                  decoration: BoxDecoration(),
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: BlocBuilder<SalesDashboardBloc,
                              SalesDashboardState>(
                            builder: (context, state) {
                              if (state is SalesDashBoardLoadedState) {
                                var send_data = state.allOrder
                                    .sublist(state.allOrder.length - 5,
                                        state.allOrder.length)
                                    .toList();
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      ListTile(
                                          title: const Text(
                                            "Last 5 Orders Transaction",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor),
                                          ),
                                          trailing: TextButton(
                                            child: const Text("All Order"),
                                            onPressed: () {
                                              if (widget
                                                  .controller.hasClients) {
                                                widget.controller.animateToPage(
                                                  5,
                                                  duration: const Duration(
                                                      milliseconds: 400),
                                                  curve: Curves.easeInOut,
                                                );
                                                widget.sidemenu.changePage(5);
                                              }
                                            },
                                          )),
                                      ListView.builder(
                                        reverse: true,
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          var data = send_data[index];
                                          return ListTile(
                                            tileColor: Colors.white,
                                            title: Text(
                                              "Order Id ${data['Id']}",
                                            ),
                                            subtitle: Text(
                                              "₹${f.format(data["amount"])}",
                                            ),
                                            trailing: Text(
                                              DateFormat('MMM dd hh:mm').format(
                                                  DateTime.parse(
                                                      data['order_date'])),
                                            ),
                                            leading: const Icon(
                                              Icons.history_toggle_off,
                                              color: AppColors.primaryColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state is SalesDashBoardLoadingState) {
                                return Container();
                              }
                              return const Text("");
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: BlocBuilder<SalesDashboardBloc,
                              SalesDashboardState>(
                            builder: (context, state) {
                              if (state is SalesDashBoardLoadedState) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: CommonCard(
                                              title: "Today's Revenue",
                                              amount: state.dailyValue.toString(),
                                            )),
                                        Expanded(
                                            child: CommonCard(
                                              title: "Weekly Revenue",
                                              amount: state.weeklyValue.toString(),
                                            )),
                                        Expanded(
                                            child: CommonCard(
                                              title: "Monthly Revenue",
                                              amount: state.monthlyValue.toString(),
                                            )),
                                      ],
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      child: SizedBox(
                                        height: 268,
                                        child: PieChart(
                                          dataMap: state.piemap,
                                          // chartType: ChartType.ring,
                                          baseChartColor:
                                              Colors.grey[50]!.withOpacity(0.15),
                                          chartValuesOptions:
                                              const ChartValuesOptions(
                                            showChartValuesInPercentage: true,
                                          ),
                                          // totalValue: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          )),

                      /// TODO Need Top sales to be Added Later
                      // Expanded(
                      //     flex: 2,
                      //     child: Card(
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: Container(
                      //         height: 380,
                      //         child: const Center(child: Text("Top Sales")),
                      //       ),
                      //     ))
                    ],
                  ),
                ),
                Card(elevation: 3,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: 300,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Daily Sales",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              DropdownMenu<MonthLabel>(
                                initialSelection: selectedMonth,
                                controller: monthController,
                                label: const Text('Month'),
                                dropdownMenuEntries: monthEntries,
                                onSelected: (MonthLabel? Month) {
                                  setState(() {
                                    selectedMonth = Month;
                                  });
                                  int monthIndex = isMonth(Month);
                                  BlocProvider.of<SalesDashboardBloc>(context)
                                      .add(DashboardPageinitevent(monthIndex));
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
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
                                          DataLabelSettings(isVisible: true),
                                      dataSource: chartData,
                                      xValueMapper: (ChartData data, _) => data.x,
                                      yValueMapper: (ChartData data, _) => data.y,
                                      // Sets the corner radius
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)))
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
      }
      return const SizedBox(
          height: 200,
          width: 200,
          child: Center(child: CircularProgressIndicator()));
    }));
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
