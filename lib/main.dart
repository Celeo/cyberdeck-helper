import 'package:flutter/material.dart';
import 'package:cyberdeck_helper/rules.dart';
import 'package:cyberdeck_helper/configuration.dart';

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
            Text(character.deck == null ? 'No deck selected' : character.deck),
            Text(character.jack == null ? 'No jack selected' : character.jack),
            RaisedButton(
              child: Text('Configure'),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewConfiguration(character: character),
                  ),
                );
                // TODO save selection
              },
            ),
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
