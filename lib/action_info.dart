import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

class ViewActionInfo extends StatelessWidget {
  final String actionName;

  ViewActionInfo({Key key, @required this.actionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(actionName.split('(')[0].trim()),
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Text(
          getActionDescription(actionName),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
