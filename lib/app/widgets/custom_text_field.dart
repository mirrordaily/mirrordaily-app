import 'package:flutter/material.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.controller, this.maxLines});

  final TextEditingController? controller;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      style: CustomTextStyle.subtitleMedium.copyWith(fontSize: 14),
      scrollPhysics: const BouncingScrollPhysics(),
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
