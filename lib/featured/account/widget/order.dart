import 'dart:developer';

import 'package:admin_panel/common/loader.dart';
import 'package:admin_panel/featured/account/services/account_services.dart';
import 'package:admin_panel/featured/account/widget/single_product.dart';
import 'package:flutter/cupertino.dart';

import '../../../constant/global_variable.dart';
import '../../../model/orderModel.dart';
import '../../order_detail/screen/order_detail_screen.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<OrderModel>? order;
  final AccountService accountService = AccountService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    order = await accountService.fetchMyOrder(context: context);
    log("Order .length = ${order!.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return order == null
        ? Loader()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Order",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: GlobalVariables.selectedNavBarColor),
                    )
                  ],
                ),
              ),
              //Display Order

              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: order!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreen.routeName,
                          arguments: order![index],
                        );
                      },
                      child: SingleProduct(
                        imgSrc: order![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
