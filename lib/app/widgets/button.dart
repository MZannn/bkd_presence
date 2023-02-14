import 'package:bkd_presence/app/themes/constants.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  const Button({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41,
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          elevation: 0,
        ),
        child: child,
      ),
    );
  }
}
