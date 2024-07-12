import 'package:flutter/material.dart';

class SlideShowWidget extends StatelessWidget {
  const SlideShowWidget({super.key, required this.imageListMap});

  final List<dynamic> imageListMap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
        itemBuilder: (context, index) {
          return Image.network(imageListMap[index]['resized']['w800']);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemCount: imageListMap.length);
  }
}
