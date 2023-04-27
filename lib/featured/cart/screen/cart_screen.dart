import 'package:admin_panel/common/customButton.dart';
import 'package:admin_panel/featured/cart/widget/cart_product.dart';
import 'package:admin_panel/featured/cart/widget/cart_sub_total.dart';
import 'package:admin_panel/featured/home/widgets/adress_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/global_variable.dart';
import '../../../provider/user_provider.dart';
import '../../search/screen/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

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
        child: Column(
          children: [
            const AddressBox(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: "Proceed to Buy (${user.cart.length} Items)",
                onTap: () {},
                color: Colors.yellow[600],
              ),
            ),
            const SizedBox(height: 15),
            Divider(
              color: Colors.black.withOpacity(0.3),
            ),
            const SizedBox(height: 5),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (BuildContext context, int index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
