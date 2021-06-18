import 'dart:io';
import 'package:abhishek_g_dev_test_project/modules/dashboard/providers/dashboard_Provider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as dartPath;
import 'package:provider/provider.dart';

class FAB extends StatefulWidget {
  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> {
  @override
  Widget build(BuildContext context) {
    _upload(PickedFile videoFile, DashboardProvider appData,
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

    _record(BuildContext context, DashboardProvider appData) async {
      PickedFile? videoFile =
          await ImagePicker.platform.pickVideo(source: ImageSource.camera, maxDuration: Duration(seconds: 30));

      if (videoFile != null) {
        _upload(videoFile, appData, context);
      } else
        print('Video Not Selected');
    }

    _choose(BuildContext context, DashboardProvider appData) async {
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
          _upload(videoFile, appData, context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('File size exceeded 100 mb')));
        }
      } else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Video not selected')));
    }


    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => Consumer<DashboardProvider>(
                  builder: (context, appData, widget) => appData.isLoading? AlertDialog(content: LinearProgressIndicator(),) :AlertDialog(
                    title: Center(child: Text('Select Choice')),
                    content: appData.isVideoAvailable? Container(height: 300.0, child: Chewie(controller: appData.getChewieController()),):null,
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                appData.setLoading(true);
                                _record(context, appData);
                              },
                              child: Text('Record')),
                          ElevatedButton(
                              onPressed: () {
                                appData.setLoading(true);
                                _choose(context, appData);
                              },
                              child: Text('Choose'))
                        ],
                      ),
                    ],
                  ),
                ));
      },
      child: Icon(Icons.add),
    );
  }
}
