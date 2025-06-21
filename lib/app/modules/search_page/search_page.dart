import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColorTheme.secondary40,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'There was an error\nprocessing this image.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(ImagePath.searchIcon),
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Text('hello search'),
        ],
      ),
    );
  }
}
