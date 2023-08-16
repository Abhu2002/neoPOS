import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/order%20history/order_history_page.dart';
import 'package:neopos/screens/sales_dashboard/sales_dashboard_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../utils/app_colors.dart';

class SalesDashboardPage extends StatefulWidget {
  final controller;
  final sidemenu;
  const SalesDashboardPage({super.key, this.controller, this.sidemenu});

  @override
  State<SalesDashboardPage> createState() => _SalesDashboardPageState();
}

class _SalesDashboardPageState extends State<SalesDashboardPage> {
  @override
  void initState() {
    BlocProvider.of<SalesDashboardBloc>(context).add(DashboardPageinitevent());
    // print(widget.controller);
    print(widget.sidemenu);
    super.initState();
  }

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  var f = NumberFormat("###,###", "en_US");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Container(
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            // color: Colors.red,
          ),
          Container(
            height: 380,
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(width: 1, color: Colors.black)),
                    child: BlocBuilder<SalesDashboardBloc, SalesDashboardState>(
                      builder: (context, state) {
                        if (state is SalesDashBoardLoadedState) {
                          var send_data = state.allOrder
                              .sublist(state.allOrder.length - 5,
                                  state.allOrder.length)
                              .toList();
                          return Column(
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
                                      if (widget.controller.hasClients) {
                                        widget.controller.animateToPage(
                                          5,
                                          duration:
                                              const Duration(milliseconds: 400),
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
                                          DateTime.parse(data['order_date'])),
                                    ),
                                    leading: const Icon(
                                      Icons.history_toggle_off,
                                      color: AppColors.primaryColor,
                                    ),
                                  );
                                },
                              ),
                            ],
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
                    child: BlocBuilder<SalesDashboardBloc, SalesDashboardState>(
                      builder: (context, state) {
                        if (state is SalesDashBoardLoadedState) {
                          return SizedBox(
                            height: 380,
                            child: PieChart(
                              dataMap: state.piemap,
                              // chartType: ChartType.ring,
                              baseChartColor:
                                  Colors.grey[50]!.withOpacity(0.15),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              // totalValue: 20,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: const Text("Top Sales"),
                    ))
              ],
            ),
          ),
          Container(
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            // color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
