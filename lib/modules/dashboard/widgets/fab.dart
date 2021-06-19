import 'package:abhishek_g_dev_test_project/modules/dashboard/providers/dashboard_Provider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAB extends StatefulWidget {
  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
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
                        ? Container(
                            height: 300.0,
                            child: Chewie(
                                controller: appData.getChewieController()),
                          )
                        : null,
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                appData.setLoading(true);
                                appData.record(context, appData);
                              },
                              child: Text('Record')),
                          ElevatedButton(
                              onPressed: () {
                                appData.setLoading(true);
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
