import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';

class _ProgramViewConfigurationState extends State<ProgramViewConfiguration> {
  DeckConfig config;

  _ProgramViewConfigurationState({@required this.config});

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
          title: Text(allPrograms[index][0]),
          subtitle: Text(allPrograms[index][1]),
          trailing: Icon(config.runningPrograms.contains(allPrograms[index][0])
              ? Icons.check
              : null),
          onTap: () {
            setState(() {
              final name = allPrograms[index][0];
              if (config.runningPrograms.contains(name)) {
                config.runningPrograms.remove(name);
              } else {
                config.runningPrograms.add(name);
              }
            });
          },
        ),
      ),
    );
  }
}

class ProgramViewConfiguration extends StatefulWidget {
  final DeckConfig config;

  ProgramViewConfiguration({Key key, @required this.config}) : super(key: key);

  @override
  _ProgramViewConfigurationState createState() =>
      _ProgramViewConfigurationState(config: this.config);
}
