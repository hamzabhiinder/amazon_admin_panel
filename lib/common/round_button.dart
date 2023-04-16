import 'package:admin_panel/constant/global_variable.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String tilte;
  final bool isLoading;
  final VoidCallback onPressed;
  const RoundButton(
      {super.key,
      required this.tilte,
      this.isLoading = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: GlobalVariables.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white))
                : Text(
                    tilte,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
