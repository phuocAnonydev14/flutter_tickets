import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app/base/res/styles/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onTap;
  final String label;

  const PrimaryButton({super.key, this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppStyles.findTicketColor),
        child: Center(
          child: Text(
            label,
            style: AppStyles.textStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
