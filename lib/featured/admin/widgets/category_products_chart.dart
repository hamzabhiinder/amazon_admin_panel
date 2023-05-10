// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/sale_model.dart';

class CategoryProductCart extends StatelessWidget {
  final List<CartesianSeries> seriesList;
  const CategoryProductCart({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            series: seriesList,
          //   series: <CartesianSeries>[
          // ColumnSeries<Sales, String>(
          //     // Bind data source
          //     dataSource: <Sales>[
          //       Sales(label: 'Jan', earning: 35),
          //       Sales(label: 'Feb', earning: 28),
          //       Sales(label: 'Mar', earning: 34),
          //       Sales(label: 'Apr', earning: 32),
          //       Sales(label: 'May', earning: 40)
          //     ],
          //     xValueMapper: (Sales sales, _) => sales.label,
          //     yValueMapper: (Sales sales, _) => sales.earning)
        // ]
        ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
