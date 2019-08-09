import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cyberdeck_helper/program_config.dart';
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

enum _AppBarDropdownOptions {
  CharacterGear,
  Programs,
  About,
}

class HomePageState extends State<HomePage> {
  var character = CharacterConfig.starting();
  var situation = SituationConfig.starting();

  @override
  void initState() {
    super.initState();
    _afterInitState();
  }

  void _afterInitState() async {
    final config = await loadConfig();
    setState(() {
      character = config;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        actions: <Widget>[
          PopupMenuButton<_AppBarDropdownOptions>(
            onSelected: (choice) async {
              if (choice == null) {
                return;
              }
              if (choice == _AppBarDropdownOptions.CharacterGear) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CharGearViewConfiguration(character: character),
                  ),
                );
                saveConfig();
              } else if (choice == _AppBarDropdownOptions.Programs) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProgramViewConfiguration(situation: situation),
                  ),
                );
                saveConfig();
              } else {
                // ...
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: _AppBarDropdownOptions.CharacterGear,
                  child: Text('Character/Gear'),
                ),
                PopupMenuItem(
                  value: _AppBarDropdownOptions.Programs,
                  child: Text('Programs'),
                ),
                // PopupMenuDivider(),
                // PopupMenuItem(
                //   value: _AppBarDropdownOptions.About,
                //   child: Text('About'),
                // ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Cyberdeck',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(character.deck ?? 'not selected'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Cyberjack',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(character.jack ?? 'not selected'),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Logic',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(character.logic.toString()),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Willpower',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(character.willpower.toString()),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Foobar'),
                // ...
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('logic', character.logic);
    prefs.setInt('willpower', character.willpower);
    prefs.setString('deck', character.deck);
    prefs.setString('jack', character.jack);
  }

  Future<CharacterConfig> loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    var config = CharacterConfig.starting();
    config.logic = prefs.getInt('logic');
    config.willpower = prefs.getInt('willpower');
    config.deck = prefs.getString('deck');
    config.jack = prefs.getString('jack');
    return config;
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}
