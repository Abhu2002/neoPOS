import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/dashboard/dashboard_page.dart';
import 'package:neopos/screens/sales_dashboard/graph_widget/graph_dashboard_widget.dart';
import 'package:neopos/screens/sales_dashboard/sales_dashboard_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../../utils/common_card.dart';

class SalesDashboardPage extends StatefulWidget {


  const SalesDashboardPage(
      {super.key, });

  @override
  State<SalesDashboardPage> createState() => _SalesDashboardPageState();
}


class _SalesDashboardPageState extends State<SalesDashboardPage> {
  MonthLabel? selectedMonth;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SalesDashboardBloc>(
      context,
    ).add(DashboardPageinitevent());
  }

  final TextEditingController monthController = TextEditingController();

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
    return Column(children: [
      SizedBox(
          child: Column(children: [
            Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  SizedBox(
                    height: 380,
                    width: MediaQuery
                        .sizeOf(context)
                        .width,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: BlocBuilder<SalesDashboardBloc,
                                SalesDashboardState>(
                              builder: (context, state) {
                                if (state is SalesDashBoardLoadedState) {
                                  var sendData = state.allOrder
                                      .sublist(state.allOrder.length - 5,
                                      state.allOrder.length)
                                      .toList();
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title: const Text(
                                              "Last 5 Orders Transaction",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors
                                                      .primaryColor),
                                            ),
                                            trailing: TextButton(
                                              child: const Text("All Order"),
                                              onPressed: () {
                                                if (DashboardPage.pageController
                                                    .hasClients) {
                                                  widget.controller
                                                      .animateToPage(
                                                    5,
                                                    duration: const Duration(
                                                        milliseconds: 400),
                                                    curve: Curves.easeInOut,
                                                  );
                                                  DashboardPage.sideMenu.changePage(5);
                                                }
                                              },
                                            )),
                                        ListView.builder(
                                          reverse: true,
                                          shrinkWrap: true,
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            var data = sendData[index];
                                            return ListTile(
                                              tileColor: Colors.white,
                                              title: Text(
                                                "Order Id ${data['Id']}",
                                              ),
                                              subtitle: Text(
                                                "₹${f.format(data["amount"])}",
                                              ),
                                              trailing: Text(
                                                DateFormat('MMM dd hh:mm')
                                                    .format(
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
                                } else
                                if (state is SalesDashBoardLoadingState) {
                                  return const SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: Center(child: CircularProgressIndicator()));
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
                                                amount: state.dailyValue
                                                    .toString(),
                                              )),
                                          Expanded(
                                              child: CommonCard(
                                                title: "Weekly Revenue",
                                                amount: state.weeklyValue
                                                    .toString(),
                                              )),
                                          Expanded(
                                              child: CommonCard(
                                                title: "Monthly Revenue",
                                                amount: state.monthlyValue
                                                    .toString(),
                                              )),
                                        ],
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10)),
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
                                  return const SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: Center(child: CircularProgressIndicator()));
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
                  const GraphPage()
                ],
              ),
            )
          ]))
    ]);
  }
}