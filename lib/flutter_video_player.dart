library flutter_video_player;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FlutterVideoPlayer extends StatefulWidget {
  const FlutterVideoPlayer({super.key});

  @override
  State<FlutterVideoPlayer> createState() => _FlutterVideoPlayerState();
}

class _FlutterVideoPlayerState extends State<FlutterVideoPlayer> {
  final VideoPlayerController _controller = VideoPlayerController.networkUrl(
    Uri.parse(
      'https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/level_0.m3u8',
    ),
  );

  _init() async {
    await _controller.initialize();
    setState(() {});
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    _init();
    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        // _controller.play();
      }
      // print(_controller.value.buffered);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          : Container(),
    );
  }
}
