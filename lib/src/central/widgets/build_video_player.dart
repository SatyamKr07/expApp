import 'dart:io';

import 'package:commentor/src/central/services/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BuildVideoPlayer extends StatefulWidget {
  BuildVideoPlayer({Key? key, required this.videoUrl, this.isEditPage = false})
      : super(key: key);
  String videoUrl;
  bool isEditPage;

  @override
  State<BuildVideoPlayer> createState() => _BuildVideoPlayerState();
}

class _BuildVideoPlayerState extends State<BuildVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    if (widget.isEditPage) {
      logger.d("local video file");
      _videoPlayerController = VideoPlayerController.file(File(widget.videoUrl))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          // WidgetsBinding.instance!.addPostFrameCallback((_) {
          setState(() {
            logger.d("_videoPlayerController.initilized()");

            // _videoPlayerController.play();
          });
        });
    } else {
      logger.d("network video");
      var parsedVideoUrl = (widget.videoUrl);
      _videoPlayerController = VideoPlayerController.network(parsedVideoUrl)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            _videoPlayerController.play();
          });
        });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    logger.d("_videoPlayerController.dispose()");
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? InkWell(
            onTap: () {
              setState(() {
                _videoPlayerController.value.isPlaying
                    ? _videoPlayerController.pause()
                    : _videoPlayerController.play();
              });
            },
            child: AspectRatio(
              aspectRatio: 1,
              // aspectRatio: _videoPlayerController.value.aspectRatio,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoPlayerController.value.size.width,
                        height: _videoPlayerController.value.size.height,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    ),
                  ),
                  // VideoPlayer(_videoPlayerController),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _videoPlayerController.value.isPlaying
                        ? const Icon(
                            Icons.pause_circle_outline_outlined,
                            size: 48,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_circle_outline_outlined,
                            size: 48,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
