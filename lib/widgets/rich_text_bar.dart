import 'package:flutter/material.dart';

class RichTextBar extends StatelessWidget {
  const RichTextBar(
      {super.key,
      required this.normal,
      required this.rich,
      required this.onPressed});

  final String normal;
  final String rich;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text.rich(
        TextSpan(
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: Color(0xff000000),
          ),
          children: [
            TextSpan(
              text: normal,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: rich,
              style: const TextStyle(
                color: Color(0xff0042a6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
