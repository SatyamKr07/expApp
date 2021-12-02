import 'package:better_player/better_player.dart';
import 'package:commentor/src/central/services/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class BuildBetterPlayer extends StatefulWidget {
  BuildBetterPlayer({Key? key, required this.videoUrl, this.isEditPage = false})
      : super(key: key);
  String videoUrl;
  bool isEditPage;

  @override
  State<BuildBetterPlayer> createState() => _BuildBetterPlayerState();
}

class _BuildBetterPlayerState extends State<BuildBetterPlayer> {
  late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    super.initState();
    logger.d("better_player initState");
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      widget.isEditPage
          ? BetterPlayerDataSourceType.file
          : BetterPlayerDataSourceType.network,
      widget.videoUrl,
      cacheConfiguration: const BetterPlayerCacheConfiguration(
        useCache: true,
        preCacheSize: 10 * 1024 * 1024,
        maxCacheSize: 10 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,

        ///Android only option to use cached video between app sessions
        key: "testCacheKey",
      ),
    );
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        fit: BoxFit.cover,
        aspectRatio: 4 / 3,
        showPlaceholderUntilPlay: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          controlBarColor: Colors.white10,
          controlsHideTime: Duration(milliseconds: 1),
          showControlsOnInitialize: false,
        ),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    super.dispose();
    logger.d("better_player dispose");
    _betterPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: Get.width,
            height: Get.width * 3 / 4,
            child: BetterPlayer(
              controller: _betterPlayerController,
            ),
          ),
        ),
      ),
    );
  }
}
