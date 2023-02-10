import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, required this.onPressed});

  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xff020578),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(width: 1.0, color: const Color(0xffeaeaea)),
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
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 21,
            color: Color(0xffffffff),
            fontWeight: FontWeight.w500,
          ),
          softWrap: false,
        ),
      ),
    );
  }
}
