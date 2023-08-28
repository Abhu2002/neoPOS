import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
part 'sales_dashboard_event.dart';
part 'sales_dashboard_state.dart';

class SalesDashboardBloc
    extends Bloc<SalesDashboardEvent, SalesDashboardState> {
  SalesDashboardBloc() : super(SalesDashboardInitial()) {
    on<DashboardPageinitevent>((event, emit) async {
      try {
        emit(SalesDashBoardLoadingState());
        var allOrderHistory = [];
        var graphData = [];
        List<dynamic> allData = [];
        String currentDateD;
        String currentDateM;
        int currentDateW;
        num dailyValue = 0;
        num weeklyValue = 0;
        num monthlyValue = 0;
        Map<String, double> pie = {};
        Map<String, double> topproductdaily = {};
        Map<String, double> topproductweekly = {};
        Map<String, double> topproductmonthly = {};
        List<Map> topproduct = [];
        Map<DateTime, dynamic> topproductsall = {};
        FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();
        await db.collection("order_history").orderBy("order_date").get().then(
          (value) {
            value.docs.forEach((element) {
              allOrderHistory.add({
                "Id": element.id,
                "amount": element['amount'],
                "order_date": element['order_date'],
                "customer_moblie_no": element['customer_mobile_no'],
                "customer_name": element['customer_name'],
                "payment_mode": element['payment_mode'],
                "products": element["products"]
              });
              topproductsall[DateTime.parse(element['order_date'])] =
                  element["products"];
              graphData.add(SalesData(DateTime.parse(element['order_date']),
                  element['amount'].toDouble()));
              for (var top in element['products']) {
                if (pie.keys.contains(top['productCategory'])) {
                  pie[top['productCategory']] =
                      pie[top['productCategory']]! + 1;
                } else {
                  pie[top['productCategory']] = 1;
                }
              }
            });
          },
        );
        List<SalesData> processedData = [];
        for (var dailySales in graphData) {
          num sales = 0;
          final dailyFormat = DateFormat("dd-MM-yyyy").format(dailySales.x);
          for (int i = 0; i < graphData.length; i++) {
            final dateFromData =
                DateFormat("dd-MM-yyyy").format(graphData[i].x);
            if (dateFromData == dailyFormat) {
              sales += graphData[i].y;
            }
          }
          processedData.add(SalesData(
              DateFormat("dd-MM-yyyy").parse(dailyFormat), sales as double));
        }
        final Map<DateTime, SalesData> map2 = {
          for (var dailySales in processedData) dailySales.x: dailySales,
        };
        currentDateD = DateFormat("dd-MM-yyyy").format(DateTime.now());
        currentDateM = DateFormat("MM-yyyy").format(DateTime.now());
        currentDateW = weekNumber(DateTime.now());
        processedData = map2.values.toList();
        for (var a in processedData) {
          dailyValue += ((currentDateD == DateFormat("dd-MM-yyyy").format(a.x))
              ? a.y
              : 0);
          weeklyValue += ((currentDateW == weekNumber(a.x)) ? a.y : 0);
          monthlyValue +=
              ((currentDateM == DateFormat("MM-yyyy").format(a.x)) ? a.y : 0);
        }
        for (var ele in topproductsall.keys) {
          if (currentDateD == DateFormat("dd-MM-yyyy").format(ele)) {
            for (var d in topproductsall[ele]) {
              if (topproductdaily.keys.contains(d['productName'])) {
                topproductdaily[d['productName']] =
                    topproductdaily[d['productName']]! +
                        double.parse(d['quantity']);
              } else {
                topproductdaily[d['productName']] = 1;
              }
            }
          }
          if (currentDateW == weekNumber(ele)) {
            for (var d in topproductsall[ele]) {
              if (topproductweekly.keys.contains(d['productName'])) {
                topproductweekly[d['productName']] =
                    topproductweekly[d['productName']]! +
                        double.parse(d['quantity']);
              } else {
                topproductweekly[d['productName']] = 1;
              }
            }
          }
          if (currentDateM == DateFormat("MM-yyyy").format(ele)) {
            for (var d in topproductsall[ele]) {
              if (topproductmonthly.keys.contains(d['productName'])) {
                topproductmonthly[d['productName']] =
                    topproductmonthly[d['productName']]! +
                        double.parse(d['quantity']);
              } else {
                topproductmonthly[d['productName']] = 1;
              }
            }
          }
        }
        topproduct
            .addAll([topproductdaily, topproductweekly, topproductmonthly]);
        emit(SalesDashBoardLoadedState(allOrderHistory, allData, dailyValue,
            weeklyValue, monthlyValue, pie, topproduct));
      } catch (err) {
        emit(SalesDashboardErrorState(
            "Some Error Occur $err")); //calls state and stores message through parameter
      }
    });
  }
  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }
}

class SalesData {
  SalesData(this.x, this.y);

  final DateTime x;
  final double y;
}
