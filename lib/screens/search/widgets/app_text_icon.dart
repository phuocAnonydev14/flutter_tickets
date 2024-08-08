import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app/base/res/styles/app_styles.dart';

class AppTextIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;
  const AppTextIcon(
      {super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppStyles.planeColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: AppStyles.textStyle,
            )
          ],
        ),
      ),
    );
  }
}
