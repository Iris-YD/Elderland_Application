import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.press,
  }) : super(key: key);

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: press,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          '$text',
          style: TextStyle(
            color: textColor,fontSize: 24
          ),
        ),
      ),
    );
  }
}