import 'package:flutter/material.dart';
import 'package:posts/constants/colors.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget? suffixIcon;
  final bool obscure;

  const CustomFormField(
      {Key? key,
      required this.label,
      required this.controller,
      this.suffixIcon,
      this.obscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: AppColors.grey, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightBlue_20,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: AppColors.grey, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
