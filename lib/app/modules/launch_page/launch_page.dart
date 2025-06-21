import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorTheme.primary0,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SvgPicture.asset(
                    ImagePath.mirrorNesNetworkLogo,
                    width: constraints.maxWidth,
                    fit: BoxFit.contain,
                  );
                },
              ),
              const SizedBox(height: 24), // 圖片與文字的間距
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'loading...',
                    style: Get.textTheme.titleSmall?.copyWith(
                        color: CustomColorTheme.primary30,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
