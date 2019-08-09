import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

class _ProgramViewConfigurationState extends State<ProgramViewConfiguration> {
  SituationConfig situation;

  _ProgramViewConfigurationState({@required this.situation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Programs')),
      body: Container(
          // TODO
          ),
    );
  }
}

class ProgramViewConfiguration extends StatefulWidget {
  final SituationConfig situation;

  ProgramViewConfiguration({Key key, @required this.situation})
      : super(key: key);

  @override
  _ProgramViewConfigurationState createState() =>
      _ProgramViewConfigurationState(situation: this.situation);
}
