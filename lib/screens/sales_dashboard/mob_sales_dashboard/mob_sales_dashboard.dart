import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopos/screens/sales_dashboard/graph_widget/graph_dashboard_widget.dart';
import 'package:neopos/screens/sales_dashboard/sales_dashboard_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/common_card.dart';
import '../../dashboard/side_menu_bloc.dart';

class MobileSalesDashboardPage extends StatefulWidget {
  PageController pageController;

  MobileSalesDashboardPage(
    this.pageController, {
    super.key,
  });

  @override
  State<MobileSalesDashboardPage> createState() =>
      _MobileSalesDashboardPageState();
}

class _MobileSalesDashboardPageState extends State<MobileSalesDashboardPage> {
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
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.9,
      width: MediaQuery.sizeOf(context).width,
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  BlocBuilder<SalesDashboardBloc, SalesDashboardState>(
                    builder: (context, state) {
                      if (state is SalesDashBoardLoadedState) {
                        List<Widget> cards = [
                          CommonCardMobile(
                              title:
                                  AppLocalizations.of(context)!.today_revenue,
                              amount: state.dailyValue.toString()),
                          CommonCardMobile(
                              title:
                                  AppLocalizations.of(context)!.monthly_revenue,
                              amount: state.weeklyValue.toString()),
                          CommonCardMobile(
                              title:
                                  AppLocalizations.of(context)!.yearly_revenue,
                              amount: state.monthlyValue.toString())
                        ];
                        return Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: CarouselSlider.builder(
                                //carouselController: carouselController.,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return cards[index];
                                },
                                options: CarouselOptions(
                                    enableInfiniteScroll: true,
                                    viewportFraction: 0.6),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                height: 400,
                                child: PieChart(
                                  legendOptions: const LegendOptions(
                                      showLegendsInRow: true,
                                      legendPosition: LegendPosition.bottom),
                                  dataMap: state.piemap,
                                  // chartType: ChartType.ring,
                                  baseChartColor:
                                      Colors.grey[50]!.withOpacity(0.15),
                                  chartValuesOptions: const ChartValuesOptions(
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
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                          AppLocalizations.of(context)!
                                              .sales_dash_order,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor),
                                        ),
                                        trailing: TextButton(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .sales_dash_more),
                                          onPressed: () {
                                            if (widget
                                                .pageController.hasClients) {
                                              widget.pageController
                                                  .animateToPage(
                                                5,
                                                duration: const Duration(
                                                    milliseconds: 400),
                                                curve: Curves.easeInOut,
                                              );
                                              widget.pageController
                                                  .jumpToPage(5);
                                              BlocProvider.of<SideMenuBloc>(
                                                      context)
                                                  .add(SideMenuInitEvent(5));
                                            }
                                          },
                                        )),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
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
                              return const SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            }
                            return const Text("error");
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const GraphPage()
          ],
        ),
      ),
    );
  }
}
