import 'package:abhishek_g_dev_test_project/modules/dashboard/providers/dashboard_Provider.dart';
import 'package:abhishek_g_dev_test_project/modules/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableProvider<DashboardProvider>(
      create: (context) => DashboardProvider(),
      child: MaterialApp(
        title: 'Abhishek_G_Dev_Test',
        home: DashboardScreen(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
