import 'dart:io';

import 'package:admin_panel/common/customButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/custom_textfield.dart';
import '../../../common/loader.dart';
import '../../../common/round_button.dart';
import '../../../constant/global_variable.dart';
import '../../../constant/utils.dart';
import '../services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String category = "Mobiles";
  final AdminServices adminServices = AdminServices();

  @override
  void dispose() {
    productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  List<String> productCategories = [
    "Mobiles",
    "Essential",
    "Appliances",
    "Books",
    "Fashion"
  ];
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        quantity: double.parse(_quantityController.text),
        category: category,
        images: images,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final showLoader = Provider.of<ShowLoader>(context).isSignInLoading;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            "Add Product",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(height: 10),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: List.generate(
                          images.length,
                          (index) => Image.file(
                            images[index],
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_outlined,
                                  size: 40,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Select Product Image",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                    controller: productNameController,
                    hintText: "Product Name"),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: "Discription",
                  maxLines: 5,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _priceController,
                  hintText: "Price",
                  textType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  textType: TextInputType.number,
                  controller: _quantityController,
                  hintText: "quantity",
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onTap: () {
                    sellProduct();
                  },
                  text: "Sell",
                  isLoading: showLoader,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
