import 'package:abhishek_g_dev_test_project/modules/dashboard/providers/dashboard_Provider.dart';
import 'package:abhishek_g_dev_test_project/modules/dashboard/widgets/app_bar.dart';
import 'package:abhishek_g_dev_test_project/modules/dashboard/widgets/dashboard_screen_body.dart';
import 'package:abhishek_g_dev_test_project/modules/dashboard/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DashboardScreen extends StatelessWidget {
  static const String id = 'dashboard_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, appData, widget)=>Scaffold(
        appBar: getAppBar(),
        body: DashboardScreenBody(),
        floatingActionButton: FAB(),
      ),
    );
  }
}


