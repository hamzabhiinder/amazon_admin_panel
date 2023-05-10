import 'package:admin_panel/common/customButton.dart';
import 'package:admin_panel/featured/admin/services/admin_services.dart';
import 'package:admin_panel/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../constant/global_variable.dart';
import '../../../model/orderModel.dart';
import '../../search/screen/search_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = "/order-detail";
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  ////!!!!ONLY FOR ADMIN!!!!////////////
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 12),
                  child: Material(
                    borderRadius: BorderRadius.circular(6),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                child: const Padding(
                  padding: EdgeInsets.only(right: 10, left: 15),
                  child: Icon(
                    Icons.mic_outlined,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View Order Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black12,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Date:          ${DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(widget.order.orderedAt)),
                      )}",
                    ),
                    Text("Order ID:           ${widget.order.id}"),
                    Text("Order Total:       \$${widget.order.totalPrice}"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Purchase Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black12,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            "${widget.order.products[i].images[0]}",
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Qty: ${widget.order.quantity[i]}"),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black12,
                )),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == "admin") {
                      return CustomButton(
                        text: "Done",
                        onTap: () => changeOrderStatus(details.currentStep),
                      );
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: const Text("Pending"),
                      content:
                          const Text("Your Order has yet to be delivered!"),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Complete"),
                      content: const Text(
                          "Your Order has been delivered, you are yet to sign it!"),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Recieved"),
                      content: const Text(
                          "Your Order has been delivered and Signed by You!"),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Delivered"),
                      content: const Text("Your Order has delivered!"),
                      isActive: currentStep >= 3,
                      state: currentStep > 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
