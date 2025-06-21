import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/article.dart';
import 'package:mirrordaily_app/app/widgets/draft_js_widget_factory/widget/audio_widget/audio_widget_controller.dart';
import 'package:mirrordaily_app/core/extensions/duration_extension.dart';
import 'package:mirrordaily_app/core/theme/custom_color_theme.dart';
import 'package:mirrordaily_app/core/values/image_path.dart';
import 'package:mirrordaily_app/core/values/string.dart';

class AudioWidget extends StatelessWidget {
  final ApiData apiData;

  const AudioWidget({super.key, required this.apiData});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<AudioWidgetController>(
        AudioWidgetController(apiData.contentMap?['audio']['audioSrc']),
        tag: apiData.id);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          InkWell(
            onTap: controller.onPlayPauseButtonClick,
            child: Obx(() {
              final audioPlayState = controller.rxAudioPlayerState.value;
              return SvgPicture.asset(
                audioPlayState == PlayerState.playing
                    ? ImagePath.audioWidgetPauseIcon
                    : ImagePath.audioWidgetPlayIcon,
                width: 64,
                height: 64,
              );
            }),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(apiData.contentMap?['audio']['name'],
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: CustomColorTheme.nature20)),
                Obx(() {
                  final duration = controller.rxnAudioDuration.value;
                  final position = controller.rxnAudioPosition.value;
                  return SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 6.0,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                      thumbColor: Colors.transparent,
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 0.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Slider(
                        min: 0.0,
                        max: duration?.inSeconds.toDouble() ?? 0,
                        value: position?.inSeconds.toDouble() ?? 0,
                        activeColor: CustomColorTheme.primary0,
                        inactiveColor: CustomColorTheme.natureVariant80,
                        onChangeStart: controller.slideBarValueChangeStart,
                        onChanged: controller.slideBarValueChange,
                        onChangeEnd: controller.slideBarValueChangeEnd,
                      ),
                    ),
                  );
                }),
                Obx(() {
                  final duration = controller.rxnAudioDuration.value;
                  final position = controller.rxnAudioPosition.value;
                  return Text(
                    '${position?.formatTime() ?? '00:00'} | ${duration?.formatTime() ?? StringDefault.nullString} ',
                    style: Get.textTheme.labelMedium
                        ?.copyWith(color: CustomColorTheme.nature20),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
