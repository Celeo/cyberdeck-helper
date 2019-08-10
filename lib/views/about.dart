import 'package:flutter/material.dart';

class ViewAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            Text(
              'TODO',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
