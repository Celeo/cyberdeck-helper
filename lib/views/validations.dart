import 'package:flutter/material.dart';

import 'package:cyberdeck_helper/rules.dart';

class ViewValidations extends StatelessWidget {
  final DeckConfig config;

  ViewValidations({@required this.config});

  @override
  Widget build(BuildContext context) {
    final errors = validateConfig(config);
    final noErrorsText = Center(
      child: Text(
        'No errors',
        style: TextStyle(fontSize: 30.0),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Validations'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: errors.length == 0
              ? [noErrorsText]
              : errors
                  .map(
                    (e) => Text(e,
                        style: TextStyle(color: Colors.red, fontSize: 18.0)),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
