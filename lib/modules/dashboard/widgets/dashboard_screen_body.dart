import 'package:flutter/material.dart';

class DashboardScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          child: Text('WELCOME TO VIDEO UPLOADER', style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.w500
          ),softWrap: true,),
        ),
      ),
    );
  }
}
