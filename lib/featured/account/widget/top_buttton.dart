
import 'package:admin_panel/featured/account/widget/account_button.dart';
import 'package:flutter/cupertino.dart';

class TopButtonAccount extends StatefulWidget {
  const TopButtonAccount({super.key});

  @override
  State<TopButtonAccount> createState() => _TopButtonAccountState();
}

class _TopButtonAccountState extends State<TopButtonAccount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Order", onTap: () {}),
            AccountButton(text: "Turn Seller  ", onTap: () {}),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            AccountButton(text: "Log Out", onTap: () {}),
            AccountButton(text: "Your Wish List", onTap: () {}),
          ],
        ),
      ],
    );
  }
}
