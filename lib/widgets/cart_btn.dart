import 'package:flutter/material.dart';

class CartBtn extends StatelessWidget {
  const CartBtn({
    Key? key,
    this.label = '-',
    this.color,
    this.textColor,
    this.onTap,
    this.labelSize = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  }) : super(key: key);

  final String label;
  final Color? color;
  final Color? textColor;
  final Function()? onTap;

  final double labelSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? const Color(0xffffffff),
          borderRadius: BorderRadius.circular(11.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: labelSize, color: textColor ?? const Color(0xff000000)),
        ),
      ),
    );
  }
}
