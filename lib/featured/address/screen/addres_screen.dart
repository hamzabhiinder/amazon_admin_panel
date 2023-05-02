// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:admin_panel/featured/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:admin_panel/featured/address/screen/payment_configurations.dart';
import 'package:admin_panel/provider/user_provider.dart';

import '../../../common/customButton.dart';
import '../../../common/custom_textfield.dart';
import '../../../constant/global_variable.dart';
import '../../../constant/utils.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address-screen";
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  AddressServices addressServices = AddressServices();
  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final List<PaymentItem> _paymentItems = [];
  bool isLoding = false;
  String addressToBeUsed = "";
  @override
  void dispose() {
    super.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _flatBuildingController.dispose();
    _cityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount.toString()),
    );
  }

  void onGooglePayResult(paymentResult) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount.toString()),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pinCodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pinCodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
    log(addressToBeUsed);
  }

  @override
  void initState() {
    _paymentItems.add(PaymentItem(
      label: 'Total Amount',
      amount: widget.totalAmount,
      status: PaymentItemStatus.final_price,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "OR",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _flatBuildingController,
                    hintText: 'Flat, House no ,Building',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _areaController,
                    hintText: 'Area, Street',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _pinCodeController,
                    hintText: 'Pin Code',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _cityController,
                    hintText: 'Town/City',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            ApplePayButton(
              paymentConfiguration:
                  PaymentConfiguration.fromJsonString(defaultApplePay),
              paymentItems: _paymentItems,
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onApplePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
              onPressed: () => payPressed(address),
            ),
            const SizedBox(height: 10),
            GooglePayButton(
              width: double.infinity,
              height: 50,
              paymentConfiguration:
                  PaymentConfiguration.fromJsonString(defaultGooglePay),
              margin: const EdgeInsets.only(top: 15),
              paymentItems: _paymentItems,
              type: GooglePayButtonType.buy,
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
              onPressed: () => payPressed(address),
            ),
          ],
        ),
      ),
    );
  }
}
