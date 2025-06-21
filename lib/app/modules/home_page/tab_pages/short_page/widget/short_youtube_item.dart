import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mirrordaily_app/configs/environment.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShortYoutubeItem extends StatefulWidget {
  const ShortYoutubeItem({super.key, required this.videoId});

  final String videoId;

  @override
  State<ShortYoutubeItem> createState() => _ShortYoutubeItemState();
}

class _ShortYoutubeItemState extends State<ShortYoutubeItem> {
  YoutubePlayerController? youtubePlayerController;

  @override
  void initState() {
    super.initState();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        showLiveFullscreenButton: false
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: youtubePlayerController!,
    );
  }

  @override
  void dispose() {
    super.dispose();
    youtubePlayerController?.pause();
  }
}
