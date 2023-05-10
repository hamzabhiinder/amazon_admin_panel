import 'package:admin_panel/featured/account/services/account_services.dart';
import 'package:admin_panel/featured/account/widget/account_button.dart';
import 'package:flutter/cupertino.dart';

class TopButtonAccount extends StatelessWidget {
  const TopButtonAccount({super.key});

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
            AccountButton(
                text: "Log Out", onTap: () => AccountService().logOut(context)),
            AccountButton(text: "Your Wish List", onTap: () {}),
          ],
        ),
      ],
    );
  }
}
