import 'package:flutter/material.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.text,
      this.isActive = true,
      required this.onClickEvent});

  final String text;
  final bool? isActive;
  final Function() onClickEvent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isActive == true
            ? CustomColorTheme.secondary90
            : CustomColorTheme.secondary95,
        backgroundColor: isActive == true
            ? CustomColorTheme.primary30
            : CustomColorTheme.secondary80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 設置圓角半徑
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 8), // 按鈕內部的 padding
      ),
      onPressed: () {
        if (isActive == false) return;
        onClickEvent();
      },
      child: Text(
        text,
        style: CustomTextStyle.subtitleSmall.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: CustomColorTheme.secondary95),
      ),
    );
  }
}
