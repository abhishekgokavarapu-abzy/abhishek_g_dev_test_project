import 'package:abhishek_g_dev_test_project/modules/dashboard/providers/dashboard_Provider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Provider.of<DashboardProvider>(context, listen: false).setVideoAvailable(false);
        showDialog(
          context: context,
          builder: (context) => Consumer<DashboardProvider>(
            builder: (context, appData, widget) => appData.isLoading
                ? AlertDialog(
                    content: LinearProgressIndicator(),
                  )
                : AlertDialog(
                    title: Center(child: Text('Select Choice')),
                    content: appData.isVideoAvailable
                        ? VideoPlayer(
                            videoPlayerController:
                                appData.videoPlayerController,
                            chewieController: appData.getChewieController(),
                          )
                        : SizedBox(height: 10,),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                appData.record(context, appData);
                              },
                              child: Text('Record')),
                          ElevatedButton(
                              onPressed: () {
                                appData.choose(context, appData);
                              },
                              child: Text('Choose'))
                        ],
                      ),
                    ],
                  ),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}

class VideoPlayer extends StatefulWidget {
  final videoPlayerController;
  final chewieController;
  VideoPlayer(
      {@required this.videoPlayerController, @required this.chewieController});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    widget.chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Chewie(controller: widget.chewieController),
    );
  }
}
