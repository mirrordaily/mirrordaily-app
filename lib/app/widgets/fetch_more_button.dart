import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';

class FetchMoreButton extends StatelessWidget {
  const FetchMoreButton({super.key, this.title, required this.onClickButton});

  final String? title;
  final VoidCallback onClickButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            // 內邊距
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // 圓角 4px
            ),
          ),
          onPressed: onClickButton,
          child: Text(
            title ?? '看更多',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: CustomColorTheme.secondary70,
            ),
          )),
    );
  }
}
