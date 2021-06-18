import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class DashboardProvider extends ChangeNotifier{

    bool _isVideoAvailable = false;
    bool get isVideoAvailable => _isVideoAvailable;
    setVideoAvailable(bool value){_isVideoAvailable = value; notifyListeners();}

    bool _isLoading = false;
    bool get isLoading => _isLoading;
    setLoading(bool value){_isLoading = value; notifyListeners();}

    String? _videoUrl;
    get videoUrl => _videoUrl;
    saveVideoUrl(String url){ _videoUrl = url;}

    var _videoPlayerController;
    get videoPlayerController => _videoPlayerController;
    initializeVideoController() async {
        _videoPlayerController = VideoPlayerController.network(videoUrl);
        await _videoPlayerController.initialize();
    }

    var _chewieController;
    ChewieController getChewieController(){
        return ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: true,
            looping: false,
        );
    }
}