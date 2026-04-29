import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final double? space;
  final TextDecoration? decoration;
  final Color? decColor;
  final double? decthick;

  const MyText({
    super.key,
    required this.text,
    this.size,
    this.weight,
    this.color,
    this.align,
    this.space,
    this.decoration,
    this.decColor,
    this.decthick,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? Colors.black,
        letterSpacing: space,
        decoration: decoration,
        decorationColor: decColor,
        decorationThickness: decthick,
      ),
    );
  }
}
