import 'package:flutter/material.dart';

class MarqueeWidget extends StatelessWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  MarqueeWidget({super.key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 10000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
  });

  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    _scroll();
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: direction,
      controller: _scrollController,
      child: child,
    );
  }

  void _scroll() async {
    await Future.delayed(pauseDuration);
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: animationDuration,
          curve: Curves.easeIn);
    }
  }
}
