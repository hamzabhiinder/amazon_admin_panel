
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
        height: 35,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 144, 226, 221),
              Color.fromARGB(255, 162, 236, 233)
            ],
            stops: [0.5, 1.0],
          ),
        ),
        // child: ListTile(
        //   leading: const Icon(
        //     Icons.location_on_outlined,
        //     size: 20,
        //   ),
        //   title: Text(
        //     "Delivery to ${user.name} - ${user.address}",
        //     overflow: TextOverflow.ellipsis,
        //     style: const TextStyle(
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        //   trailing: const Icon(
        //     Icons.arrow_drop_down_outlined,
        //     size: 20,
        //   ),
        // ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.location_on_outlined,
                size: 20,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Delivery to ${user.name} - ${user.address}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down_outlined,
              size: 20,
            ),
          ],
        ));
  }
}
