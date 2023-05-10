import 'dart:developer';

import 'package:admin_panel/common/loader.dart';
import 'package:admin_panel/featured/admin/model/sale_model.dart';
import 'package:admin_panel/featured/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/category_products_chart.dart';

class AnalyticalScreen extends StatefulWidget {
  const AnalyticalScreen({super.key});

  @override
  State<AnalyticalScreen> createState() => _AnalyticalScreenState();
}

class _AnalyticalScreenState extends State<AnalyticalScreen> {
  @override
  int? totalSale;
  List<Sales>? earnings;
  void initState() {
    // TODO: implement initState
    getEarningData();
    super.initState();
  }

  AdminServices adminServices = AdminServices();

  void getEarningData() async {
    var earningData = await adminServices.getEarning(context);
    totalSale = earningData['totalEarning'];
    earnings = earningData['sales'];
    log("Get Earning ${totalSale}   earnings ${earnings} sales");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return totalSale == null || earnings == null
        ? Loader()
        : Column(
            children: [
              CategoryProductCart(
                seriesList: [
                  ColumnSeries<Sales, String>(
                      // Bind data source
                      dataSource: List.generate(
                        earnings!.length,
                        (index) => Sales(
                          label: earnings![index].label.toString(),
                          earning: int.parse(
                            earnings![index].earning.toString(),
                          ),
                        ),
                      ),
                      xValueMapper: (Sales sales, _) => sales.label,
                      yValueMapper: (Sales sales, _) => sales.earning)
                ],
              ),
            ],
          );
  }
}
