import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

class ViewValidations extends StatelessWidget {
  final DeckConfig config;

  ViewValidations({@required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validations'),
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
