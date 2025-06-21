import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/data/models/news_marquee.dart';
import 'package:mirrordaily_app/app/widgets/news_marquee_widget/news_marquee_controller.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/string.dart';

import 'widget/marquee_widget.dart';

class NewsMarqueeWidget extends GetView<NewsMarqueeController> {
  NewsMarqueeWidget({
    super.key,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
  });

  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final CarouselOptions _options = CarouselOptions(
    scrollPhysics: const NeverScrollableScrollPhysics(),
    height: 48,
    viewportFraction: 1,
    scrollDirection: Axis.vertical,
    initialPage: 0,
    autoPlay: true,
    autoPlayInterval: const Duration(milliseconds: 5000),
    enableInfiniteScroll: false,
    enlargeCenterPage: false,
    onPageChanged: (index, reason) {},
  );

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<NewsMarqueeController>()) {
      Get.put(NewsMarqueeController());
    }
    var width = Get.width;

    return Container(
      width: width,
      color: CustomColorTheme.secondary95,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 12,
            child: Text(
              '快訊',
              style: Get.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: CustomColorTheme.tertiary0),
            ),
          ),
          Obx(() {
            final newsMarqueeList = controller.rxNewsMarqueeList.value;
            return CarouselSlider(
              items: _buildList(width, newsMarqueeList),
              carouselController: _carouselController,
              options: _options,
            );
          }),
        ],
      ),
    );
  }

  List<Widget> _buildList(double width, List<NewsMarquee> recordList) {
    List<Widget> resultList = [];
    for (int i = 0; i < recordList.length; i++) {
      resultList.add(InkWell(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 55, right: 12, top: 8, bottom: 8),
            child: MarqueeWidget(
              animationDuration: const Duration(milliseconds: 4000),
              child: Text(
                recordList[i].hotNews?.title ?? StringDefault.nullString,
                style: Get.textTheme.labelLarge?.copyWith(
                    color: CustomColorTheme.tertiary0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          onTap: () {
            controller.goToArticlePage(recordList[i].hotNews?.id);
          }));
    }
    return resultList;
  }
}
