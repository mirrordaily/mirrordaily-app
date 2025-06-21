import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key,
      required this.text,
      this.isSelect,
      required this.onClickEvent});

  final String text;
  final bool? isSelect;
  final Function() onClickEvent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: CustomColorTheme.primary10, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: isSelect == true
              ? CustomColorTheme.primary10
              : Colors.white, // 设置背景颜色
        ),
        onPressed: onClickEvent,
        child: Text(
          text,
          style: Get.textTheme.labelLarge?.copyWith(
              color:
                  isSelect == true ? Colors.white : CustomColorTheme.primary10),
        ),
      ),
    );
  }
}
