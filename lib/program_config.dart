import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

class _ProgramViewConfigurationState extends State<ProgramViewConfiguration> {
  SituationConfig situation;

  _ProgramViewConfigurationState({@required this.situation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: allPrograms.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(allPrograms[index]),
          trailing: Icon(situation.runningPrograms.contains(allPrograms[index])
              ? Icons.check
              : null),
          onTap: () {
            setState(() {
              final name = allPrograms[index];
              if (situation.runningPrograms.contains(name)) {
                situation.runningPrograms.remove(name);
              } else {
                situation.runningPrograms.add(name);
              }
            });
          },
        ),
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
