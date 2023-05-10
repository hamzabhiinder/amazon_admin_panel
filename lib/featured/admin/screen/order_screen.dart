import 'package:admin_panel/common/loader.dart';
import 'package:admin_panel/featured/account/widget/single_product.dart';
import 'package:admin_panel/featured/admin/services/admin_services.dart';
import 'package:admin_panel/featured/order_detail/screen/order_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../model/orderModel.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderModel>? orderList;

  AdminServices adminService = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  fetchOrder() async {
    orderList = await adminService.fetchAllOrder(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? Loader()
        : GridView.builder(
            itemCount: orderList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orderList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailScreen.routeName,
                    arguments: orderData,
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    imgSrc: orderData.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
