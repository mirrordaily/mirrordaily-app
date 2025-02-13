import 'package:flutter/material.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/theme/custom_text_style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveStreamWidget extends StatelessWidget {
  final String title;
  final YoutubePlayerController? ytPlayer;

  const LiveStreamWidget(
      {Key? key, required this.title, required this.ytPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ytPlayer != null
        ? Container(
            color: CustomColorTheme.secondary95,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    '直播',
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.subtitleMedium.copyWith(
                        color: CustomColorTheme.primary10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 16),
                YoutubePlayer(
                  controller: ytPlayer!,
                  showVideoProgressIndicator: false,
                  bottomActions: const [],
                ),
                const SizedBox(
                  height: 42,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
