import 'package:flutter/material.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.url,
    this.height,
    this.backgroundColor = Colors.black,
  });

  final String? url;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isValidUrl = url != null && url!.trim().isNotEmpty;
    return Container(
      color: backgroundColor,
      height: height, // 建議保留固定高度
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: isValidUrl
              ? Image.network(
            url!,
            fit: BoxFit.cover, // 建議使用 cover 讓圖片填滿容器
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                StringDefault.imageDefaultUrl,
                fit: BoxFit.cover,
              );
            },
          )
              : Image.asset(
            StringDefault.imageDefaultUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}