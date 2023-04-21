import 'package:flutter/material.dart';

import '../../../common/loader.dart';
import '../../../constant/global_variable.dart';
import '../../../model/productModel.dart';
import '../../product_details/screen/product_details_screen.dart';
import '../service/home_service.dart';

class CategoryScreenDeal extends StatefulWidget {
  static const String routeName = '/categoryScreen-deal';
  final String category;
  const CategoryScreenDeal({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryScreenDeal> createState() => _CategoryScreenDealState();
}

class _CategoryScreenDealState extends State<CategoryScreenDeal> {
  HomeServices homeServices = HomeServices();
  List<ProductModel>? productList;
  @override
  void initState() {
    fetchCategoryProducts();
    super.initState();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: (productList == null ||
              productList!.isEmpty ||
              productList == "null")
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep Shopping for ${widget.category}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: productList!.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    itemBuilder: (BuildContext context, int index) {
                      final product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ProductDetailScreen.routeName,
                            arguments: product,
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    product.images[0],
                                    width: 140,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
