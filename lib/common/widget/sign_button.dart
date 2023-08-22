import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? buttoncolor, textcolor;
  final String buttonText;
  final IconData? iconData;
  final VoidCallback onPressed;

  const CustomButton(
      {Key? key,
      required this.buttoncolor,
      required this.textcolor,
      required this.buttonText,
      required this.onPressed, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(

        style: ElevatedButton.styleFrom(backgroundColor: buttoncolor,minimumSize: const Size(double.infinity, 45)),
        onPressed: onPressed,
        icon: Icon(iconData,color: textcolor,),
        label:  Text(
      buttonText,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: textcolor),
    ),
    );
  }
}
