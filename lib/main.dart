import 'package:cyberdeck_helper/main_components.dart';
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
    final prefs = await SharedPreferences.getInstance();
    var charConfig = CharacterConfig.starting();
    charConfig.logic = prefs.getInt('logic') ?? 1;
    charConfig.willpower = prefs.getInt('willpower') ?? 1;
    charConfig.deck = prefs.getString('deck');
    charConfig.jack = prefs.getString('jack');
    var sitConfig = SituationConfig.starting();
    sitConfig.runningPrograms = prefs.getStringList('programs') ?? [];
    setState(() {
      character = charConfig;
      situation = sitConfig;
    });
  }

  void saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('logic', character.logic);
    prefs.setInt('willpower', character.willpower);
    prefs.setString('deck', character.deck);
    prefs.setString('jack', character.jack);
    prefs.setStringList('programs', situation.runningPrograms);
  }

  @override
  Widget build(BuildContext context) {
    final asdf = getValidASDF();
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
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
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
            buildASDFDisplayRow(setState, situation, asdf),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Noise'),
                        controller: TextEditingController(
                            text: situation.noise.toString() ?? '0'),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              situation.noise = int.parse(val);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Matrix mode',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<MatrixMode>(
                      value: situation.mode ?? MatrixMode.AR,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            situation.mode = val;
                          });
                        }
                      },
                      items: MatrixMode.values
                          .map((e) => DropdownMenuItem<MatrixMode>(
                                value: e,
                                child: Text(e.toString().split('.')[1]),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<int> getValidASDF() {
    Set<int> values = Set.from([0]);
    if (character.deck != null) {
      final parts = character.deck
          .split(': ')[1]
          .split(' ')[1]
          .replaceFirst(',', '')
          .split('/');
      values.add(int.parse(parts[0]));
      values.add(int.parse(parts[1]));
    }
    if (character.jack != null) {
      final parts = character.jack
          .split(': ')[1]
          .split(' ')[1]
          .replaceFirst(',', '')
          .split('/');
      values.add(int.parse(parts[0]));
      values.add(int.parse(parts[1]));
    }
    return List.from(values)..sort();
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}
