import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;

  const DialogWidget({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = "確認",
    this.cancelText = "取消",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        title,
        style:Get.textTheme.titleMedium,
      ),
      content: Text(
        content,
        style: Get.textTheme.labelLarge,
      ),
      actions: [
        // TextButton(
        //   onPressed: () => Navigator.of(context).pop(false),
        //   child: Text(cancelText),
        // ),
        // ElevatedButton(
        //   onPressed: () => Navigator.of(context).pop(true),
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blue,
        //     shape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        //   ),
        //   child: Text(confirmText),
        // ),
      ],
    );
  }
}