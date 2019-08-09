import 'package:cyberdeck_helper/program_config.dart';
import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';
import 'package:cyberdeck_helper/char_deck_config.dart';

void main() => runApp(App());

const appName = 'Cyberdeck Helper';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePageState extends State<HomePage> {
  var character = CharacterConfig.starting();
  var situation = SituationConfig.starting();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Configure character/gear'),
              color: Colors.green,
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CharGearViewConfiguration(character: character),
                  ),
                );
                // TODO save selection
              },
            ),
            RaisedButton(
              child: Text('Configure Programs'),
              color: Colors.green,
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProgramViewConfiguration(situation: situation),
                  ),
                );
                // TODO save selection
              },
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}
