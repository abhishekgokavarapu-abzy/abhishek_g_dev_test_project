import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:path/path.dart' as dartPath;

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

    ChewieController getChewieController(){
        return ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: true,
            looping: false,
        );
    }

    upload(PickedFile videoFile, DashboardProvider appData,
        BuildContext context) async {
        print(videoFile.path);
        final File finalFile = File(videoFile.path);
        final fileName = dartPath.basename(videoFile.path);
        final destination = 'files/$fileName';
        final fireBaseReference = FirebaseStorage.instance.ref(destination);
        final uploadedTask = fireBaseReference.putFile(finalFile);
        appData.setVideoAvailable(false);
        final snapshot = await uploadedTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        appData.saveVideoUrl(urlDownload);
        appData.setVideoAvailable(true);
        await appData.initializeVideoController();
        appData.setLoading(false);
    }

    record(BuildContext context, DashboardProvider appData) async {
        PickedFile? videoFile =
        await ImagePicker.platform.pickVideo(source: ImageSource.camera, maxDuration: Duration(seconds: 30));

        if (videoFile != null) {
            upload(videoFile, appData, context);
        } else{
            print('Video Not Selected');
        }
        setLoading(false);
    }

    choose(BuildContext context, DashboardProvider appData) async {
        PickedFile? videoFile =
        await ImagePicker.platform.pickVideo(source: ImageSource.gallery,);
        if (videoFile != null) {
            var fileSizeLimit = 51200;
            File toBeCheckedFile = File(videoFile.path);
            var lengthSync = toBeCheckedFile.lengthSync();
            var fileSizeInKb = lengthSync/1024;
            var fileSizeInMb = fileSizeInKb / 1024;
            print('$fileSizeInMb MB');
            if(fileSizeInKb < fileSizeLimit){
                upload(videoFile, appData, context);
            } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('File size exceeded 100 mb')));
            }
        } else
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Video not selected')));

        setLoading(false);
    }

}