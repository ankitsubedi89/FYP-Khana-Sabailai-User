import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {Key? key,
      required this.label,
      this.controller,
      this.prefixIcon,
      this.isObscure = false,
      this.onChanged,
      this.hint = ''})
      : super(key: key);

  final String label;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool isObscure;
  final Function(String)? onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
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
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: Color(0xffbdc2cb),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: prefixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
