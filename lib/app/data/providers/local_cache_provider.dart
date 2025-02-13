import 'dart:convert';

import 'package:get/get.dart';
import 'package:mirrordaily_app/app/data/models/video_item.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalCacheProvider extends GetConnect {
  LocalCacheProvider._();

  static final LocalCacheProvider _instance = LocalCacheProvider._();

  static LocalCacheProvider get instance => _instance;

  final watchedVideoKey = 'watchedVideos';
  List<VideoItem> watchedVideoList = [];

  @override
  void onInit() async {
    checkWatchedListIsExpired();
  }

  Future<void> checkWatchedListIsExpired() async {
    final videoList = await getWatchedVideoList();
    videoList.removeWhere((video) {
      if (video.lastWatched == null) {
        return false;
      }
      return DateTime.now().difference(video.lastWatched!).inDays > 14;
    });
    await updateWatchedVideoList(videoList);
  }

  Future<void> updateWatchedVideo({required VideoItem videoItem}) async {
    final videoList = await getWatchedVideoList();
    if (!videoList.contains(videoItem)) {
      videoList.add(videoItem);
    }
    await updateWatchedVideoList(videoList);
  }

  Future<void> updateWatchedVideoList(List<VideoItem> videos) async {
    final prefs = await SharedPreferences.getInstance();
    final videoList = videos.map((video) {
      return {
        'id': video.id,
        'lastWatched': video.lastWatched?.toIso8601String(),
      };
    }).toList();
    prefs.setString(watchedVideoKey, jsonEncode(videoList));
  }

  Future<List<VideoItem>> getWatchedVideoList() async {
    final prefs = await SharedPreferences.getInstance();
    final watchedVideosString = prefs.getString(watchedVideoKey) ?? '[]';
    final watchedVideos = jsonDecode(watchedVideosString) as List;

    watchedVideoList = watchedVideos
        .map((video) => VideoItem(
            id: video['id'], lastWatched: DateTime.parse(video['lastWatched'])))
        .toList();
    return watchedVideoList;
  }
}
