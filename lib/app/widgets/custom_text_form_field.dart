import 'package:flutter/material.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.maxLines,
      this.validator,
      this.onSaved});

  final TextEditingController? controller;
  final int? maxLines;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,

      controller: controller,
      style: CustomTextStyle.subtitleMedium.copyWith(fontSize: 14),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          // 圓角設為12px
          borderSide: const BorderSide(
            color: Colors.blue, // 外框顏色
            width: 2.0, // 外框寬度
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          // 圓角設為12px
          borderSide: const BorderSide(
            color: Colors.grey, // 預設外框顏色
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Colors.blue, // 聚焦時的外框顏色
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
