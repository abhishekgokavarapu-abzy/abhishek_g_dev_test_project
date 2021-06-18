import 'package:flutter/material.dart';

class DashboardScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            child: Text('Hi'),
          )
        ],
      ),
    );
  }
}
